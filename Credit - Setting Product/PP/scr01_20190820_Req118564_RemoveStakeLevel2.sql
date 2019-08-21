/*
	Created: Winnie
	Date: 20190820
	Task: Remove stake level 2. [RedmineID:#118564]
	DB: DBCust/CustDB
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

	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN
	IF dbo.f_CheckRepTable('StakeLevel') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN	
	
	DECLARE  @currency INT

	SELECT @currency = ci.currency FROM dbo.custInfo ci WITH (NOLOCK) WHERE ci.custid = @srecommend

	CREATE TABLE #tmpLevel2(GameTypeID INT,GameGroupID INT)	
	INSERT INTO #tmpLevel2(GameTypeID ,GameGroupID )
	SELECT 4001,2
	UNION ALL
	SELECT 4101,7

	CREATE TABLE #tmpLevel1(GameTypeID INT,GameGroupID INT)	
	INSERT INTO #tmpLevel1(GameTypeID ,GameGroupID )
	SELECT 4001,1
	UNION ALL
	SELECT 4101,6

	CREATE TABLE #MemberTemp
	(
		CustID			INT,
		SportType		INT,
		BetType			INT,
		StakeLevelList	VARCHAR(50),
		PRIMARY KEY(CustID,Sporttype,Bettype)
	)

	CREATE TABLE #SMATemp
	(
		CustID			INT,
		SportType		INT,
		BetType			INT,
		StakeLevelList	VARCHAR(50),
		PRIMARY KEY(CustID,Sporttype,Bettype)
	)

		CREATE TABLE #MemberTempBatch
	(
		CustID			INT,
		SportType		INT,
		BetType			INT,
		StakeLevelList	VARCHAR(50),
		PRIMARY KEY(CustID,Sporttype,Bettype)
	)	
	
	CREATE TABLE #SMATempRaw
	(
		CustID			INT,
		SportType		INT,
		BetType			INT,
		StakeLevelList	INT
		
	)

	CREATE TABLE #MemberTempRaw
	(
		CustID			INT,
		SportType		INT,
		BetType			INT,
		StakeLevelList	INT
		
	)	

	INSERT INTO #MemberTempRaw (CustID,SportType,BetType,StakeLevelList)
	SELECT c.custid,a.SportType,a.BetType,s1.StakeLevelID
	FROM stakelevel s WITH(NOLOCK) 
	INNER JOIN #tmpLevel2 t ON s.GameTypeID=t.GameTypeID AND s.GameGroupID=t.GameGroupID AND s.ExchangeId=@currency
	INNER JOIN CustStakeLevel_Member a WITH(NOLOCK) ON t.GametypeID=a.Bettype
	INNER JOIN Custinfo c WITH(NOLOCK) ON a.custid=c.CustiD 
	INNER JOIN #tmpLevel1 t1 ON a.Bettype=t1.GameTypeID
	INNER JOIN stakelevel s1 ON s1.GameTypeID=t1.GameTypeID AND s1.GameGroupID=t1.GameGroupID AND s1.ExchangeId=@currency 
	WHERE srecommend = @srecommend AND roleid = 1  AND c.custid <= @maxcustid	
		AND StakeLevelList = CAST(s.StakelevelID AS VARCHAR(50))
	

	INSERT INTO #SMATempRaw (CustID,SportType,BetType,StakeLevelList)
	SELECT c.custid,a.SportType,a.BetType,s1.StakeLevelID
	FROM stakelevel s WITH(NOLOCK) 
	INNER JOIN #tmpLevel2 t ON s.GameTypeID=t.GameTypeID AND s.GameGroupID=t.GameGroupID  AND s.ExchangeId=@currency		
	INNER JOIN CustStakeLevel_Agent a WITH(NOLOCK) ON t.GametypeID=a.Bettype
	INNER JOIN Custinfo c WITH(NOLOCK) ON a.custid=c.CustiD 
	INNER JOIN #tmpLevel1 t1 ON a.Bettype=t1.GameTypeID
	INNER JOIN stakelevel s1 ON s1.GameTypeID=t1.GameTypeID AND s1.GameGroupID=t1.GameGroupID AND s1.ExchangeId=@currency
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND c.custid <= @maxcustid			
		AND StakeLevelList like '%'+ CAST(s.StakelevelID AS VARCHAR(50))+'%'	

	INSERT INTO #MemberTemp (CustID,SportType,BetType,StakeLevelList)
	SELECT custid,SportType,BetType,CAST(MIN(StakeLevelList) AS VARCHAR(50))	
	FROM #MemberTempRaw
	GROUP BY custid,SportType,BetType

	INSERT INTO #SMATemp (CustID,SportType,BetType,StakeLevelList)
	SELECT custid,SportType,BetType,CAST(MIN(StakeLevelList) AS VARCHAR(50))	
	FROM #SMATempRaw
	GROUP BY custid,SportType,BetType
	----------------------------------------Betlimit Setting-------------------------------------------------		
	
	--Member Level

	WHILE EXISTS(SELECT 1 FROM #MemberTemp)
	BEGIN
		DELETE TOP (3000) #MemberTemp OUTPUT DELETED.* INTO #MemberTempBatch

		IF @@ROWCOUNT=0
			BREAK		

		UPDATE a
		SET a.StakeLevelList=t.StakeLevelList
		FROM #MemberTempBatch t
		INNER JOIN CustStakeLevel_Member a WITH(ROWLOCK,UPDLOCK) ON t.CustID=a.CustID AND t.SportType=a.SportType AND t.BetType=a.BetType		

		TRUNCATE TABLE #MemberTempBatch
	END

	--Agent Level
	UPDATE a
		SET a.StakeLevelList=t.StakeLevelList
	FROM #SMATemp t
		INNER JOIN CustStakeLevel_Agent a WITH(ROWLOCK,UPDLOCK) ON t.CustID=a.CustID AND t.SportType=a.SportType AND t.BetType=a.BetType		

	
	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp

END
GO

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
 INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
 LEFT JOIN custsuper cs WITH (NOLOCK) ON c.custid = cs.custid
WHERE c.roleid = 4  
 AND c.username NOT LIKE '3rdSuper%'
 AND cs.isinternal = 0
 AND c.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
 AND s.islicensee = 0  
 AND c.custid <= @max_custid
 AND c.Site<>'CN88'

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
						
	waitfor delay '00:00:0.100'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
 INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
 LEFT JOIN custsuper cs WITH (NOLOCK) ON c.custid = cs.custid
WHERE c.roleid = 4  
 AND c.username NOT LIKE '3rdSuper%'
 AND cs.isinternal = 0
 AND c.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
 AND s.islicensee = 0 
 AND c.custid <= @max_custid
 AND c.Site<>'CN88'
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
						
	waitfor delay '00:00:0.100'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

