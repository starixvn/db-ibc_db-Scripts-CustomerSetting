/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20241001@Johnson
	Task: Deposit - Adjust Sportsbook minbet of some currencies for all active licensees [RedmineID:#211341]
	DB: DBCUST/CustDB
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	 @srecommend INT
	,@max_custid INT
	,@MinBet MONEY
	,@MBParlay MONEY
	,@target VARCHAR(30) =''	
AS
BEGIN
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBSPARE','DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBSPARE','DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')) RETURN -- run at dbcust only
	
	IF(dbo.f_CheckRepTable('Dep_CustBetSettingGame_Agent') = 0				
		OR dbo.f_CheckRepTable('Dep_CustBetSettingGameGroup_Member') = 0	
		OR dbo.f_CheckRepTable('Dep_CustBetSettingGame_Member') = 0	
		OR dbo.f_CheckRepTable('CustInfo') = 0				
		OR dbo.f_CheckRepTable('Dep_CustSettingMode') = 0			
	   )
	RETURN
	
	CREATE TABLE #tblCust(CustID INT PRIMARY KEY, roleid TINYINT)
	CREATE TABLE #tmp(CustID INT PRIMARY KEY)
	DECLARE @BatchCust TABLE (CustID INT)
	DECLARE @tmpMinBet MONEY
	
	INSERT INTO #tblCust(Custid,roleid)
	SELECT custid, roleid
	FROM dbo.CustInfo ci WITH(NOLOCK)
	WHERE srecommend = @srecommend 
		AND mrecommend NOT IN (SELECT custid 
								FROM dbo.custinfo WITH(NOLOCK)
								WHERE srecommend=@srecommend 
									AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%' )
									AND roleid=3
							)
		AND (ci.username not like '%ClearBal' and ci.username not like '%CashOut' and ci.username not like '%OddsAdj' and ci.username not like '%OddsBoostAdj%')
		AND custid <= @max_custid
		
	UPDATE cs
	SET @tmpMinBet = CASE WHEN bettype <> 9 THEN @MinBet ELSE ISNULL(@MBParlay,MinBet) END,
		cs.MinBet = @tmpMinBet,
		cs.MaxBet = CASE WHEN cs.MaxBet < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxBet END,
		cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxPerMatch END,
		cs.MaxPayOutPerMatch = CASE WHEN cs.MaxPayOutPerMatch < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxPayOutPerMatch END
	FROM Dep_CustBetSettingGame_Agent cs WITH(UPDLOCK)
	WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid IN(2,3,4))
		AND sporttype <> 161
		AND MinBet NOT IN (0, 0.1) AND MaxBet NOT IN (0, 0.1) AND MaxPerMatch NOT IN (0, 0.1) AND MaxPayOutPerMatch NOT IN (0, 0.1)
		AND MinBet < CASE WHEN bettype <> 9 THEN @MinBet ELSE ISNULL(@MBParlay,MinBet) END
	
	UPDATE cs
	SET @tmpMinBet = CASE WHEN bettype <> 9 THEN @MinBet ELSE ISNULL(@MBParlay,MinBet) END,
		cs.MinBet = @tmpMinBet,
		cs.MaxBet = CASE WHEN cs.MaxBet < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxBet END,
		cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxPerMatch END,
		cs.MaxPayOutPerMatch = CASE WHEN cs.MaxPayOutPerMatch < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxPayOutPerMatch END
	FROM Dep_CustBetSettingGameGroup_Member cs WITH(UPDLOCK)
	WHERE AgentID IN (SELECT custid FROM #tblCust WHERE roleid = 2)
		AND sporttype <> 161
		AND MinBet NOT IN (0, 0.1) AND MaxBet NOT IN (0, 0.1) AND MaxPerMatch NOT IN (0, 0.1) AND MaxPayOutPerMatch NOT IN (0, 0.1)
		AND MinBet < CASE WHEN bettype <> 9 THEN @MinBet ELSE ISNULL(@MBParlay,MinBet) END
		
	DELETE t
	FROM #tblCust t
		INNER JOIN Dep_CustSettingMode cs WITH(NOLOCK) ON t.custid = cs.custid
	WHERE cs.IsGroupedBetLimit = 1
		AND roleid = 1
	
	INSERT INTO #tmp(custid)
	SELECT DISTINCT cs.custid
	FROM Dep_CustBetSettingGame_Member cs WITH(NOLOCK,FORCESEEK)
	WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid = 1)
		AND sporttype <> 161
		AND MinBet NOT IN (0, 0.1) AND MaxBet NOT IN (0, 0.1) AND MaxPerMatch NOT IN (0, 0.1) AND MaxPayOutPerMatch NOT IN (0, 0.1)
		AND MinBet < CASE WHEN bettype <> 9 THEN @MinBet ELSE ISNULL(@MBParlay,MinBet) END
	OPTION (MAXDOP 1) 		
	
	WHILE(1=1)
	BEGIN
		DELETE TOP(500) t
		OUTPUT DELETED.custid INTO @BatchCust(custid)
		FROM #tmp t
		
		IF @@ROWCOUNT = 0
			BREAK;
		
		UPDATE cs
		SET @tmpMinBet = CASE WHEN bettype <> 9 THEN @MinBet ELSE ISNULL(@MBParlay,MinBet) END,
			cs.MinBet = @tmpMinBet,
			cs.MaxBet = CASE WHEN cs.MaxBet < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxBet END,
			cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxPerMatch END,
			cs.MaxPayOutPerMatch = CASE WHEN cs.MaxPayOutPerMatch < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxPayOutPerMatch END
		FROM Dep_CustBetSettingGame_Member cs WITH(UPDLOCK)
		WHERE custid IN (SELECT custid FROM @BatchCust)
			AND sporttype <> 161
			AND MinBet NOT IN (0, 0.1) AND MaxBet NOT IN (0, 0.1) AND MaxPerMatch NOT IN (0, 0.1) AND MaxPayOutPerMatch NOT IN (0, 0.1)
			AND MinBet < CASE WHEN bettype <> 9 THEN @MinBet ELSE ISNULL(@MBParlay,MinBet) END
		
		DELETE @BatchCust		
	END	
		
	DROP TABLE #tblCust
	DROP TABLE #tmp
