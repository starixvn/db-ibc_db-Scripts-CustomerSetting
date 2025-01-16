/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250109@Virgil
	Task: Sitebuilder - New field for White label licensee [RedmineID: #215391]
	DB:	DBCUST-CustDB
	Description: Update SiteType for whitelabel NSDemo1SW, Starix1SW
*/

USE CustDB
GO

IF EXISTS (SELECT 1 FROM dbo.Site WITH(NOLOCK) WHERE [site] IN ('Starix1SW','NSDemo1SW'))
BEGIN
	UPDATE dbo.Site WITH(ROWLOCK,UPDLOCK)
	SET SiteType = 1,
		RepUpdateTime = SYSDATETIME()
	WHERE [site] IN ('Starix1SW','NSDemo1SW')
		AND SiteType IS NULL
END