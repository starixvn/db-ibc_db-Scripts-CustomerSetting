/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
/*
	Created by: Eden@20220516
	Task: Delete script check Win Loss Limit Old structure - vnDBA_CheckSetting_RunningScripts [Redmine:#164280]	
	DB: DBCHECK-CheckResultDB
*/
USE CheckResultDB
GO

DELETE t
FROM [dbo].[vnDBA_CheckSetting_RunningScripts] t WITH(ROWLOCK,UPDLOCK)
WHERE [ScriptName] = 'Win Loss Limit'