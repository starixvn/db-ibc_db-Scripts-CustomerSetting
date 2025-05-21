/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: 20250422@Tacy	
	Task: Disable - In-house on KL DBCUST
	DB: DBGLOB-GlobCustDB
	
	Revisions:
		- 20250422@Tacy: Created [RedmineID: #222339]
*/

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'Dep_ProductBetSetting')
BEGIN
	UPDATE RepInfo
	SET active = 0
	WHERE [name] =  'Dep_ProductBetSetting'
END
ELSE
BEGIN  
	SELECT 'Dep_ProductBetSetting not exists !!!'
END
