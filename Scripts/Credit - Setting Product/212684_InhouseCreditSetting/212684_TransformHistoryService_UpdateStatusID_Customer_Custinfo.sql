/*<info serverAlias="DBHIS-bodb_CustHistory" executers="" viewers="" isFunction="0"></info>*/
/*
	 Created by: 20241224@Johnson
	 Task: Credit - Transform data from DBCUST/CustDB_History to DBTP/bodb_CustHistory  [Redmine:#212684]
	 DB: DBTP-bodb_CustHistory
*/


USE bodb_CustHistory
GO

UPDATE Dest_ServiceTransform WITH(ROWLOCK, UPDLOCK)
SET StatusID = 1
WHERE StatusID = 0
	AND TableName IN  (		
		'CustInfo_History',		
		'Customer_History'
	)	
