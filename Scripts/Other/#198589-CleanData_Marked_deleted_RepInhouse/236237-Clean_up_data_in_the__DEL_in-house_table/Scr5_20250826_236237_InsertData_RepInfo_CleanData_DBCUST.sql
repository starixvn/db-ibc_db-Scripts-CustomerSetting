/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250826@Eden
	Task : Add table to main DB , table _Del_Inhouse [#236237]
	DB: DBCUST-CustDB
*/
USE CustDB
GO
INSERT INTO RepInfo_CleanData(DatabaseName,TableName,Version_Key,Unique_Key)
SELECT 'CustDB',t.Name AS TableName,c.name AS Version_Key,'' AS Unique_Key
FROM CustDB.Sys.tables t WITH(NOLOCK) 
	INNER JOIN CustDB.Sys.columns c WITH(NOLOCK) 
		ON t.object_id = c.object_id
WHERE t.name LIKE '%[_]Del[_]Inhouse'
	AND c.name = 'RepUpdateTime'
	AND NOT EXISTS( SELECT 1 FROM RepInfo_CleanData WITH(NOLOCK) WHERE DatabaseName = 'CustDB' AND TableName = t.[name] )
UNION ALL
SELECT 'GlobCustDB',t.Name AS TableName,c.name AS Version_Key,'' AS Unique_Key
FROM GlobCustDB.Sys.tables t WITH(NOLOCK) 
	INNER JOIN GlobCustDB.Sys.columns c WITH(NOLOCK) 
		ON t.object_id = c.object_id
WHERE t.name LIKE '%[_]Del[_]Inhouse'
	AND c.name = 'RepUpdateTime'
	AND NOT EXISTS( SELECT 1 FROM RepInfo_CleanData WITH(NOLOCK) WHERE DatabaseName = 'GlobCustDB' AND TableName = t.[name] )