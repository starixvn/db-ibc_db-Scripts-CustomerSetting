/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221005@Johnson
	Task: Initial setting for Cricket & Saba Cricket for Test Licensees [#RedmineID:#175659]
	DB: DBCUST/CustDB
*/ 

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	 @srecommend INT	
	, @max_custid INT
	, @target VARCHAR(20)	
AS
BEGIN	
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbtrans only
	
	IF (dbo.f_CheckRepTable('Dep_CustSettingMode') = 0
		
		OR dbo.f_CheckRepTable('Dep_CustBetSettingGame_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSettingGame_Member') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSettingGameGroup_Member') = 0
		OR dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0				
	   )
	RETURN

	CREATE TABLE #tmpCust (CustID INT PRIMARY KEY, isfinished BIT DEFAULT(0))
	CREATE TABLE #tmpSMA (CustID INT PRIMARY KEY,RoleID INT)
	CREATE TABLE #Dummy (CustID INT PRIMARY KEY)
	
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend=@srecommend 
		AND roleid=3 
		AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
	
	INSERT INTO #tmpCust(CustID)
	SELECT ci.CustID
	FROM custInfo ci WITH(NOLOCK)
		INNER JOIN Dep_CustSettingMode cs WITH(NOLOCK) ON cs.custid = ci.custid
	WHERE ci.srecommend = @srecommend 
		AND ci.custid<=@max_custid 
		AND roleid = 1 
		AND ci.Enabled=1
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)
		AND cs.IsGroupedBetLimit = 0
		
	INSERT INTO #tmpSMA(CustID,RoleID)
	SELECT CustID,RoleID
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend = @srecommend 
		AND ci.custid<=@max_custid 
		AND roleid IN(2,3,4)
		AND ci.Enabled=1
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	
	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT @srecommend, 154 ProductSettingID
	UNION SELECT @srecommend, 155 ProductSettingID
			
	INSERT INTO Dep_CustBetSettingGame_Agent(
			CustID,
			SportType,
			BetType,
			MinBet,
			MaxBet,
			MaxPerMatch,
			MaxPerNumber,
			MaxPayoutPerMatch
		)
	SELECT CustID,
			t.SportType,
			t.BetType,
			MinBet,
			MaxBet,
			MaxPerMatch,
			MaxPerNumber,
			MaxPayoutPerMatch
	FROM Dep_CustBetSettingGame_Agent cs WITH(NOLOCK)
		CROSS APPLY (SELECT 50 sporttype, 1 bettype
					UNION SELECT 9907, 1
					)t
	WHERE custid IN (SELECT custid FROM #tmpSMA)
		AND cs.sporttype = 99
		AND cs.bettype = 1
		
	INSERT INTO [dbo].[Dep_CustBetSettingGameGroup_Member]
			   ([AgentID]
			   ,[SportType]
			   ,[BetType]
			   ,[MinBet]
			   ,[MaxBet]
			   ,[MaxPerMatch]
			   ,[MaxPerNumber]
			   ,[MaxPayoutPerMatch])
	SELECT [AgentID]
		   ,t.SportType
		   ,t.BetType
		   ,[MinBet]
		   ,[MaxBet]
		   ,[MaxPerMatch]
		   ,[MaxPerNumber]
		   ,[MaxPayoutPerMatch]
	FROM Dep_CustBetSettingGameGroup_Member cs WITH(NOLOCK)
		CROSS APPLY (SELECT 50 sporttype, 1 bettype
					UNION SELECT 9907, 1
					)t
	WHERE AgentID IN (SELECT custid FROM #tmpSMA WHERE roleid = 2)
		AND cs.sporttype = 99
		AND cs.bettype = 1
		
	DECLARE @tmp TABLE (custid INT PRIMARY KEY)
	
	WHILE(1=1)
	BEGIN
		DELETE TOP (2500) t
		OUTPUT DELETED.Custid INTO @tmp(Custid)
		FROM #tmpCust t
		
		IF @@ROWCOUNT = 0
			BREAK;
			
		INSERT INTO [dbo].[Dep_CustBetSettingGame_Member]
			   ([CustID]
			   ,[SportType]
			   ,[BetType]
			   ,[MinBet]
			   ,[MaxBet]
			   ,[MaxPerMatch]
			   ,[MaxPerNumber]
			   ,[MaxPayoutPerMatch])
		SELECT [CustID]
			   ,t.SportType
			   ,t.BetType
			   ,[MinBet]
			   ,[MaxBet]
			   ,[MaxPerMatch]
			   ,[MaxPerNumber]
			   ,[MaxPayoutPerMatch]
		FROM Dep_CustBetSettingGame_Member cs WITH(NOLOCK)
			CROSS APPLY (SELECT 50 sporttype, 1 bettype
						UNION SELECT 9907, 1
						)t
		WHERE custid IN (SELECT custid FROM @tmp)
			AND cs.sporttype = 99
			AND cs.bettype = 1
			
		DELETE @tmp	
	END
END
GO


------------------------------------------------------	
-- BEGIN STEP 2: Initial settings
--------------------------------------------------------------------------------------
SET NOCOUNT ON
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

DECLARE @target VARCHAR(20),
	@srecommend INT,
	@max_custid INT
	
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target
		
CREATE TABLE #supers (custid int, isfinished bit default(0))

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
WHERE c.roleid = 4  
	AND s.islicensee = 1
	AND ci.Enabled = 1
	AND c.custid <= @max_custid
	AND c.custid IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.site IN ('spondemo','Athena000','SampleSite')	
	
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