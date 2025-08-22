/*<info serverAlias="DBCTG-bodb02"></info>*/

/*
    Created: 20250820@Tacy
	Task: [3rd Integration] - Open SP permission to TW team [Redmine: #235989]
	DB: DBCTG-bodb02
*/
---------------------------------------------------------------------------------
-- Cross-database procedure execution (Call from Transfer SPs)
USE bodb02
GO

GRANT EXECUTE ON [dbo].[Task_ExecRep_Wrapper] TO [oneseal_integration]
GO