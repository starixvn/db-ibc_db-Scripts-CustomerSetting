/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210317@Eden
	Task: Update soccer parlay betlimit follow soccer hdp for reactivate accounts - missing logic for soccer parlay [RM#149370]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

SELECT DISTINCT CustID
INTO #ReactiveCust
FROM DBLOG.bodb_CustomerLog.dbo.[DBALog_Archive_Dep_Cust_Process] WITH (NOLOCK)
WHERE [Action] = 'REACTIVATION' 
	AND [Status] = 'Done'
	AND LogTime >= '07/09/2020'

UPDATE c
SET c.MaxPerMatch1MP = c.maxpermatch
FROM custinfo c WITH(ROWLOCK) 
WHERE custid IN( SELECT custid FROM #ReactiveCust)
	AND c.MaxPerMatch1MP != c.maxpermatch

;WITH Soccer_BetLimit AS
(
SELECT custid,minbet,maxbet
FROM Dep_CustSetting c WITH(ROWLOCK) 
WHERE custid IN( SELECT custid FROM #ReactiveCust)
	AND sporttype = 1 AND bettype = 1 AND islive = 0
)
UPDATE c 
SET c.minbet = sc.minbet,
	c.maxbet = sc.maxbet
FROM Dep_CustSetting c WITH(ROWLOCK) 
	INNER JOIN Soccer_BetLimit sc ON c.custid = sc.custid
WHERE c.custid IN( SELECT custid FROM #ReactiveCust)
	AND sporttype = 1 AND bettype = 9

DROP TABLE #ReactiveCust