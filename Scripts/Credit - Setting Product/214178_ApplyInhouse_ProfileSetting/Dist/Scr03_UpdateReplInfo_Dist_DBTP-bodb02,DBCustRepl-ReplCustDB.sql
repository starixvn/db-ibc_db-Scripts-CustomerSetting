/*<info serverAlias="IRS_DBTP-bodb02,DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241225@Virgil	
	Task: Customer Setting - Apply In-house replication for profile setting tables
	DB: IRS_DBTP-bodb02,DBCustRepl-ReplCustDB
	
	Revisions:
		- 20241225@Virgil: Created [RedmineID: #214117]

	Table Related:
		CategoryConfig
		GameGroup
		ProductBetSetting
		StakeLevel
		StakeLevelGroupDetail			
		ProductProfileSiteCurrency
		ProductProfileSiteCurrency_UAT
		ProductSettingProfile
		ProductSettingProfile_UAT
		ProductStatusProfile
		ProductStatusSiteCurrency
		SportNonOfferedSiteCurrency
		ProductSiteConfig
		PlayCurrencySetting
*/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CategoryConfig')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 13
		AND [name] =  'CategoryConfig'
END
ELSE
BEGIN  
	SELECT 'CategoryConfig not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'GameGroup')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 13
		AND [name] =  'GameGroup'
END
ELSE
BEGIN  
	SELECT 'GameGroup not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductBetSetting')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 13
		AND [name] =  'ProductBetSetting'
END
ELSE
BEGIN  
	SELECT 'ProductBetSetting not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'StakeLevel')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 13
		AND [name] =  'StakeLevel'
END
ELSE
BEGIN  
	SELECT 'StakeLevel not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'StakeLevelGroupDetail')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 13
		AND [name] =  'StakeLevelGroupDetail'
END
ELSE
BEGIN  
	SELECT 'StakeLevelGroupDetail not exists !!!'
END
GO
/***************************************************************************/
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
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'PlayCurrencySetting')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 13
		AND [name] =  'PlayCurrencySetting'
END
ELSE
BEGIN  
	SELECT 'PlayCurrencySetting not exists !!!'
END
GO
/***************************************************************************/
