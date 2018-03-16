/*
	Created: Elodie
	Task: Insert setting for Lucky3
	DB: DBCUST/CustDB
	Date: 20171214
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
	
	IF dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Member') = 0 RETURN

	DECLARE @ProductID TINYINT = 26
	CREATE TABLE #DestinationSportBetType(tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT)
	INSERT INTO #DestinationSportBetType (tSportType, tBetType, IsLive, SettingType)
	SELECT	SportType, BetType, 0, SettingType
	FROM dbo.ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SettingType IN (14)

	CREATE TABLE #OfferedSite (site VARCHAR(10))
	CREATE TABLE #OfferedSiteBatch1 (site VARCHAR(10))
	INSERT INTO #OfferedSite (site)
	VALUES  ('733333'), ('222223'), ('222225'), ('222227'), ('033333'), ('JPNIBC'), ('611111'), ('722222'), ('766666'), ('7aa666'), ('BEST-ODDS'), ('XYZbet'), ('755555'), ('789y')       
	INSERT INTO #OfferedSiteBatch1 (site)
	VALUES  ('Indo'), ('KORIBC')

	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		Type BIT --0: Dummy account or Direct account, 1: Indirect account
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		roleid TINYINT,
		Type BIT --0: Dummy account or Direct account, 1: Indirect account
	)

	CREATE TABLE #DirectMaster (CustID INT PRIMARY KEY,roleid TINYINT)
	CREATE TABLE #DirectAgent (CustID INT PRIMARY KEY,mrecommend INT,roleid TINYINT)
	CREATE TABLE #DirectMember (CustID INT PRIMARY KEY,recommend INT,mrecommend INT,roleid TINYINT)	
	CREATE TABLE #DirectAgentBatch1 (CustID INT PRIMARY KEY,mrecommend INT,roleid TINYINT)
	CREATE TABLE #DirectMemberBatch1 (CustID INT PRIMARY KEY,recommend INT,mrecommend INT,roleid TINYINT)	
	CREATE TABLE #DummyBatch1 (CustID INT PRIMARY KEY,roleid TINYINT)

	IF @srecommend IN (15)
	BEGIN
		--- get direct agent
		INSERT INTO #DirectAgentBatch1 (CustID,mrecommend,roleid)
		SELECT ci.custid, ci.mrecommend,ci.roleid
		FROM Customer ci WITH(NOLOCK)
		INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
		WHERE  EXISTS (SELECT 1 FROM #OfferedSiteBatch1 WHERE site = ci.site)
			AND  EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
			and ci.roleid = 2 AND ci.srecommend = @srecommend 
			AND ci.custid <= @maxcustid
			AND c.Enabled=1

		INSERT INTO #DirectMemberBatch1(CustID,recommend,mrecommend,roleid)
		SELECT c.custid, c.recommend,c.mrecommend,c.roleid
		FROM Customer c WITH(NOLOCK)
		INNER JOIN Customer ca (nolock) on c.recommend=ca.custid 
		INNER JOIN custInfo ci WITH(NOLOCK) ON ci.custid=c.custid
		WHERE EXISTS (SELECT 1 FROM #OfferedSiteBatch1 WHERE site = ca.site)
			AND EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
			AND c.roleid=1 AND c.srecommend = @srecommend 		
			AND c.custid <= @maxcustid 
			AND ci.Enabled=1

		----------- For SMA  -----------
		INSERT INTO #DummyBatch1 (CustID,roleid)
		SELECT @srecommend, 4 -- Super
		UNION ALL
		-----------------------Master--------------------------------------		
		SELECT DISTINCT d.mrecommend, 3 -- Master of direct agent
		FROM #DirectAgentBatch1 d
		UNION 
		SELECT DISTINCT d.mrecommend, 3 -- Master of direct member
		FROM #DirectMemberBatch1 D 	
		UNION 
		-----------------------Agent--------------------------------------		
		SELECT DISTINCT d.recommend, 2 -- agent of direct member
		FROM #DirectMemberBatch1 D 			
	END
			
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
	INSERT INTO #SMATemp (CustID,RoleID, Type)
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
	SELECT ci.CustID,2, 1 -- Agent of direct master
	FROM custInfo ci WITH (NOLOCK)
		INNER JOIN #DirectMaster D ON ci.mrecommend = d.CustID 
	WHERE ci.roleid = 2 AND ci.Enabled=1 AND ci.custid <= @maxcustid 
	UNION
	SELECT DISTINCT d.recommend, 2, 0 -- agent of direct member
	FROM #DirectMember D 	
	UNION 
	SELECT d.CustID, 2, 0 -- Direct Agent
	FROM #DirectAgent D
	UNION ALL
	--dummy account don't have member enabled
	SELECT ci.custid, ci.roleid, 0
	FROM Custinfo ci WITH (NOLOCK)
	WHERE username IN ('WSNT','midrup','MLOTTO','MSSD')
		AND ci.srecommend = @srecommend

	--Delete dummy account has setting in batch1
	DELETE s
	FROM #SMATemp s
	WHERE EXISTS (SELECT 1 FROM #DummyBatch1 WHERE CustID = s.custid)

	---------- For members ---------
	INSERT INTO #MemberTemp (CustID, Type)
	SELECT  ci.custid, 1 -- member of direct master
	FROM Custinfo ci WITH (NOLOCK)
		INNER JOIN #DirectMaster m ON ci.mrecommend = m.CustID
	WHERE ci.roleid = 1	AND ci.custid <= @maxcustid AND ci.Enabled = 1 			
	UNION ALL -- member of direct agent
	SELECT  ci.custid, 1
	FROM Custinfo ci WITH (NOLOCK)
		INNER JOIN #DirectAgent a ON ci.recommend = a.CustID
	WHERE ci.roleid = 1 AND ci.custid <= @maxcustid AND ci.Enabled = 1 			
	-- Direct member		
	UNION 
	SELECT ci.custid, 0
	FROM #DirectMember ci	

	DECLARE @TicketComm DECIMAL(9,8) = 0.1
	
	--------------------------------------Ticket Commission Setting-------------------------------------------------		
	--Agent Level
	INSERT INTO dbo.CustDiscount3rd_Agent(CustID, SportType, BetType, Discount)
	SELECT ci.custid, dest.tsporttype, dest.tbettype, 
			CASE WHEN Type = 0 THEN @TicketComm ELSE 0 END
	FROM #SMATemp ci 
		CROSS APPLY #DestinationSportBetType dest
	WHERE dest.SettingType = 14
		 
	--Member Level: 0: member of direct master; 1: member of direct agent; 2: direct member
	INSERT INTO dbo.CustDiscount3rd_Member(CustID, SportType, BetType, PlayerDiscount, AgentDiscount, MasterDiscount, SuperDiscount)
	SELECT ci.custid, dest.tsporttype, dest.tbettype, 
			0, 
			CASE WHEN Type = 1 THEN @TicketComm ELSE 0 END, 
			CASE WHEN Type = 2 THEN 0 ELSE @TicketComm END, 
			CASE WHEN Type = 2 THEN 0 ELSE @TicketComm END
	FROM #MemberTemp ci WITH(NOLOCK) 
		CROSS APPLY #DestinationSportBetType dest
	WHERE dest.SettingType = 14

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
--SELECT DISTINCT srecommend INTO #temp1
--FROM CustDirectAccount da WITH (NOLOCK)
--	INNER JOIN customer ci WITH(NOLOCK) ON da.CustID = ci.custid
--WHERE ci.site IN ('733333', '222223', '222225', '222227', '033333', 'JPNIBC', '611111', '722222', '766666', '7aa666', 'BEST-ODDS', 'XYZbet', '755555', '789y')
--	AND ci.roleid IN (2, 3) AND ci.currency <> 20
--UNION 
--SELECT DISTINCT ci.srecommend
--FROM CustDirectAccount da WITH (NOLOCK)
--	INNER JOIN customer ci WITH(NOLOCK) ON da.CustID = ci.custid
--	INNER JOIN customer ca WITH(NOLOCK) ON ci.recommend = ca.custid
--WHERE ci.site IN ('733333', '222223', '222225', '222227', '033333', 'JPNIBC', '611111', '722222', '766666', '7aa666', 'BEST-ODDS', 'XYZbet', '755555', '789y')
--	AND ci.roleid IN (1) AND ci.currency <> 20
--ORDER BY srecommend

INSERT INTO #supers(custid)
SELECT ci.custid
FROM dbo.Customer ci WITH(NOLOCK)
WHERE ci.custid IN (1,2,3,4,5,6,9,12,13,15,16,17,22,30,32,33,34,35,36,41,42,21278849,21278858) -- dummy account	

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
PRINT N'Step 3: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM dbo.Customer ci WITH(NOLOCK)
WHERE ci.custid IN (1,2,3,4,5,6,9,12,13,15,16,17,22,30,32,33,34,35,36,41,42,21278849,21278858) -- dummy account	

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

PRINT N'Step 3: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 