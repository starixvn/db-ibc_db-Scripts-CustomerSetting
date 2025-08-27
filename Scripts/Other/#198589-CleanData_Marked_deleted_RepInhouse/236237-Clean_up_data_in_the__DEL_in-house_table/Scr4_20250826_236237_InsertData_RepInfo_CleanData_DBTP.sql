/*<info serverAlias="DBTP-bodb02"></info>*/
/*
	Created: 20250826@Eden
	Task : Add table to distributors [#236237]
	DB: DBTP-bodb02
*/
USE bodb02
GO
INSERT INTO RepInfo_CleanData(DatabaseName,TableName,Version_Key,Unique_Key)
SELECT DISTINCT 'bodb02',c.[name],REPLACE(version_key,'|',','),REPLACE(REPLACE(unique_key,'|',',') ,' ','')
FROM bodb02.dbo.RepInfo c WITH(NOLOCK)
WHERE c.Active = 1
	AND version_key = 'repupdatetime'
	AND NOT EXISTS( SELECT 1 FROM RepInfo_CleanData WITH(NOLOCK) WHERE DatabaseName = 'bodb02' AND TableName = c.[name] )