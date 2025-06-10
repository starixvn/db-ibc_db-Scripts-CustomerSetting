/*<info serverAlias="DBBOF-bodb2"></info>*/
/*
	Created: 20250603@Tacy
	Task: Grant permission - [wsv_lap] (Redmine: #227673)
	DB: DBBOF-bodb2
*/
USE bodb02
GO

GRANT EXECUTE ON [dbo].[NAP_Admin_GetMovebetDate] TO [wsv_lap]
GO