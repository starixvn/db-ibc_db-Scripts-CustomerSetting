/*<info serverAlias="DBGLOB-GlobCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250312@Johnson	
	Task: Sync data for 2 new tables inhouse from GlobCustDB to DBTP
	DB: DBGLOB/GlobCustDB
	
	Revisions:
		- 20250312@Johnson: Sync data for 2 new tables inhouse from GlobCustDB to DBTP [RedmineID: #216870]
*/		

UPDATE Winlimit_ProductGlobalSetting WITH(ROWLOCK)
SET RepUpdateTime = dbo.f_GetDateTime2()
GO

UPDATE Winlimit_Group WITH(ROWLOCK)
SET RepUpdateTime = dbo.f_GetDateTime2()

