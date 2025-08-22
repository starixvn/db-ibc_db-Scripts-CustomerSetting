/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250821@Tacy
	Task: Deposit - Adjust Sportsbook minbet for TGXISW [RedmineID:#236681]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @max_custid INT = xxx

---------------------------------------------------------------------------------------------
DECLARE @tmpSetting TABLE (code VARCHAR(3), MinBet MONEY)
DECLARE @SportBettype TABLE (SportType SMALLINT
								,BetType SMALLINT)
INSERT INTO @tmpSetting(code,MinBet)
SELECT 'PHP', 10

INSERT INTO @SportBettype (SportType, BetType)
SELECT DISTINCT psd.SportType, psd.BetType
FROM Dep_ProductSetting ps WITH (NOLOCK)
INNER JOIN Dep_ProductSettingDetail psd WITH (NOLOCK)
		ON ps.ProductSettingID=psd.ProductSettingID
WHERE ps.ProductID=1 AND ps.SettingType=10

---------------------------------------------------------------------------------------------
CREATE TABLE #Super(CustID INT PRIMARY KEY, MinBet MONEY)
CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
CREATE TABLE #SMAs (CustID INT PRIMARY KEY, RoleID TINYINT, MinBet MONEY)
CREATE TABLE #Members (CustID INT PRIMARY KEY, MinBet MONEY)

--supers
INSERT INTO #Super(custid, MinBet)
SELECT cs.custid, t.MinBet
FROM dbo.Dep_CustSuper cs WITH(NOLOCK)
	INNER JOIN bodb_Licensee.dbo.licensees l WITH(NOLOCK) ON l.LicenseeName = cs.site
	CROSS APPLY (SELECT t.MinBet
				FROM exchange e WITH(NOLOCK)
					INNER JOIN @tmpSetting t ON e.Code = t.Code
				WHERE cs.currency = e.ExchangeId
				)t
WHERE l.IsActive = 1 AND l.LicenseeName='TGXISW'
	
--Dummy line
INSERT INTO #Dummy(CustID)
SELECT c.CustID 
FROM Customer c WITH(NOLOCK) 
INNER JOIN #Super s ON s.CustID=c.srecommend 
WHERE c.roleid=3 
	AND c.custid > @max_custid
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

--SMAs
INSERT INTO #SMAs (CustID, RoleID, MinBet)
SELECT c.custid, c.roleid, s.MinBet
FROM dbo.CustInfo c WITH(NOLOCK)
INNER JOIN #Super s ON s.CustID=c.srecommend 
WHERE mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND c.custid > @max_custid
	AND c.roleid IN (2,3,4)
	AND c.Enabled=1

--Members have individual settings only
INSERT INTO #Members (CustID, MinBet)
SELECT c.custid, s.MinBet
FROM dbo.CustInfo c WITH(NOLOCK)
INNER JOIN #Super s ON s.CustID=c.srecommend 
INNER JOIN Dep_CustSettingMode m WITH (NOLOCK) ON c.custid=m.CustID
WHERE mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND c.custid > @max_custid
	AND c.roleid = 1
	AND c.Enabled=1
	AND m.IsGroupedBetLimit=0

IF EXISTS (SELECT TOP 1 1 FROM #SMAs)
BEGIN
	UPDATE main
		SET main.minbet	= tmp.MinBet
			,main.RepUpdateTime=dbo.f_GetDateTime2()
	FROM dbo.Dep_CustBetSettingGame_Agent main WITH(ROWLOCK, UPDLOCK)
		INNER JOIN #SMAs tmp	ON main.CustID=tmp.CustID
		CROSS APPLY (SELECT * FROM @SportBettype s 
					 WHERE s.SportType = main.sporttype 
					 AND s.BetType = main.bettype) sb
	WHERE main.MinBet NOT IN (0, 0.1) AND MaxBet NOT IN (0, 0.1) AND MaxPerMatch NOT IN (0, 0.1) AND MaxPayOutPerMatch NOT IN (0, 0.1)
		
	UPDATE main
		SET main.minbet	= tmp.MinBet
			,main.RepUpdateTime=dbo.f_GetDateTime2()
	FROM dbo.Dep_CustBetSettingGameGroup_Member main WITH(ROWLOCK, UPDLOCK)
		INNER JOIN #SMAs tmp	ON main.AgentID=tmp.CustID
		CROSS APPLY (SELECT * FROM @SportBettype s 
					 WHERE s.SportType = main.sporttype 
					 AND s.BetType = main.bettype) sb
	WHERE main.MinBet NOT IN (0, 0.1) AND MaxBet NOT IN (0, 0.1) AND MaxPerMatch NOT IN (0, 0.1) AND MaxPayOutPerMatch NOT IN (0, 0.1)
END

IF EXISTS (SELECT TOP 1 1 FROM #Members)
BEGIN
	UPDATE main
		SET main.minbet	= tmp.MinBet
			,main.RepUpdateTime=dbo.f_GetDateTime2()
	FROM dbo.Dep_CustBetSettingGame_Member main WITH(ROWLOCK, UPDLOCK)
		INNER JOIN #SMAs tmp	ON main.CustID=tmp.CustID
		CROSS APPLY (SELECT * FROM @SportBettype s 
					 WHERE s.SportType = main.sporttype 
					 AND s.BetType = main.bettype) sb
	WHERE main.MinBet NOT IN (0, 0.1) AND MaxBet NOT IN (0, 0.1) AND MaxPerMatch NOT IN (0, 0.1) AND MaxPayOutPerMatch NOT IN (0, 0.1)
END

DROP TABLE #Dummy, #SMAs, #Super, #Members
GO
	