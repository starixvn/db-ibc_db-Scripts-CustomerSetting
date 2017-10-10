/*
	Created: 20171009@Elodie
	Task: update the Setting of VS and VS2 for Avia
	Redmine: https://nexdev.net/issues/84494
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO

SELECT ci.custid
INTO #SuperList
FROM dbo.Dep_CustSuper s WITH (NOLOCK)
	INNER JOIN Custinfo ci WITH (NOLOCK) ON s.custid = ci.srecommend
WHERE site = 'Avia' AND s.currency = 2
	AND ci.roleid BETWEEN 2 AND 4

UPDATE cs
SET cs.MinBet = 1,	
	cs.MaxBet = 3000,
	cs.MaxPerMatch = 10000
FROM #SuperList C WITH (NOLOCK)
	INNER JOIN dbo.Dep_CustBetSetting_Agent AS cs WITH (NOLOCK) ON cs.CustID = C.custid
WHERE cs.SportType BETWEEN 180 AND 186 OR cs.SportType BETWEEN 190 AND 191 OR cs.SportType = 199
	
DROP TABLE #SuperList

