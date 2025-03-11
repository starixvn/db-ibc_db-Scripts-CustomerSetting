/*<info serverAlias="IRS_DBAGE-bodb02,IRS_DBBOF-bodb02,IRS_DBACC-bodb02,IRS_DBBAH-bodb02,IRS_DBSIG-CustDB,IRS_DBCTG-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241225@Virgil	
	Task: Customer Setting - Apply In-house replication for profile setting tables
	DB: IRS_DBAGE-bodb02,IRS_DBBOF-bodb02,IRS_DBACC-bodb02,IRS_DBBAH-bodb02,IRS_DBSIG-CustDB,IRS_DBCTG-CustDB
	
	Revisions:
		- 20241225@Virgil: Created [RedmineID: #214117]

	Tables Related:
		ProductProfileSiteCurrency
		ProductProfileSiteCurrency_UAT
		ProductSettingProfile
		ProductSettingProfile_UAT
		ProductStatusProfile
		ProductStatusSiteCurrency
		SportNonOfferedSiteCurrency			
*/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductProfileSiteCurrency')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 13
		AND [name] =  'ProductProfileSiteCurrency'
END
ELSE
BEGIN  
	SELECT 'ProductProfileSiteCurrency not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductProfileSiteCurrency_UAT')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 13
		AND [name] =  'ProductProfileSiteCurrency_UAT'
END
ELSE
BEGIN  
	SELECT 'ProductProfileSiteCurrency_UAT not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductSettingProfile')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 13
		AND [name] =  'ProductSettingProfile'
END
ELSE
BEGIN  
	SELECT 'ProductSettingProfile not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductSettingProfile_UAT')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 13
		AND [name] =  'ProductSettingProfile_UAT'
END
ELSE
BEGIN  
	SELECT 'ProductSettingProfile_UAT not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductStatusProfile')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 13
		AND [name] =  'ProductStatusProfile'
END
ELSE
BEGIN  
	SELECT 'ProductStatusProfile not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductStatusSiteCurrency')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 13
		AND [name] =  'ProductStatusSiteCurrency'
END
ELSE
BEGIN  
	SELECT 'ProductStatusSiteCurrency not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'SportNonOfferedSiteCurrency')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 13
		AND [name] =  'SportNonOfferedSiteCurrency'
END
ELSE
BEGIN  
	SELECT 'SportNonOfferedSiteCurrency not exists !!!'
END
GO
/***************************************************************************/



