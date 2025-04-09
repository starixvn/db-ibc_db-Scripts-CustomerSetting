/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250219@Virgil
	Task: SABA Keno - Implement Setting and Initial data [RedmineID: #214757]
	DB:	DBCUST-CustDB
	Note: Mismatch SiteDBGroupID between SIT and Pro
*/

UPDATE dbo.Site WITH (ROWLOCK,UPDLOCK)
SET SiteDBGroupID = 3,
	RepUpdateTime = dbo.f_GetDateTime2()
WHERE SiteLabel = '789y' AND SiteDBGroupID = 0