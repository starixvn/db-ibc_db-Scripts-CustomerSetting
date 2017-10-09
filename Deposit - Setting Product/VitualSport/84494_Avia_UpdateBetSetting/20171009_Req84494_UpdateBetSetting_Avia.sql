/*
	Created: 20171009@Elodie
	Task: update the Setting of VS and VS2 for Avia
	Redmine: https://nexdev.net/issues/84494
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO

SELECT custid
INTO #SuperList
FROM dbo.Dep_CustSuper WITH (NOLOCK)
WHERE site = 'Avia' AND currency = 2

UPDATE cs
SET cs.MinBet = 1,	
	cs.MaxBet = 3000,
	cs.MaxPerMatch = 10000
FROM #SuperList C WITH (NOLOCK)
	INNER JOIN dbo.Dep_CustBetSetting_Agent AS cs WITH (NOLOCK) ON cs.CustID = C.custid
WHERE cs.SportType BETWEEN 180 AND 186 OR cs.SportType BETWEEN 190 AND 191 OR cs.SportType = 199
	
DROP TABLE #SuperList