END
GO
--End Step 1
------------------------------------------------------


---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) AND DBCUST (Run last)-----
--------------------------------------------------------------------------------------

DECLARE @srecommend INT, 
		@max_custid INT = xxx,
		@MinBet MONEY,
		@MBParlay MONEY

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'	

Print 'Server Name : ' + @target

CREATE TABLE #Super(CustID INT, MinBet MONEY, MBParlay MONEY, isfinished BIT DEFAULT(0))
DECLARE @tmpSetting TABLE (code VARCHAR(3), MinBet MONEY, MBParlay MONEY)

INSERT INTO @tmpSetting(code,MinBet,MBParlay)
SELECT 'CNY',    10, 3
UNION ALL SELECT 'IDR',    8, 7
UNION ALL SELECT 'VND',    30, 10
UNION ALL SELECT 'MYR',    10, 2
UNION ALL SELECT 'THB',    50, 15
UNION ALL SELECT 'INR',    100, 40
UNION ALL SELECT 'BDT',    150, 60
UNION ALL SELECT 'PKR',    350, 130
UNION ALL SELECT 'BRL',    6, 3

INSERT INTO #Super(custid, MinBet, MBParlay)
SELECT cs.custid, t.MinBet, t.MBParlay
FROM dbo.Dep_CustSuper cs WITH(NOLOCK)
	INNER JOIN bodb_Licensee.dbo.licensees l WITH(NOLOCK) ON l.LicenseeName = cs.site
	CROSS APPLY (SELECT t.MinBet, t.MBParlay
				FROM exchange e WITH(NOLOCK)
					INNER JOIN @tmpSetting t ON e.Code = t.Code
				WHERE cs.currency = e.ExchangeId
				)t
WHERE l.IsActive = 1
	
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #super)

DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Super
	SET isfinished = 1
		,@srecommend = custid
		,@MinBet = MinBet
		,@MBParlay = MBParlay
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
		
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @srecommend = @srecommend
			,@max_custid = @max_custid
			,@MinBet = @MinBet
			,@MBParlay = @MBParlay
			,@target = @target
	
	waitfor delay '00:00:0.280'
END			
GO	

-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (DBTP) AND DBCUST (Run last) -----
-----------------------------------------------------------------------------------	
