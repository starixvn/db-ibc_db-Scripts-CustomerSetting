/*
	Created: Elodie
	Task: Copy PT & Bet Setting, Discount & WinLossLimit for BullFighting
	DB: DBCUST/CustDB
	Date: 20171101
*/ 

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@srecommend INT	
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN			

	DECLARE @fSportType SMALLINT, @fBetType SMALLINT

	DECLARE @ProductID TINYINT = 30
	CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT, IsFinished BIT)
	INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
	SELECT	1, 5, SportType, BetType, 0, SettingType, 0
	FROM dbo.ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SettingType IN (1,3,6,16)	

	CREATE TABLE #OfferedSite (site VARCHAR(10))
	INSERT INTO #OfferedSite (site)
	VALUES  ('Indo'), ('KORIBC')
	          
	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		roleid TINYINT
	)
	
	CREATE TABLE #DirectMaster (CustID INT PRIMARY KEY,roleid INT)
	CREATE TABLE #DirectAgent (CustID INT PRIMARY KEY,mrecommend INT,roleid INT)
	CREATE TABLE #DirectMember (CustID INT PRIMARY KEY,recommend INT,mrecommend INT,roleid INT)			
	--- get direct master
	INSERT INTO #DirectMaster (CustID,roleid)
	SELECT ci.custid, ci.roleid
	FROM Customer ci with(nolock)
	INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
	WHERE  EXISTS (SELECT 1 FROM #OfferedSite WHERE site = ci.site)
		AND  EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		AND ci.roleid=3 AND ci.srecommend = @srecommend 
		AND ci.custid <= @maxcustid 
		AND c.Enabled=1
		
	--- get direct agent
	INSERT INTO #DirectAgent (CustID,mrecommend,roleid)
	SELECT ci.custid, ci.mrecommend,ci.roleid
	FROM Customer ci WITH(NOLOCK)
	INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
	WHERE  EXISTS (SELECT 1 FROM #OfferedSite WHERE site = ci.site)
		AND  EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		and ci.roleid = 2 AND ci.srecommend = @srecommend 
		AND ci.custid <= @maxcustid
		AND c.Enabled=1

	INSERT INTO #DirectMember(CustID,recommend,mrecommend,roleid)
	SELECT c.custid, c.recommend,c.mrecommend,c.roleid
	FROM Customer c WITH(NOLOCK)
	INNER JOIN Customer ca (nolock) on c.recommend=ca.custid 
	INNER JOIN custInfo ci WITH(NOLOCK) ON ci.custid=c.custid
	WHERE EXISTS (SELECT 1 FROM #OfferedSite WHERE site = ca.site)
		AND EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		AND c.roleid=1 AND c.srecommend = @srecommend 		
		AND c.custid <= @maxcustid 
		AND ci.Enabled=1

	----------- For SMA  -----------
	INSERT INTO #SMATemp (CustID,RoleID)
	SELECT @srecommend, 4 -- Super
	UNION ALL
	-----------------------Master--------------------------------------
	SELECT d.CustID, 3 -- Direct Master 
	FROM #DirectMaster d	
	UNION 
	SELECT DISTINCT d.mrecommend, 3 -- Master of direct agent
	FROM #DirectAgent d
	UNION 
	SELECT DISTINCT d.mrecommend, 3 -- Master of direct member
	FROM #DirectMember D 	
	UNION 
	-----------------------Agent--------------------------------------
	SELECT ci.CustID,2 -- Agent of direct master
	FROM custInfo ci WITH (NOLOCK)
		INNER JOIN #DirectMaster D ON ci.mrecommend = d.CustID 
	WHERE ci.roleid = 2 AND ci.Enabled=1 AND ci.custid <= @maxcustid 
	UNION
	SELECT DISTINCT d.recommend, 2 -- agent of direct member
	FROM #DirectMember D 	
	UNION 
	SELECT d.CustID, 2 -- Direct Agent
	FROM #DirectAgent D
	 	
	---------- For members ---------
	INSERT INTO #MemberTemp (CustID)
	SELECT  ci.custid -- member of direct master
	FROM Custinfo ci WITH (NOLOCK)
		INNER JOIN #DirectMaster m ON ci.mrecommend = m.CustID
	WHERE ci.roleid = 1	AND ci.custid <= @maxcustid AND ci.Enabled = 1 			
	UNION ALL -- member of direct agent
	SELECT  ci.custid
	FROM Custinfo ci WITH (NOLOCK)
		INNER JOIN #DirectAgent a ON ci.recommend = a.CustID
	WHERE ci.roleid = 1 AND ci.custid <= @maxcustid AND ci.Enabled = 1 			
	-- Direct member		
	UNION ALL
	SELECT ci.custid
	FROM #DirectMember ci

	DECLARE @MaxPT TINYINT, @Currency INT--, @MaxComm DECIMAL(9,8)
	SELECT TOP 1 @MaxPT = MaxPT FROM dbo.ProductSettingDetail WITH (NOLOCK) WHERE ProductID = @ProductID AND SettingType = 1
	--SELECT TOP 1 @MaxComm = MaxDiscount FROM dbo.ProductSettingDetail WITH (NOLOCK) WHERE ProductID = @ProductID AND SettingType = 3
	SELECT @Currency = currency FROM customer WITH (NOLOCK) WHERE custid = @srecommend
	
	--------------------------------------PT Setting-------------------------------------------------	
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType 
	FROM #DestinationSportBetType		
	WHERE SettingType = 1

	--AGENT LEVEL
	INSERT INTO dbo.CustPTSetting3rd_Agent
		(	[CustID]
			,[SportType]
			,[BetType]
			,[IsLive]
			,[SuperPT]
			,[MasterPT]
			,[AgentPT]
			,[IsAutoMasterPT]
			,[AutoMasterPT]
			,[IsAutoSuperPT]
			,[AutoSuperPT]
			,[MinPT]
			,[MaxPT])
	SELECT 
		cs.custid, dest.tSportType, dest.tBetType, dest.IsLive
		,cs.spositiontaking  *100
		,cs.mpositiontaking  *100
		,cs.apositiontaking  *100
		,cs.isautompositiontaking
		,cs.autompositiontaking *100
		,cs.isautopositiontaking 
		,cs.autopositiontaking  *100
		,co.minpositiontaking  *100
		,@MaxPT
	FROM dbo.custSetting cs WITH(NOLOCK) 
		INNER JOIN dbo.CustOverride co WITH(NOLOCK) ON cs.custid = co.custid and cs.sporttype = co.sporttype and cs.bettype = co.bettype
		INNER JOIN #SMATemp ci ON ci.custid = cs.custid
		CROSS APPLY #DestinationSportBetType dest
	WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType
		AND dest.SettingType = 1
	
	--MEMBER LEVEL
	INSERT INTO dbo.CustPTSetting3rd_Member
		(	[custid]
			,	[sporttype]
			,	[bettype]
			,	[islive]
			,	[superPT]
			,	[masterPT]
			,	[agentPT]
			,	[IsAutoMasterPT]
			,	[AutoMasterPT]
			,	[IsAutoSuperPT]
			,	[AutoSuperPT])
	SELECT 
		cs.custid, dest.tSportType, dest.tBetType, dest.IsLive
		,cs.spositiontaking  *100
		,cs.mpositiontaking  *100
		,cs.apositiontaking  *100
		,cs.isautompositiontaking
		,cs.autompositiontaking *100
		,cs.isautopositiontaking 
		,cs.autopositiontaking  *100
	FROM dbo.custSetting cs WITH(NOLOCK)
		INNER JOIN #MemberTemp ci ON cs.CustID = ci.custid
		CROSS APPLY #DestinationSportBetType dest
	WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType
		AND dest.SettingType = 1	
		
	--------------------------------------Bet Setting-------------------------------------------------		
	--Agent Level
	INSERT INTO dbo.CustBetSetting3rd_Agent(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
	SELECT ci.custid, dest.tsporttype, dest.tbettype, 0, 0.1, 0.1
	FROM #SMATemp ci  
		CROSS APPLY #DestinationSportBetType dest
	WHERE dest.SettingType = 16

	--Member Level
	INSERT INTO dbo.CustBetSetting3rd_Member(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
	SELECT ci.custid, dest.tsporttype, dest.tbettype, 0, 0.1, 0.1			
	FROM #MemberTemp ci
		CROSS APPLY #DestinationSportBetType dest
	WHERE dest.SettingType = 16
	
	-----Set global bet setting for dummy acounts,  direct Master, direct Agent and direct member level-----
	--Update for dummy super
	UPDATE cs
	SET cs.MinBet = ps.DefaultMinBet,
		cs.MaxBet = ps.DefaultMaxBet,
		cs.MaxPerMatch = ps.DefaultMaxPerMatch	
	FROM dbo.CustBetSetting3rd_Agent cs 
		INNER JOIN #DestinationSportBetType dest ON dest.tSportType = cs.Sporttype AND dest.tBetType = cs.Bettype
		INNER JOIN dbo.ProductBetSetting ps WITH (NOLOCK) ON dest.tSportType = ps.Sporttype AND dest.tBetType = ps.Bettype
	WHERE ps.Currency = @Currency AND dest.SettingType = 16
		AND cs.CustID = @srecommend

	--Update for dummy master of direct agent
	UPDATE cs
	SET cs.MinBet = ps.DefaultMinBet,
		cs.MaxBet = ps.DefaultMaxBet,
		cs.MaxPerMatch = ps.DefaultMaxPerMatch	
	FROM #DirectAgent ci  
		INNER JOIN dbo.CustBetSetting3rd_Agent cs WITH (NOLOCK) ON cs.CustID = ci.mrecommend
		INNER JOIN #DestinationSportBetType dest ON dest.tSportType = cs.Sporttype AND dest.tBetType = cs.Bettype
		INNER JOIN dbo.ProductBetSetting ps WITH (NOLOCK) ON dest.tSportType = ps.Sporttype AND dest.tBetType = ps.Bettype
	WHERE ps.Currency = @Currency AND dest.SettingType = 16

	--Update for dummy master of direct member
	UPDATE cs
	SET cs.MinBet = ps.DefaultMinBet,
		cs.MaxBet = ps.DefaultMaxBet,
		cs.MaxPerMatch = ps.DefaultMaxPerMatch	
	FROM #DirectMember ci  
		INNER JOIN dbo.CustBetSetting3rd_Agent cs WITH (NOLOCK) ON cs.CustID = ci.mrecommend
		INNER JOIN #DestinationSportBetType dest ON dest.tSportType = cs.Sporttype AND dest.tBetType = cs.Bettype
		INNER JOIN dbo.ProductBetSetting ps WITH (NOLOCK) ON dest.tSportType = ps.Sporttype AND dest.tBetType = ps.Bettype
	WHERE ps.Currency = @Currency AND dest.SettingType = 16

	--Update for dummy agent
	UPDATE cs
	SET cs.MinBet = ps.DefaultMinBet,
		cs.MaxBet = ps.DefaultMaxBet,
		cs.MaxPerMatch = ps.DefaultMaxPerMatch	
	FROM #DirectMember ci  		
		INNER JOIN dbo.CustBetSetting3rd_Agent cs WITH (NOLOCK) ON cs.CustID = ci.recommend
		INNER JOIN #DestinationSportBetType dest ON dest.tSportType = cs.Sporttype AND dest.tBetType = cs.Bettype
		INNER JOIN dbo.ProductBetSetting ps WITH (NOLOCK) ON dest.tSportType = ps.Sporttype AND dest.tBetType = ps.Bettype
	WHERE ps.Currency = @Currency AND dest.SettingType = 16

	--Update for direct master, agent
	UPDATE cs
	SET cs.MinBet = ps.DefaultMinBet,
		cs.MaxBet = ps.DefaultMaxBet,
		cs.MaxPerMatch = ps.DefaultMaxPerMatch	
	FROM (SELECT custid FROM #DirectMaster UNION ALL SELECT custid FROM #DirectAgent) ci  
		INNER JOIN dbo.CustBetSetting3rd_Agent cs WITH (NOLOCK) ON cs.CustID = ci.CustID
		INNER JOIN #DestinationSportBetType dest ON dest.tSportType = cs.Sporttype AND dest.tBetType = cs.Bettype
		INNER JOIN dbo.ProductBetSetting ps WITH (NOLOCK) ON dest.tSportType = ps.Sporttype AND dest.tBetType = ps.Bettype
	WHERE ps.Currency = @Currency AND dest.SettingType = 16

	--Update for direct member
	UPDATE cs
	SET cs.MinBet = ps.DefaultMinBet,
		cs.MaxBet = ps.DefaultMaxBet,
		cs.MaxPerMatch = ps.DefaultMaxPerMatch	
	FROM #DirectMember ci  
		INNER JOIN dbo.CustBetSetting3rd_Member cs WITH (NOLOCK) ON cs.CustID = ci.CustID
		INNER JOIN #DestinationSportBetType dest ON dest.tSportType = cs.Sporttype AND dest.tBetType = cs.Bettype
		INNER JOIN dbo.ProductBetSetting ps WITH (NOLOCK) ON dest.tSportType = ps.Sporttype AND dest.tBetType = ps.Bettype
	WHERE ps.Currency = @Currency AND dest.SettingType = 16

	--------------------------------------Commission Setting-------------------------------------------------		
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType 
	FROM #DestinationSportBetType		
	WHERE SettingType = 3

	--Agent Level
	INSERT INTO dbo.CustDiscount3rd_Agent(CustID, SportType, BetType, Discount)
	SELECT ci.custid, dest.tsporttype, dest.tbettype, 
			CASE	WHEN roleid = 4 THEN cs.sdiscount
					WHEN roleid = 3 THEN cs.adiscount
					WHEN roleid = 2 THEN cs.discount END
	FROM dbo.custSetting cs WITH(NOLOCK)
		INNER JOIN #SMATemp ci  ON cs.CustID = ci.custid
		CROSS APPLY #DestinationSportBetType dest
	WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType
		AND dest.SettingType = 3
		 
	--Member Level
	INSERT INTO dbo.CustDiscount3rd_Member(CustID, SportType, BetType, PlayerDiscount, AgentDiscount, MasterDiscount, SuperDiscount)
	SELECT ci.custid, dest.tsporttype, dest.tbettype, cs.playerdiscount, cs.discount, cs.adiscount, cs.sdiscount
	FROM dbo.custSetting cs WITH(NOLOCK)
		INNER JOIN #MemberTemp ci WITH(NOLOCK) ON cs.CustID = ci.custid
		CROSS APPLY #DestinationSportBetType dest
	WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType
		AND dest.SettingType = 3

	--------------------------------------Win Loss Limit-------------------------------------------------		
	--Agent Level
	INSERT INTO dbo.CustWinLossLimit_Agent (CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
	SELECT ci.custid, dest.tsporttype, dest.tbettype, 0, cs.DefaultLossLimit, 1
	FROM #SMATemp ci WITH(NOLOCK) 
		CROSS APPLY #DestinationSportBetType dest WITH(NOLOCK) 
		CROSS APPLY dbo.LossLimit_GlobalSetting cs WITH(NOLOCK)
	WHERE dest.SettingType = 6 AND cs.ExchangeId = @Currency AND cs.ProductId = @ProductID

	--Member Level
	INSERT INTO dbo.CustWinLossLimit_Member (CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
	SELECT ci.custid, dest.tsporttype, dest.tbettype, 0, cs.DefaultLossLimit, 1
	FROM #MemberTemp ci WITH(NOLOCK) 
		CROSS APPLY #DestinationSportBetType dest WITH(NOLOCK) 
		CROSS APPLY dbo.LossLimit_GlobalSetting cs WITH(NOLOCK)
	WHERE dest.SettingType = 6 AND cs.ExchangeId = @Currency AND cs.ProductId = @ProductID

	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
	DROP TABLE #DestinationSportBetType			
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

----Get list dummy super
--SELECT DISTINCT srecommend
--FROM CustDirectAccount da WITH (NOLOCK)
--	INNER JOIN customer ci WITH(NOLOCK) ON da.CustID = ci.custid
--WHERE ci.site IN ('Indo', 'KORIBC')
--	AND ci.roleid IN (2, 3)
--UNION 
--SELECT DISTINCT ci.srecommend
--FROM CustDirectAccount da WITH (NOLOCK)
--	INNER JOIN customer ci WITH(NOLOCK) ON da.CustID = ci.custid
--	INNER JOIN customer ca WITH(NOLOCK) ON ci.recommend = ca.custid
--WHERE ca.site IN ('Indo', 'KORIBC')
--	AND ci.roleid IN (1)
--ORDER BY srecommend

INSERT INTO #supers(custid)
SELECT ci.custid
FROM dbo.Customer ci WITH(NOLOCK)
WHERE ci.custid IN (15) -- dummy account	

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'REPLICATED'
			
			
	waitfor delay '00:00:0.280'
END
GO

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 4: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM dbo.Customer ci WITH(NOLOCK)
WHERE ci.custid IN (15) -- dummy account	

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'DBCUST'
						
	waitfor delay '00:00:0.280'
END

PRINT N'Step 4: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 