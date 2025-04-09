/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250219@Virgil
	Task: SABA Keno - Implement Setting and Initial data [RedmineID: #214757]
	DB:	DBCUST-CustDB
	Note: QC Test SIT
*/

UPDATE dbo.ProductLaunchedSiteCurrency WITH (ROWLOCK,UPDLOCK)
SET IsLaunched = 1,
	RepUpdateTime = dbo.f_GetDateTime2()
WHERE SportType = 200 AND siteid = 1045