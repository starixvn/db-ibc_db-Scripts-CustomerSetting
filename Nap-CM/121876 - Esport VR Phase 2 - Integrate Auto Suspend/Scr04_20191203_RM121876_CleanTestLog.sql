/*
	Created: 20191203@Eden
	Task: Clean temporate data (test data) for ActionID = 809 ( New ActionID for Update Autosuspend for Esports)
	RM: #121876
	DB: DBLOG/bodb_CustomerLog
*/

DELETE
FROM VRCustLog WITH(UPDLOCK,ROWLOCK)
WHERE ActionID = 809