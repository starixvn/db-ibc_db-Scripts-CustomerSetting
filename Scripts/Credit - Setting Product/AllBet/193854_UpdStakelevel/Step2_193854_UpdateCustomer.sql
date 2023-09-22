/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20230918
	Task: Allbet - Change Play Currency - Change bet limit for RM,HK$, RMB, HKK, USD and re-open Credit Markets [Redmine: 193854]
	DB: DBCust/CustDB
	Step 2 : Update SMA
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	 @CustCCs VARCHAR(MAX)= ''
 	,@StakeLevelID INT = 0
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at DBCUST only
	
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN

	CREATE TABLE #CustList (CustID INT PRIMARY KEY)

	INSERT INTO #CustList(custid)	
	SELECT VALUE AS RuleID 
	FROM STRING_SPLIT(@CustCCs,',') WHERE VALUE <> ''

	UPDATE cs
	SET cs.StakeLevelList =  cs.StakeLevelList + ',' + CONVERT(VARCHAR(50),@StakeLevelID)
	FROM CustStakeLevel_Agent cs WITH (ROWLOCK, UPDLOCK) 
		INNER JOIN #CustList ci ON cs.CustId = ci.custid
	WHERE cs.SportType = 211 AND cs.BetType = 2401

END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST-----
----------------------------------------------------------------------------------------------
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
----------------------------------------------------------------------------------------------
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;
CREATE TABLE #supers		(CustID INT PRIMARY KEY, isfinished BIT DEFAULT(0))
CREATE TABLE #CustListAgent (CustID INT ,Currency INT,isfinished BIT DEFAULT(0), PRIMARY KEY CLUSTERED (Currency,isfinished,CustID))
CREATE TABLE #CustListAgentTemp (CustID INT PRIMARY KEY)
CREATE TABLE #Curency (ExchangeId INT PRIMARY KEY,StakeLevelID INT, isfinished BIT DEFAULT(0))

INSERT INTO #Curency(ExchangeId) VALUES(2),(67) --RM, HKK

UPDATE c
SET c.StakeLevelID = s.StakeLevelID
FROM #Curency c 
CROSS APPLY ( SELECT StakeLevelID 
			  FROM dbo.StakeLevel  WITH(NOLOCK) 
			  WHERE GameTypeID = 2401 AND MinStake = 500 AND MaxStake = 20000 AND ExchangeId = c.ExchangeId
		) s

DECLARE @batch SMALLINT = 5000
DECLARE @CustCCs VARCHAR(MAX) 
DECLARE @max_custid INT, @Currency INT,@StakeLevelID INT
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
	AND ci.custid <= @max_custid
	AND ci.currency IN ( 2, 67) --RM, HKK

INSERT INTO #CustListAgent(CustID, Currency)
SELECT ci.custid, ci.Currency
FROM dbo.custInfo ci WITH (NOLOCK)
	INNER JOIN #supers S ON srecommend = s.custid
WHERE ci.Enabled = 1
	AND ci.roleid in (2,3,4)
	AND ci.custid <= @max_custid

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, Currency: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of SMA: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #CustListAgent )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Curency
	SET isfinished = 1 ,@Currency = ExchangeId, @StakeLevelID = StakeLevelID	
	WHERE isfinished = 0
		
	IF @@ROWCOUNT = 0 BREAK

	WHILE (1 = 1)
	BEGIN
		SELECT @CustCCs = ''
		UPDATE TOP (@batch) a
		SET a.isfinished = 1
		OUTPUT INSERTED.CustID INTO #CustListAgentTemp(CustID)	
		FROM #CustListAgent a	
		WHERE Currency = @Currency AND isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK

		SET @index = @index + (SELECT COUNT(*) FROM #CustListAgentTemp )
		RAISERROR (@msg, 0, 1, @index, @Currency) WITH NOWAIT

		SET @CustCCs = (SELECT STRING_AGG(CONVERT(VARCHAR(MAX),custid),',')  FROM #CustListAgentTemp)

		EXEC dbo.Acc_DynamicCustSetting3rd_09 @CustCCs = @CustCCs, @StakeLevelID = @StakeLevelID,@target = @target

		WAITFOR DELAY '00:00:0.050'
		TRUNCATE TABLE #CustListAgentTemp
	END
		
END
DROP TABLE #Curency
DROP TABLE #supers
DROP TABLE #CustListAgent
DROP TABLE #CustListAgentTemp
GO
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
