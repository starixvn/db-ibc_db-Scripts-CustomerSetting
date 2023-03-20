/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
/*
	Created by: Eden@20230320
	Task: Update delete unused data on vnDBA_CheckSetting_RunningScripts [Redmine:#167898]	
	DB: DBCHECK-CheckResultDB
*/
USE CheckResultDB
GO
DELETE t
--SELECT *
FROM [CheckResultDB].[dbo].[vnDBA_CheckSetting_RunningScripts] t WITH(ROWLOCK,UPDLOCK) 
WHERE [ScriptName]   IN(
	'PT 3rd Products Credit',
	'PT Game Credit',
	'Bet Limit Keno Credit',
	'Commission 3rd Products Credit',
	'Commission Game Credit',
	'Stake Level Credit'
)

/*
SELECT TOP (1000) [ScriptId]
      ,[ScriptName]
      ,[VarKey]
      ,[Threads]
      ,[Command]
FROM [CheckResultDB].[dbo].[vnDBA_CheckSetting_RunningScripts]
WHERE [ScriptName] like '%Credit%'

*/
