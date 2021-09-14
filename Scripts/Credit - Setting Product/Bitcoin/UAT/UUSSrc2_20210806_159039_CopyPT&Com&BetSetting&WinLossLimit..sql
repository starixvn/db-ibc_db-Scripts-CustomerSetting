/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Winfred
	Date: 20210806
	Task: Copy PT & Bet & WinLossLimit for Bitcoin UUS [Redmine: 159039]
	DB: DBCUST/CustDB
	P/s : Step 2 Copy PT & Bet & WinLossLimit UUS
*/ 

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@srecommend INT	
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('ProductSettingDetail') = 0 RETURN

	DECLARE @ProductID TINYINT = 69, @Sporttype INT = 175  ,@Bettype INT  = 7901 
	DECLARE @fSportType SMALLINT, @fBetType SMALLINT, @Currency INT

	CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT,MaxPT SMALLMONEY, IsLive BIT,  SettingType INT, IsFinished BIT)
	INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType,MaxPT, IsLive, SettingType, IsFinished)
	SELECT	1, 3, SportType, BetType,MaxPT, 0, SettingType, 0
	FROM ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SportType = @Sporttype AND bettype = @Bettype AND SettingType IN (1) --  PT
	
	INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
	SELECT	1, 1, SportType, BetType, 0, SettingType, 0
	FROM ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SportType = @Sporttype AND bettype = @Bettype AND SettingType IN (3) --  Commission
	UNION ALL
	SELECT	SportType, BetType, SportType, BetType, 0, SettingType, 0
	FROM ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SportType = @Sporttype AND bettype = @Bettype AND SettingType IN (16,6) -- BetSetting, Win Loss Limit
	
	SELECT @Currency = currency FROM Custinfo WITH (NOLOCK) WHERE custid = @srecommend

	CREATE TABLE #PTTemp
	(
		CustID				INT ,
		roleid				TINYINT,
		[SportType]			SMALLINT,
		[BetType]			SMALLINT,
		[IsLive]			BIT,
		[SuperPT]			SMALLMONEY,
		[MasterPT]			SMALLMONEY,
		[AgentPT]			SMALLMONEY,
		[IsAutoMasterPT]	BIT,
		[AutoMasterPT]		SMALLMONEY,
		[IsAutoSuperPT]		BIT,
		[AutoSuperPT]		SMALLMONEY,
		[MinPT]				SMALLMONEY,
		[MaxPT]				SMALLMONEY,
		PRIMARY KEY (CustID,SportType,BetType,IsLive)
	)
	CREATE TABLE #PTTempMemBatch
	(
		CustID				INT ,
		roleid				TINYINT,
		[SportType]			SMALLINT,
		[BetType]			SMALLINT,
		[IsLive]			BIT,
		[SuperPT]			SMALLMONEY,
		[MasterPT]			SMALLMONEY,
		[AgentPT]			SMALLMONEY,
		[IsAutoMasterPT]	BIT,
		[AutoMasterPT]		SMALLMONEY,
		[IsAutoSuperPT]		BIT,
		[AutoSuperPT]		SMALLMONEY,
		[MinPT]				SMALLMONEY,
		[MaxPT]				SMALLMONEY,
		PRIMARY KEY (CustID,SportType,BetType,IsLive)
	)

	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		recommend INT, 
		mrecommend INT, 
		srecommend INT,
		InsComm BIT DEFAULT 0,
		InsBetSetting BIT DEFAULT 0,
		InsWinLoss BIT DEFAULT 0
	)
	
	CREATE TABLE #SMAList_CommSetting (custid INT PRIMARY KEY CLUSTERED, Discount DECIMAL(9,8))
	
	CREATE TABLE #MemberTempIns
	(
		CustID INT PRIMARY KEY CLUSTERED,
		recommend INT, 
		mrecommend INT, 
		srecommend INT
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		roleid TINYINT
	)

	INSERT INTO #MemberTemp (CustID ,recommend ,mrecommend ,srecommend )
	SELECT custid ,recommend ,mrecommend ,srecommend
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1  AND Enabled = 1 AND custid <= @maxcustid
	
	INSERT INTO #SMATemp (CustID, roleid)
	SELECT custid, roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND Enabled = 1 AND custid <= @maxcustid 
	

	CREATE TABLE #ProductBetSetting (Currency INT,MinBet	MONEY,MaxBet	MONEY,MaxPerMatch	MONEY,
									SuperMinBet	MONEY,SuperMaxBet	MONEY,SuperMaxPerMatch	MONEY, Sporttype INT DEFAULT(175), Bettype INT DEFAULT(7901))
					
	INSERT INTO #ProductBetSetting(Currency,MinBet,MaxBet,MaxPerMatch,SuperMinBet,SuperMaxBet,SuperMaxPerMatch)
	SELECT 20 AS Currency ,3 AS MinBet,1000 AS MaxBet,4500 AS MaxPerMatch,3 AS SuperMinBet,1500 AS SuperMaxBet,9000  AS SuperMaxPerMatch UNION  ALL --UUS---UUS
	SELECT 72 AS Currency ,50 AS MinBet,12500 AS MaxBet,75000 AS MaxPerMatch,50 AS DefaultMinBet,25000 AS DefaultMaxBet,150000  AS DefaultMaxPerMatch --YNG---YNG
		
	INSERT INTO #PTTemp(
		CustID				,
		roleid				,
		[SportType]			,
		[BetType]			,
		[IsLive]			,
		[SuperPT]			,
		[MasterPT]			,
		[AgentPT]			,
		[IsAutoMasterPT]	,
		[AutoMasterPT]		,
		[IsAutoSuperPT]		,
		[AutoSuperPT]		,
		[MinPT]				,
		[MaxPT]				
		)

	SELECT 
		cs.custid,ci.roleid, dest.tsporttype, dest.tbettype, dest.IsLive
		,cs.spositiontaking  *100
		,cs.mpositiontaking  *100
		,cs.apositiontaking  *100
		,cs.isautompositiontaking
		,cs.autompositiontaking *100
		,cs.isautopositiontaking 
		,cs.autopositiontaking  *100
		,co.minpositiontaking  *100
		,100 AS MaxPT
	FROM custInfo ci WITH(NOLOCK)
		INNER JOIN dbo.custSetting cs WITH(NOLOCK) ON ci.custid=cs.custid
		LEFT JOIN dbo.CustOverride co WITH(NOLOCK) ON cs.custid = co.custid and cs.sporttype = co.sporttype and cs.bettype = co.bettype
		INNER JOIN  #DestinationSportBetType dest ON dest.fSportType=cs.sporttype AND dest.fBetType=cs.bettype AND dest.SettingType = 1
	WHERE ci.srecommend = @srecommend AND ci.custid<=@maxcustid AND ci.Enabled=1 

	
	--------------------------------------PT Setting-------------------------------------------------	
	--AGENT LEVEL
	INSERT INTO dbo.CustPTSetting3rd_Agent
		(	CustID 
		   ,SportType 
		   ,BetType 
		   ,IsLive 
		   ,SuperPT 
		   ,MasterPT 
		   ,AgentPT 
		   ,IsAutoMasterPT 
		   ,AutoMasterPT 
		   ,IsAutoSuperPT 
		   ,AutoSuperPT 
		   ,MinPT 
		   ,MaxPT )
	SELECT 
			CustID 
		   ,SportType 
		   ,BetType 
		   ,IsLive 
		   ,SuperPT 
		   ,MasterPT 
		   ,AgentPT 
		   ,IsAutoMasterPT 
		   ,AutoMasterPT 
		   ,IsAutoSuperPT 
		   ,AutoSuperPT 
		   ,MinPT 
		   ,MaxPT 
	FROM #PTTemp t
	WHERE t.roleid IN(2,3,4) 
	--MEMBER LEVEL

	WHILE EXISTS(SELECT 1 FROM #PTTemp WHERE roleid=1)
	BEGIN
		DELETE TOP (3000) #PTTemp OUTPUT DELETED.* INTO #PTTempMemBatch WHERE roleid=1  

		IF @@ROWCOUNT=0
			BREAK		

		INSERT INTO dbo.CustPTSetting3rd_Member
			(	custid 
			  ,	sporttype 
			  ,	bettype 
			  ,	islive 
			  ,	superPT 
			  ,	masterPT 
			  ,	agentPT 
			  ,	IsAutoMasterPT 
			  ,	AutoMasterPT 
			  ,	IsAutoSuperPT 
			  ,	AutoSuperPT )
		SELECT 
				CustID 
			   ,SportType 
			   ,BetType 
			   ,IsLive 
			   ,SuperPT 
			   ,MasterPT 
			   ,AgentPT 
			   ,IsAutoMasterPT 
			   ,AutoMasterPT 
			   ,IsAutoSuperPT 
			   ,AutoSuperPT 		
		FROM #PTTempMemBatch t
			WHERE t.roleid =1

		TRUNCATE TABLE #PTTempMemBatch
	END

--------------------------------------Commission Setting-------------------------------------------------		
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType 
	FROM #DestinationSportBetType		
	WHERE SettingType = 3

	--Agent Level
	INSERT INTO #SMAList_CommSetting(CustID , Discount)
	SELECT ci.custid, (SELECT MAX(Discount) FROM (VALUES  (groupa), (groupb), (groupc),(groupd)) AS t(Discount))  AS Discount 
	FROM dbo.custSetting cs WITH(NOLOCK)
		INNER JOIN #SMATemp ci  ON cs.CustID = ci.custid
	WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType
		
	INSERT INTO dbo.CustDiscount3rd_Agent(CustID, SportType, BetType, Discount)
	SELECT ci.custid, dest.tsporttype, dest.tbettype,ci.Discount 
	FROM #SMAList_CommSetting ci
		CROSS APPLY #DestinationSportBetType dest
	WHERE SettingType = 3
	--Member Level
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #MemberTempIns
		
		UPDATE TOP (3000)  t SET t.InsComm = 1 
		OUTPUT DELETED.CustID,DELETED.srecommend,DELETED.mrecommend,DELETED.recommend 
		INTO #MemberTempIns(CustID,srecommend,mrecommend,recommend) 
		FROM #MemberTemp t WHERE t.InsComm = 0
		IF @@ROWCOUNT=0
			BREAK

		--Member Level
		INSERT INTO dbo.CustDiscount3rd_Member(CustID, SportType, BetType, PlayerDiscount, AgentDiscount, MasterDiscount, SuperDiscount)
		SELECT ci.custid, dest.tsporttype, dest.tbettype, cs.playerdiscount, a.Discount, m.Discount, s.Discount
		FROM dbo.custSetting cs WITH(NOLOCK)
			INNER JOIN #MemberTempIns ci WITH(NOLOCK) ON cs.CustID = ci.custid
			INNER JOIN #SMAList_CommSetting s WITH(NOLOCK) ON s.CustID = ci.srecommend
			INNER JOIN #SMAList_CommSetting m WITH(NOLOCK) ON m.CustID = ci.mrecommend
			INNER JOIN #SMAList_CommSetting a WITH(NOLOCK) ON a.CustID = ci.recommend
			CROSS APPLY #DestinationSportBetType dest
		WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType
			AND dest.SettingType = 3
	END
	
--------------------------------------Bet Setting-------------------------------------------------
	--SMA level
	INSERT INTO dbo.CustBetSetting3rd_Agent(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
	SELECT ci.CustID, dest.tSportType, dest.tBetType, 
		CASE WHEN ci.roleid = 4 THEN ps.SuperMinBet ELSE ps.MinBet END, 
		CASE WHEN ci.roleid = 4 THEN ps.SuperMaxBet ELSE ps.MaxBet END, 
		CASE WHEN ci.roleid = 4 THEN ps.SuperMaxPerMatch ELSE ps.MaxPerMatch END	
	FROM #SMATemp ci  
	CROSS APPLY #DestinationSportBetType dest
	INNER JOIN #ProductBetSetting ps  ON dest.tSportType = ps.Sporttype AND dest.tBetType = ps.Bettype AND ps.Currency = @Currency
	WHERE dest.SettingType = 16
	
	--Member Level
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #MemberTempIns
		UPDATE TOP (3000)  t SET t.InsBetSetting = 1 OUTPUT DELETED.CustID INTO #MemberTempIns(CustID) FROM #MemberTemp t WHERE t.InsBetSetting = 0
		
		IF @@ROWCOUNT=0
			BREAK

		--Member Level
		INSERT INTO dbo.CustBetSetting3rd_Member(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
		SELECT ci.CustID, dest.tSportType, dest.tBetType, ps.MinBet, ps.MaxBet, ps.MaxPerMatch
		FROM #MemberTempIns ci  
		CROSS APPLY #DestinationSportBetType dest
		INNER JOIN #ProductBetSetting ps  ON dest.tSportType = ps.Sporttype AND dest.tBetType = ps.Bettype AND ps.Currency = @Currency
		WHERE dest.SettingType = 16
	END
	
--------------------------------------Win Loss Limit-------------------------------------------------
	--Agent Level
	INSERT INTO dbo.CustWinLossLimit_Agent (CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
	SELECT ci.custid, dest.tsporttype, dest.tbettype, 0 AS MaxWinLimit, cs.DefaultLossLimit AS MaxLossLimit, 1 AS IsAutoReset
	FROM #SMATemp ci
		INNER JOIN dbo.LossLimit_GlobalSetting cs WITH(NOLOCK) ON  cs.ExchangeId = @Currency  AND cs.ProductId = @ProductID
		CROSS APPLY #DestinationSportBetType dest WITH(NOLOCK) 
	WHERE dest.SettingType = 6 

		--Member Level
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #MemberTempIns
		UPDATE TOP (3000)  t SET t.InsWinLoss = 1 OUTPUT DELETED.CustID INTO #MemberTempIns(CustID) FROM #MemberTemp t WHERE t.InsWinLoss = 0
		IF @@ROWCOUNT=0
			BREAK

		--Member Level
		INSERT INTO dbo.CustWinLossLimit_Member (CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
		SELECT ci.custid, dest.tsporttype, dest.tbettype, 0 AS MaxWinLimit, cs.DefaultLossLimit AS MaxLossLimit, 1 AS IsAutoReset
		FROM #MemberTempIns ci 
			INNER JOIN dbo.LossLimit_GlobalSetting cs WITH(NOLOCK) ON  cs.ExchangeId = @Currency  AND cs.ProductId = @ProductID
			CROSS APPLY #DestinationSportBetType dest WITH(NOLOCK) 
		WHERE dest.SettingType = 6 
	END

	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
	DROP TABLE #DestinationSportBetType	
	DROP TABLE #PTTemp
	DROP TABLE #PTTempMemBatch
	DROP TABLE #ProductBetSetting
	DROP TABLE #SMAList_CommSetting
	DROP TABLE #MemberTempIns
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.custid <= @max_custid
	AND ci.Site NOT IN ('CN88')
	AND ci.currency IN (20,72) -- UUS

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'REPLICATED'
			
			
	waitfor delay '00:00:0.200'
END
GO

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.custid <= @max_custid
	AND ci.Site NOT IN ('CN88')
	AND ci.currency IN (20,72) -- UUS

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
						
	waitfor delay '00:00:0.200'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
