/*<info serverAlias="DBLOG-bodb_customerlog"></info>*/

/*
    Created: 20250820@Tacy
	Task: [3rd Integration] - Open SP permission to TW team [Redmine: #235989]
	DB: DBLOG-bodb_customerlog
*/
---------------------------------------------------------------------------------
-- Cross-server procedure execution (Call from Transfer SPs)
USE bodb_customerlog
GO

GRANT EXECUTE ON [dbo].[WriteLog_UserLog_Transfer] TO [oneseal_integration]
GO
