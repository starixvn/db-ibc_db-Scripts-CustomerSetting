/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230112@Johnson
	Task: update bet limit for SB UUS customers [Redmine: #182810]
	DB: DBCUST/CustDB
*/

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------

ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	 @srecommend INT		
	,@target VARCHAR(20)
	,@max_custid INT	
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSettingDetail') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSettingGame_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSettingGameGroup_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustSettingMode') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSettingGame_Member') = 0 RETURN
	
	CREATE TABLE #tblmrecommend  (CustID INT PRIMARY KEY)
	CREATE TABLE #tblSMA (custid INT PRIMARY KEY, roleid TINYINT)
	CREATE TABLE #tblCust (CustID INT PRIMARY KEY)	
	CREATE TABLE #SportBettype (SportType SMALLINT, Bettype SMALLINT)
	DECLARE @tmpCust TABLE (custid INT PRIMARY KEY)
	
	DECLARE @MinBet MONEY = 1,
		@MaxBet MONEY= 1000,
		@MaxPerMatch  MONEY = 10000,
		@MaxPayoutPerMatch MONEY = 80000

	INSERT INTO #SportBettype (SportType,Bettype)
	SELECT DISTINCT SportType,Bettype
	FROM Dep_ProductSetting ps WITH(NOLOCK) 
		INNER JOIN Dep_ProductSettingDetail d WITH(NOLOCK) ON ps.ProductSettingID=d.ProductSettingID  
	WHERE ProductID = 1 
		AND SettingType IN (10,12)
	
	INSERT INTO #tblmrecommend(CustID)
	SELECT c.custid 
	FROM custinfo c WITH (NOLOCK) 
	WHERE  c.srecommend = @srecommend
		AND roleid=3 
		and (username LIKE '%Acc%' OR username LIKE '%LocalBank%' 
						OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')	
						
	INSERT INTO #tblSMA(custid,roleid)
	SELECT custid, roleid
	FROM custinfo ci WITH(NOLOCK)
	WHERE srecommend = @srecommend
		AND mrecommend NOT IN (SELECT custid FROM #tblmrecommend)
		AND roleid> 1
		AND Enabled = 1
		AND custid <= @max_custid
		
	UPDATE cs 
	SET cs.MinBet = @MinBet,
		cs.MaxBet = @MaxBet,
		cs.MaxPerMatch = @MaxPerMatch,
		cs.MaxPayoutPerMatch = @MaxPayoutPerMatch
	FROM Dep_CustBetSettingGame_Agent cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #SportBettype s ON cs.SportType = s.SportType AND cs.Bettype = s.Bettype
	WHERE custid IN (SELECT custid FROM #tblSMA)
	
	UPDATE cs 
	SET cs.MinBet = @MinBet,
		cs.MaxBet = @MaxBet,
		cs.MaxPerMatch = @MaxPerMatch,
		cs.MaxPayoutPerMatch = @MaxPayoutPerMatch
	FROM Dep_CustBetSettingGameGroup_Member cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #SportBettype s ON cs.SportType = s.SportType AND cs.Bettype = s.Bettype
	WHERE AgentID IN (SELECT custid FROM #tblSMA WHERE roleid =2)	
		
	INSERT INTO #tblCust(CustID)
	SELECT c.CustID
	FROM Customer c WITH(NOLOCK)				
		INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON c.custid = m.CustID
	WHERE c.recommend IN (SELECT custid FROM #tblSMA WHERE roleid =2)
		AND c.roleid =1	
		AND ISNULL(m.IsGroupedBetLimit,0) = 0
		AND c.custid <= @max_custid

	WHILE(1=1)
	BEGIN	
		DELETE TOP (300) t
		OUTPUT DELETED.custid INTO @tmpCust(custid)
		FROM #tblCust t
		
		IF @@ROWCOUNT = 0
			BREAK;
			
		UPDATE cs
		SET	cs.MinBet = @MinBet,
			cs.MaxBet = @MaxBet,
			cs.MaxPerMatch = @MaxPerMatch,
			cs.MaxPayoutPerMatch = @MaxPayoutPerMatch
		FROM Dep_CustBetSettingGame_Member cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #SportBettype s ON cs.SportType = s.SportType AND cs.Bettype = s.Bettype
		WHERE custid IN (SELECT custid FROM @tmpCust)	
		
		DELETE @tmpCust
	END
	
	DROP TABLE #tblSMA
	DROP TABLE #tblmrecommend
	DROP TABLE #tblCust
	DROP TABLE #SportBettype
	
END
GO
---END STEP 1: DEPLOY THIS SP @DBCUST.CustDB------------------------------------------


-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT , @max_custid INT

SELECT @max_custid = xxx

IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')
BEGIN
	INSERT INTO #supers(custid)
	SELECT c.custid
	FROM customer c WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
		INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
	WHERE c.roleid = 4  
		AND s.islicensee = 1
		AND ci.Enabled = 1
		AND c.custid <= @max_custid
		AND c.currency = 20 
		AND s.site IN (SELECT LicenseeName FROM  bodb_Licensee.dbo.Licensees WITH(NOLOCK) WHERE IsActive = 1)
END
ELSE
BEGIN
	INSERT INTO #supers(custid)
	SELECT c.custid
	FROM customer c WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
		INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
	WHERE c.roleid = 4  
		AND s.islicensee = 1
		AND ci.Enabled = 1
		AND c.custid <= @max_custid
		AND c.currency = 20 
		AND s.site IN (SELECT LicenseeName FROM DBCUST.bodb_Licensee.dbo.Licensees WITH(NOLOCK) WHERE IsActive = 1)
END		

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

	EXEC dbo.Acc_Dep_DynamicCustSetting_09 @srecommend = @srecommend
			,@target = @target
			,@max_custid = @max_custid
									
	waitfor delay '00:00:0.100'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DROP TABLE #supers
GO