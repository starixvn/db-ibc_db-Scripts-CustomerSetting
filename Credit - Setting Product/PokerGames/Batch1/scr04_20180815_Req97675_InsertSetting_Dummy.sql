/*
	Created: Elodie
	Task: Insert setting of Poker Games for dummy line
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
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN			

	DECLARE @ProductID INT = 33, @currency INT

	SELECT @currency = ci.currency FROM dbo.custInfo ci WITH (NOLOCK) WHERE ci.custid = @srecommend

	SELECT t.* 
	INTO #SportBettypeFilter3
	FROM ProductSettingDetail t WITH (NOLOCK)
	WHERE t.SettingType = 3 AND t.ProductID = @ProductID

	SELECT t.* 
	INTO #SportBettypeFilter6
	FROM ProductSettingDetail t WITH (NOLOCK)
	WHERE t.SettingType = 6 AND t.ProductID = @ProductID

	CREATE TABLE #OfferedSite (site VARCHAR(10))
	INSERT INTO #OfferedSite (site)
	VALUES  ('789y')
	          
	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		Type TINYINT --0: Direct member, 1: Member of Direct Agent, 2: Member of Direct Master
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		roleid TINYINT,
		Type BIT --0: Dummy account or Direct account, 1: Indirect account
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
	INSERT INTO #SMATemp (CustID, RoleID, Type)
	SELECT @srecommend, 4, 0 -- Super
	UNION ALL
	-----------------------Master--------------------------------------
	SELECT d.CustID, 3, 0 -- Direct Master 
	FROM #DirectMaster d	
	UNION 
	SELECT DISTINCT d.mrecommend, 3, 0 -- Master of direct agent
	FROM #DirectAgent d
	UNION 
	SELECT DISTINCT d.mrecommend, 3, 0 -- Master of direct member
	FROM #DirectMember D 	
	UNION 
	-----------------------Agent--------------------------------------
	SELECT ci.CustID, 2, 1 -- Agent of direct master
	FROM custInfo ci WITH (NOLOCK)
		INNER JOIN #DirectMaster D ON ci.mrecommend = d.CustID 
	WHERE ci.roleid = 2 AND ci.Enabled=1 AND ci.custid <= @maxcustid 
	UNION
	SELECT DISTINCT d.recommend, 2, 0 -- agent of direct member
	FROM #DirectMember D 	
	UNION 
	SELECT d.CustID, 2, 0 -- Direct Agent
	FROM #DirectAgent D
	 	
	---------- For members ---------
	INSERT INTO #MemberTemp (CustID, Type)
	SELECT  ci.custid, 2 -- member of direct master
	FROM Custinfo ci WITH (NOLOCK)
		INNER JOIN #DirectMaster m ON ci.mrecommend = m.CustID
	WHERE ci.roleid = 1	AND ci.custid <= @maxcustid AND ci.Enabled = 1 			
	UNION ALL -- member of direct agent
	SELECT  ci.custid, 1
	FROM Custinfo ci WITH (NOLOCK)
		INNER JOIN #DirectAgent a ON ci.recommend = a.CustID
	WHERE ci.roleid = 1 AND ci.custid <= @maxcustid AND ci.Enabled = 1 			
	-- Direct member		
	UNION ALL
	SELECT ci.custid, 0
	FROM #DirectMember ci

	--------------------------------------Commission Setting-------------------------------------------------
	--Agent Level
	INSERT INTO dbo.CustDiscount3rd_Agent (CustID, SportType, BetType, Discount)	        
	SELECT ci.custid, sb.SportType, sb.BetType, 
		CASE	WHEN ci.Type = 0 THEN 0.85
				ELSE 0 END 
	FROM #SMATemp ci WITH(NOLOCK)
		CROSS APPLY #SportBettypeFilter3 sb 

	--Member Level
	INSERT INTO dbo.CustDiscount3rd_Member(CustID, SportType, BetType, PlayerDiscount, AgentDiscount, MasterDiscount, SuperDiscount)
	SELECT ci.custid, sb.SportType, sb.BetType, 
			CASE WHEN ci.Type = 0 THEN 0.85 ELSE 0 END,
			CASE WHEN ci.Type = 2 THEN 0 ELSE 0.85 END, 
			0.85, 0.85
	FROM #MemberTemp ci WITH(NOLOCK)
		CROSS APPLY #SportBettypeFilter3 sb
				
	--------------------------------------Win Loss Limit-------------------------------------------------		
	--Agent Level
	INSERT INTO dbo.CustWinLossLimit_Agent (CustID, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
	SELECT ci.custid, sb.SportType, sb.BetType, 0, 
		CASE	WHEN FLOOR(ci.Credit * 0.1) < cs.MinLossLimit THEN cs.MinLossLimit
				WHEN FLOOR(ci.Credit * 0.1) > cs.DefaultLossLimit THEN cs.DefaultLossLimit ELSE FLOOR(ci.Credit * 0.1) END, 1
	FROM #SMATemp c WITH(NOLOCK)
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = c.CustID
		CROSS APPLY dbo.LossLimit_GlobalSetting cs WITH(NOLOCK)
		CROSS APPLY #SportBettypeFilter6 sb
	WHERE cs.ExchangeId = @currency AND cs.ProductId = @ProductID	
		 
	--Member Level
	INSERT INTO dbo.CustWinLossLimit_Member(CustID, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
	SELECT ci.custid, sb.SportType, sb.BetType, 0,
		CASE	WHEN FLOOR(ci.Credit * 0.1) < cs.MinLossLimit THEN cs.MinLossLimit
				WHEN FLOOR(ci.Credit * 0.1) > cs.DefaultLossLimit THEN cs.DefaultLossLimit ELSE FLOOR(ci.Credit * 0.1) END, 1
	FROM #MemberTemp c WITH(NOLOCK)
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = c.CustID
		CROSS APPLY dbo.LossLimit_GlobalSetting cs WITH(NOLOCK)
		CROSS APPLY #SportBettypeFilter6 sb
	WHERE cs.ExchangeId = @currency AND cs.ProductId = @ProductID	

	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
	DROP TABLE #SportBettypeFilter3
	DROP TABLE #SportBettypeFilter6		
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
--WHERE ci.site IN ('789y')
--	AND ci.roleid IN (2, 3)
--UNION 
--SELECT DISTINCT ci.srecommend
--FROM CustDirectAccount da WITH (NOLOCK)
--	INNER JOIN customer ci WITH(NOLOCK) ON da.CustID = ci.custid
--	INNER JOIN customer ca WITH(NOLOCK) ON ci.recommend = ca.custid
--WHERE ca.site IN ('789y')
--	AND ci.roleid IN (1)
--ORDER BY srecommend

INSERT INTO #supers(custid)
SELECT ci.custid
FROM dbo.Customer ci WITH(NOLOCK)
WHERE ci.custid IN (2,3,16,17,35,21278849,21278858) -- dummy account	

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
WHERE ci.custid IN (2,3,16,17,35,21278849,21278858) -- dummy account

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