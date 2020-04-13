/*
	Created: 20200413@Tiara
	Date: 20200413
	Task: Update betlimit for Allbet, SA, Sexy Gaming [Redmine: #131853]
	DB: DBCUST/CustDB
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
	IF dbo.f_CheckRepTable('StakeLevel') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('ProductSettingDetail') = 0 RETURN	

	DECLARE @ProductID TINYINT = 41
	DECLARE  @Currency INT
	SELECT @Currency = currency FROM customer WITH (NOLOCK) WHERE custid = @srecommend

	CREATE TABLE #DirectSMA
	(
		CustID INT PRIMARY KEY CLUSTERED,
		roleid TINYINT
	)
		
	INSERT INTO #DirectSMA (CustID,roleid) --Direct Super, Master, Agent
	SELECT @srecommend, 4
	UNION
	SELECT ci.custid, ci.roleid
	FROM Custinfo ci WITH (NOLOCK)
	WHERE  EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		AND ci.srecommend = @srecommend 
		AND ci.Enabled=1
		AND ci.roleid IN (2,3)
		AND ci.custid <= @maxcustid 

	--Create Stakelevelid that need to be updated for each sport
	CREATE TABLE #StakeLevelID_Update
	(
		StakeLevelID INT,
		GameTypeID INT,
		ExchangeId INT
	)
	
	INSERT INTO #StakeLevelID_Update (StakeLevelID, GameTypeID, ExchangeId)
	SELECT StakeLevelID, GameTypeID, ExchangeId
	FROM dbo.StakeLevel WITH(NOLOCK)
	WHERE exchangeid = @currency
		AND GameTypeID = 2401
		AND MinStake = 100
		AND MaxStake = 50000
	UNION ALL
	SELECT StakeLevelID, GameTypeID, ExchangeId
	FROM dbo.StakeLevel WITH(NOLOCK)
	WHERE exchangeid = @currency
		AND GameTypeID = 3001
		AND MinStake = 2000
		AND MaxStake = 50000
	UNION ALL
	SELECT StakeLevelID, GameTypeID, ExchangeId
	FROM dbo.StakeLevel WITH(NOLOCK)
	WHERE exchangeid = @currency
		AND GameTypeID = 3101
		AND MinStake = 50
		AND MaxStake = 50000

	IF @@ROWCOUNT =0 RETURN	
	
	UPDATE C
	SET C.StakeLevelList = ISNULL((C.StakeLevelList+','+CAST(S.StakeLevelID AS VARCHAR(10))),'')
	FROM CustStakeLevel_Agent C WITH (UPDLOCK,ROWLOCK) INNER JOIN #StakeLevelID_Update S WITH (NOLOCK) ON C.BetType = S.GameTypeID AND S.ExchangeId = @Currency
		INNER JOIN #DirectSMA D WITH (NOLOCK) ON D.CustID = C.CustID
	WHERE C.BetType IN (2401, 3001, 3101)
	
	DROP TABLE #DirectSMA
	DROP TABLE #StakeLevelID_Update

END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
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
	AND ci.Site NOT IN ('CN88', '789y')
	AND ci.custid <= @max_custid
	AND ci.currency IN (15,22,33,34,47) --( 'IDD', 'IDR', 'IN', 'IND','DDD')

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
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 3: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

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
	AND ci.Site NOT IN ('CN88', '789y')
	AND ci.custid <= @max_custid
	AND ci.currency IN (15,22,33,34,47) --( 'IDD', 'IDR', 'IN', 'IND','DDD')

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

PRINT N'Step 3: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
		


