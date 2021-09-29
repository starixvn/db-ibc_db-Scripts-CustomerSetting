/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
/*
	Created: Eden@20210929
	Task: Remove config check betsetting on Custsetting3rd table  [Redmine: #154048]   
	DB: DBCHECK-CheckResultDB
*/
USE CheckResultDB
GO
DELETE
FROM [dbo].[vnDBA_CheckSetting_RunningScripts] WITH(ROWLOCK,UPDLOCK)
WHERE ScriptName = 'Bet Limit 3rd Products Credit'