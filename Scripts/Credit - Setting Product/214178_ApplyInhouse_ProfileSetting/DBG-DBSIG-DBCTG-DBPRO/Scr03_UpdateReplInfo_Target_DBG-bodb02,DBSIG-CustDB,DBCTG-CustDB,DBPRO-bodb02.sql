/*<info serverAlias="IRS_DBAGE-bodb02,IRS_DBBOF-bodb02,IRS_DBACC-bodb02,IRS_DBBAH-bodb02,IRS_DBSIG-CustDB,IRS_DBCTG-CustDB,IRS_DBPRO-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241225@Virgil	
	Task: Customer Setting - Apply In-house replication for profile setting tables
	DB: IRS_DBAGE-bodb02,IRS_DBBOF-bodb02,IRS_DBACC-bodb02,IRS_DBBAH-bodb02,IRS_DBSIG-CustDB,IRS_DBCTG-CustDB,IRS_DBPRO-bodb02
	
	Revisions:
		- 20241225@Virgil: Created [RedmineID: #214117]

	Table Related: ProductSiteConfig			
*/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductSiteConfig')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 13
		AND [name] =  'ProductSiteConfig'
END
ELSE
BEGIN  
	SELECT 'ProductSiteConfig not exists !!!'
END
GO
/***************************************************************************/



