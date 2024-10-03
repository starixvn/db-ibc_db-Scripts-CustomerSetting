/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20241001@Johnson
	Task: Deposit - Adjust Sportsbook minbet of some currencies for all active licensees [RedmineID:#211341]
	DB: DBCUST/CustDB
*/
DECLARE @max_custid INT = xxx
CREATE TABLE #Super(CustID INT, MinBet MONEY, MBParlay MONEY, isfinished BIT DEFAULT(0))
DECLARE @tmpSetting TABLE (code VARCHAR(3), MinBet MONEY, MBParlay MONEY)
DECLARE @tmpMinBet MONEY

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

CREATE TABLE #tblCust(CustID INT PRIMARY KEY, srecommend INT, roleid TINYINT)
CREATE TABLE #tmp(CustID INT PRIMARY KEY, srecommend INT)
DECLARE @BatchCust TABLE (CustID INT PRIMARY KEY, srecommend INT)

INSERT INTO #tblCust(Custid,srecommend,roleid)
SELECT custid,srecommend,roleid
FROM dbo.CustInfo ci WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM #Super)
	AND mrecommend NOT IN (SELECT custid 
							FROM dbo.custinfo WITH(NOLOCK)
							WHERE srecommend IN (SELECT custid FROM #Super)
								AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%' )
								AND roleid=3
						)
	AND (ci.username not like '%ClearBal' and ci.username not like '%CashOut' and ci.username not like '%OddsAdj' and ci.username not like '%OddsBoostAdj%')
	AND custid > @max_custid

INSERT INTO @BatchCust(custid, srecommend)
SELECT DISTINCT t.custid, t.srecommend
FROM Dep_CustBetSettingGame_Agent cs WITH(NOLOCK)
	INNER JOIN #tblCust t ON cs.custid = t.custid
	INNER JOIN #Super s ON t.srecommend = s.custid
WHERE roleid IN(2,3,4)
	AND sporttype <> 161
	AND cs.MinBet NOT IN (0, 0.1) AND MaxBet NOT IN (0, 0.1) AND MaxPerMatch NOT IN (0, 0.1) AND MaxPayOutPerMatch NOT IN (0, 0.1)
	AND cs.MinBet < CASE WHEN cs.Bettype <> 9 THEN s.MinBet ELSE ISNULL(s.MBParlay,cs.MinBet) END	

IF @@ROWCOUNT > 0
BEGIN
	UPDATE cs
	SET @tmpMinBet = CASE WHEN cs.Bettype <> 9 THEN s.MinBet ELSE ISNULL(s.MBParlay,cs.MinBet) END,
		cs.MinBet = @tmpMinBet,
		cs.MaxBet = CASE WHEN cs.MaxBet < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxBet END,
		cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxPerMatch END,
		cs.MaxPayOutPerMatch = CASE WHEN cs.MaxPayOutPerMatch < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxPayOutPerMatch END,
		RepUpdateTime = dbo.f_GetDateTime2()
	FROM Dep_CustBetSettingGame_Agent cs WITH(UPDLOCK)
		INNER JOIN @BatchCust t ON cs.custid = t.custid
		INNER JOIN #Super s ON t.srecommend = s.custid
	WHERE sporttype <> 161
			AND cs.MinBet NOT IN (0, 0.1) AND MaxBet NOT IN (0, 0.1) AND MaxPerMatch NOT IN (0, 0.1) AND MaxPayOutPerMatch NOT IN (0, 0.1)
			AND cs.MinBet < CASE WHEN cs.Bettype <> 9 THEN s.MinBet ELSE ISNULL(s.MBParlay,cs.MinBet) END	
			
	DELETE @BatchCust		
END		

UPDATE cs
SET @tmpMinBet = CASE WHEN cs.Bettype <> 9 THEN s.MinBet ELSE ISNULL(s.MBParlay,cs.MinBet) END,
	cs.MinBet = @tmpMinBet,
	cs.MaxBet = CASE WHEN cs.MaxBet < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxBet END,
	cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxPerMatch END,
	cs.MaxPayOutPerMatch = CASE WHEN cs.MaxPayOutPerMatch < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxPayOutPerMatch END,
	RepUpdateTime= dbo.f_GetDateTime2()
FROM Dep_CustBetSettingGameGroup_Member cs WITH(UPDLOCK)
	INNER JOIN #tblCust t ON cs.AgentID = t.custid
	INNER JOIN #Super s ON t.srecommend = s.custid
WHERE roleid = 2
	AND sporttype <> 161
	AND cs.MinBet NOT IN (0, 0.1) AND MaxBet NOT IN (0, 0.1) AND MaxPerMatch NOT IN (0, 0.1) AND MaxPayOutPerMatch NOT IN (0, 0.1)
	AND cs.MinBet < CASE WHEN cs.Bettype <> 9 THEN s.MinBet ELSE ISNULL(s.MBParlay,cs.MinBet) END	
		
DELETE t
FROM #tblCust t
	INNER JOIN Dep_CustSettingMode cs WITH(NOLOCK) ON t.custid = cs.custid
WHERE cs.IsGroupedBetLimit = 1
	AND roleid = 1
	
INSERT INTO #tmp(custid, srecommend)
SELECT DISTINCT t.custid, t.srecommend
FROM Dep_CustBetSettingGame_Member cs WITH(NOLOCK)
	INNER JOIN #tblCust t ON cs.custid = t.custid
	INNER JOIN #Super s ON t.srecommend = s.custid
WHERE roleid = 1
	AND sporttype <> 161
	AND cs.MinBet NOT IN (0, 0.1) AND MaxBet NOT IN (0, 0.1) AND MaxPerMatch NOT IN (0, 0.1) AND MaxPayOutPerMatch NOT IN (0, 0.1)
	AND cs.MinBet < CASE WHEN cs.Bettype <> 9 THEN s.MinBet ELSE ISNULL(s.MBParlay,cs.MinBet) END	
	
IF @@ROWCOUNT > 0
BEGIN
	WHILE(1=1)
	BEGIN
		DELETE TOP(200) t
		OUTPUT DELETED.custid, DELETED.srecommend
		INTO @BatchCust(custid,srecommend)
		FROM #tblCust t
		WHERE roleid = 1
		
		IF @@ROWCOUNT =0
			BREAK;
			
		UPDATE cs
		SET @tmpMinBet = CASE WHEN cs.Bettype <> 9 THEN s.MinBet ELSE ISNULL(s.MBParlay,cs.MinBet) END,
			cs.MinBet = @tmpMinBet,
			cs.MaxBet = CASE WHEN cs.MaxBet < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxBet END,
			cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxPerMatch END,
			cs.MaxPayOutPerMatch = CASE WHEN cs.MaxPayOutPerMatch < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxPayOutPerMatch END,
			RepUpdateTime = dbo.f_GetDateTime2()
		FROM Dep_CustBetSettingGame_Member cs WITH(UPDLOCK)
			INNER JOIN @BatchCust t ON cs.custid = t.custid
			INNER JOIN #Super s ON t.srecommend = s.custid
		WHERE sporttype <> 161
			AND cs.MinBet NOT IN (0, 0.1) AND MaxBet NOT IN (0, 0.1) AND MaxPerMatch NOT IN (0, 0.1) AND MaxPayOutPerMatch NOT IN (0, 0.1)
			AND cs.MinBet < CASE WHEN cs.Bettype <> 9 THEN s.MinBet ELSE ISNULL(s.MBParlay,cs.MinBet) END	
				
		DELETE @BatchCust		
	END
END	

DROP TABLE #tblCust
DROP TABLE #tmp	
DROP TABLE #Super	
		