/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
/*
	Created by: Eden@20240109
	Task: Update delete unused data on vnDBA_CheckSetting_RunningScripts [Redmine:#193083]	
	DB: DBCHECK-CheckResultDB
*/
USE CheckResultDB
GO

DELETE t
--SELECT *
FROM [CheckResultDB].[dbo].[vnDBA_CheckSetting_RunningScripts] t WITH(ROWLOCK,UPDLOCK) 
WHERE [ScriptName] IN ('PT Sportbook Credit','Commission Sportbooks Credit')
/*
SELECT TOP (1000) [ScriptId]
      ,[ScriptName]
      ,[VarKey]
      ,[Threads]
      ,[Command]
FROM [CheckResultDB].[dbo].[vnDBA_CheckSetting_RunningScripts]
WHERE [ScriptName] like '%Credit%'

*/
