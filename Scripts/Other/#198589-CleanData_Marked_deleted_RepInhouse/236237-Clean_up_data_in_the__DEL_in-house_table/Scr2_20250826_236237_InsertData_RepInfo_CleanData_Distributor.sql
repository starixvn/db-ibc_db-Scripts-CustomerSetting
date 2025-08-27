/*<info serverAlias="DBCustRepl-ReplCustDB"></info>*/
/*
	Created: 20250826@Eden
	Task : Add table to distributors [#236237]
	DB: DBCustRepl-ReplCustDB
*/
USE ReplCustDB
GO
INSERT INTO RepInfo_CleanData(DatabaseName,TableName,Version_Key,Unique_Key)
SELECT DISTINCT 'ReplCustDB',c.[name],REPLACE(version_key,'|',','),REPLACE(REPLACE(unique_key,'|',',') ,' ','')
FROM ReplCustDB.dbo.RepInfo c WITH(NOLOCK)
WHERE c.Active = 1
	AND version_key = 'repupdatetime'
	AND NOT EXISTS( SELECT 1 FROM RepInfo_CleanData WITH(NOLOCK) WHERE DatabaseName = 'ReplCustDB' AND TableName = c.[name] )

INSERT INTO RepInfo_CleanData(DatabaseName,TableName,Version_Key,Unique_Key)
SELECT DISTINCT 'ReplDB',c.[name],REPLACE(version_key,'|',','),REPLACE(REPLACE(unique_key,'|',',') ,' ','')
FROM ReplDB.dbo.RepInfo c WITH(NOLOCK)
WHERE c.Active = 1
	AND version_key = 'repupdatetime'
	AND NOT EXISTS( SELECT 1 FROM RepInfo_CleanData WITH(NOLOCK) WHERE DatabaseName = 'ReplDB' AND TableName = c.[name] )