/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250520@Tacy
	Task: Deposit - Adjust Sportsbook minbet of IDR currency for all active licensees [RedmineID:#227852]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @max_custid INT = xxx
CREATE TABLE #Super(CustID INT, MBParlay MONEY, isfinished BIT DEFAULT(0))
DECLARE @tmpSetting TABLE (code VARCHAR(3), MBParlay MONEY)
DECLARE @tmpMinBet MONEY

INSERT INTO @tmpSetting(code,MBParlay)
SELECT 'IDR', 5

INSERT INTO #Super(custid, MBParlay)
SELECT cs.custid, t.MBParlay
FROM dbo.Dep_CustSuper cs WITH(NOLOCK)
	INNER JOIN bodb_Licensee.dbo.licensees l WITH(NOLOCK) ON l.LicenseeName = cs.site
	CROSS APPLY (SELECT t.MBParlay
				FROM exchange e WITH(NOLOCK)
					INNER JOIN @tmpSetting t ON e.Code = t.Code
				WHERE cs.currency = e.ExchangeId
				)t
WHERE l.IsActive = 1	

CREATE TABLE #tblCust(CustID INT PRIMARY KEY, srecommend INT, roleid TINYINT)
CREATE TABLE #tmp(CustID INT PRIMARY KEY, srecommend INT)
DECLARE @BatchCust TABLE (CustID INT PRIMARY KEY, srecommend INT)

INSERT INTO #tblCust(Custid,srecommend,roleid)
SELECT ci.custid,srecommend,roleid
FROM dbo.CustInfo ci WITH(NOLOCK)
OUTER APPLY (SELECT f.custid FROM dbo.f_Dep_DummyMember_Select(ci.srecommend) f
				 WHERE f.custid=ci.custid) dm
WHERE srecommend IN (SELECT custid FROM #Super)
	AND mrecommend NOT IN (SELECT custid 
							FROM dbo.custinfo WITH(NOLOCK)
							WHERE srecommend IN (SELECT custid FROM #Super)
								AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%' )
								AND roleid=3
						)
	AND dm.custid IS NULL
	AND ci.custid > @max_custid

INSERT INTO @BatchCust(custid, srecommend)
SELECT DISTINCT t.custid, t.srecommend
FROM Dep_CustBetSettingGame_Agent cs WITH(NOLOCK)
	INNER JOIN #tblCust t ON cs.custid = t.custid
	INNER JOIN #Super s ON t.srecommend = s.custid
WHERE roleid IN(2,3,4)
	AND sporttype <> 161 AND BetType=9
	AND cs.MinBet NOT IN (0, 0.1) AND MaxBet NOT IN (0, 0.1) AND MaxPerMatch NOT IN (0, 0.1) AND MaxPayOutPerMatch NOT IN (0, 0.1)
	AND cs.MinBet > ISNULL(s.MBParlay,cs.MinBet)	

IF @@ROWCOUNT > 0
BEGIN
	UPDATE cs
	SET @tmpMinBet = ISNULL(s.MBParlay,cs.MinBet),
		cs.MinBet = @tmpMinBet,
		cs.MaxBet = CASE WHEN cs.MaxBet < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxBet END,
		cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxPerMatch END,
		cs.MaxPayOutPerMatch = CASE WHEN cs.MaxPayOutPerMatch < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxPayOutPerMatch END,
		RepUpdateTime = dbo.f_GetDateTime2()
	FROM Dep_CustBetSettingGame_Agent cs WITH(UPDLOCK)
		INNER JOIN @BatchCust t ON cs.custid = t.custid
		INNER JOIN #Super s ON t.srecommend = s.custid
	WHERE sporttype <> 161 AND BetType=9
			AND cs.MinBet NOT IN (0, 0.1) AND MaxBet NOT IN (0, 0.1) AND MaxPerMatch NOT IN (0, 0.1) AND MaxPayOutPerMatch NOT IN (0, 0.1)
			AND cs.MinBet > ISNULL(s.MBParlay,cs.MinBet)	
			
	DELETE @BatchCust		
END		

UPDATE cs
SET @tmpMinBet = ISNULL(s.MBParlay,cs.MinBet),
	cs.MinBet = @tmpMinBet,
	cs.MaxBet = CASE WHEN cs.MaxBet < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxBet END,
	cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxPerMatch END,
	cs.MaxPayOutPerMatch = CASE WHEN cs.MaxPayOutPerMatch < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxPayOutPerMatch END,
	RepUpdateTime= dbo.f_GetDateTime2()
FROM Dep_CustBetSettingGameGroup_Member cs WITH(UPDLOCK)
	INNER JOIN #tblCust t ON cs.AgentID = t.custid
	INNER JOIN #Super s ON t.srecommend = s.custid
WHERE roleid = 2
	AND sporttype <> 161 AND BetType=9
	AND cs.MinBet NOT IN (0, 0.1) AND MaxBet NOT IN (0, 0.1) AND MaxPerMatch NOT IN (0, 0.1) AND MaxPayOutPerMatch NOT IN (0, 0.1)
	AND cs.MinBet > ISNULL(s.MBParlay,cs.MinBet)	
		
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
	AND sporttype <> 161 AND BetType=9
	AND cs.MinBet NOT IN (0, 0.1) AND MaxBet NOT IN (0, 0.1) AND MaxPerMatch NOT IN (0, 0.1) AND MaxPayOutPerMatch NOT IN (0, 0.1)
	AND cs.MinBet > ISNULL(s.MBParlay,cs.MinBet)	
	
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
		SET @tmpMinBet = ISNULL(s.MBParlay,cs.MinBet),
			cs.MinBet = @tmpMinBet,
			cs.MaxBet = CASE WHEN cs.MaxBet < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxBet END,
			cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxPerMatch END,
			cs.MaxPayOutPerMatch = CASE WHEN cs.MaxPayOutPerMatch < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxPayOutPerMatch END,
			RepUpdateTime = dbo.f_GetDateTime2()
		FROM Dep_CustBetSettingGame_Member cs WITH(UPDLOCK)
			INNER JOIN @BatchCust t ON cs.custid = t.custid
			INNER JOIN #Super s ON t.srecommend = s.custid
		WHERE sporttype <> 161 AND BetType=9
			AND cs.MinBet NOT IN (0, 0.1) AND MaxBet NOT IN (0, 0.1) AND MaxPerMatch NOT IN (0, 0.1) AND MaxPayOutPerMatch NOT IN (0, 0.1)
			AND cs.MinBet > ISNULL(s.MBParlay,cs.MinBet)	
				
		DELETE @BatchCust		
	END
END	

DROP TABLE #tblCust
DROP TABLE #tmp	
DROP TABLE #Super	
		