/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210317@Eden
	Task: Update soccer parlay betlimit follow soccer hdp for reactivate accounts - missing logic for soccer parlay [RM#149370]
	DB: DBCUST/CustDB
*/

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

DROP TABLE #ReactiveCust