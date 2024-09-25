/*<info serverAlias="DBCustRepl-ReplCustDB"></info>*/
/*
	Created: 20240604@Eden
	Task: Disable job sync [#204358]
		BetSetting3rd_Agent
		BetSetting3rd_Member
	DB: DBCustRepl-ReplCustDB
*/
USE ReplCustDB
GO

UPDATE RepInfo WITH (ROWLOCK, UPDLOCK)
SET active=0
WHERE [name] IN ('BetSetting3rd_Agent','BetSetting3rd_Member')
GO

