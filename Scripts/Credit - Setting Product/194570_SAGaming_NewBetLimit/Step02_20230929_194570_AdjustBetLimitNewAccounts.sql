/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20230929
	Task: SA Gaming - New Bet Limit for HKK/RM [Redmine: #194570]
	DB: DBCust/CustDB
*/
USE CustDB
GO
----------------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
	IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
		DROP TABLE	#supers;
	CREATE TABLE #supers		(CustID INT PRIMARY KEY, isfinished BIT DEFAULT(0))
	CREATE TABLE #CustListAgent (CustID INT PRIMARY KEY,Currency INT,StakeLevelID INT)
	CREATE TABLE #Curency (ExchangeId INT PRIMARY KEY,StakeLevelID INT, isfinished BIT DEFAULT(0))

	INSERT INTO #Curency (ExchangeId, StakeLevelID)
	SELECT ExchangeId, StakeLevelID
	FROM dbo.StakeLevel WITH (NOLOCK)
	WHERE MinStake = 100 AND MaxStake = 10000 
		AND GameTypeID = 3001
		AND ExchangeId IN (2, 67) --RM, HKK

	DECLARE @max_custid INT
	SELECT @max_custid = xxx

	DECLARE @target VARCHAR(20)
	IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	BEGIN
		SET @target = 'DBCUST'
	END
	ELSE 
	BEGIN	
		SET @target = 'REPLICATED'
	END
	PRINT 'Server Name : ' + @target

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
		AND ci.Site NOT IN ('CN88')
		AND ci.currency IN ( 2, 67) --RM, HKK

	INSERT INTO #CustListAgent(CustID, Currency, StakeLevelID)
	SELECT ci.custid, ci.Currency , c.StakeLevelID
	FROM dbo.custInfo ci WITH (NOLOCK)
		INNER JOIN #supers S ON srecommend = s.custid
		INNER JOIN #Curency c ON ci.currency = c.ExchangeId
	WHERE ci.Enabled = 1
		AND ci.roleid in (2,3,4)
		AND ci.custid > @max_custid
		
		
	UPDATE cs
	SET cs.StakeLevelList =  cs.StakeLevelList + ',' + CONVERT(VARCHAR(10),ci.StakeLevelID)
	FROM CustStakeLevel_Agent cs WITH (ROWLOCK, UPDLOCK) 
		INNER JOIN #CustListAgent ci ON cs.CustId = ci.custid
	WHERE cs.SportType = 244 AND cs.BetType = 3001 AND cs.StakeLevelList <> ''

DROP TABLE #Curency
DROP TABLE #supers
DROP TABLE #CustListAgent
GO
PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 