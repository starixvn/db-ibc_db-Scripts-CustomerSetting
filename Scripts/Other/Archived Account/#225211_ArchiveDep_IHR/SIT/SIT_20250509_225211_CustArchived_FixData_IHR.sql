/*<info serverAlias="DBCustRepl-ReplCustDB,IRS_DBTP-bodb02,IRS_DBG-bodb02,IRS_DBSIG-CustDB,IRS_DBCTG-CustDB"></info>*/
/*
	Created: 20250509@Tacy
	Task: SIT - [Dep_Customer_Archived] - fix data IHR [Redmine: #225211]
	DB: DBCustRepl-ReplCustDB,IRS_DBTP-bodb02,IRS_DBG-bodb02,IRS_DBSIG-CustDB,IRS_DBCTG-CustDB

	** SIT: have no DBTP server
*/
--> Delete waiting agents before new scan
SELECT CustID
INTO #TempDeleted
FROM Dep_Customer_Archived WITH(NOLOCK) 
WHERE status = 'waiting'
AND ArchivedDate <='20250501'

IF @@SERVERNAME IN ('SITIHRDISTC1')
BEGIN
	UPDATE d
	SET d.isDeleted=1
		,d.RepUpdateTime=SYSDATETIME()
	FROM  Dep_Customer_Archived d WITH (ROWLOCK, UPDLOCK)  
		INNER JOIN #TempDeleted t
			ON t.CustID = d.CustID
END
ELSE 
BEGIN
	WAITFOR DELAY '00:00:10' -- Wait for Dist: updated
	
	DELETE d
	FROM  Dep_Customer_Archived d WITH (ROWLOCK)  
		INNER JOIN #TempDeleted t
			ON t.CustID = d.CustID
END