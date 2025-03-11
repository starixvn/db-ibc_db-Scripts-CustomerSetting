/*<info serverAlias="IRS_DBTP-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241225@Virgil	
	Task: Customer Setting - Apply In-house replication for profile setting tables
	DB: IRS_DBTP-bodb02
	
	Revisions:
		- 20241225@Virgil: Created [RedmineID: #214117]

	Table Related:
		GameLaunchPerCurrency
		GameLaunchPerSite
		ProductGlobalSetting
		ProductLaunchedSiteCurrency
		ProductSettingSystemDisplay
		ProductSettingUpdateRestriction

*/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'GameLaunchPerCurrency')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 13
		AND [name] =  'GameLaunchPerCurrency'
END
ELSE
BEGIN  
	SELECT 'GameLaunchPerCurrency not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'GameLaunchPerSite')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 13
		AND [name] =  'GameLaunchPerSite'
END
ELSE
BEGIN  
	SELECT 'GameLaunchPerSite not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductGlobalSetting')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 13
		AND [name] =  'ProductGlobalSetting'
END
ELSE
BEGIN  
	SELECT 'ProductGlobalSetting not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductLaunchedSiteCurrency')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 13
		AND [name] =  'ProductLaunchedSiteCurrency'
END
ELSE
BEGIN  
	SELECT 'ProductLaunchedSiteCurrency not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductSettingSystemDisplay')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 13
		AND [name] =  'ProductSettingSystemDisplay'
END
ELSE
BEGIN  
	SELECT 'ProductSettingSystemDisplay not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductSettingUpdateRestriction')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 13
		AND [name] =  'ProductSettingUpdateRestriction'
END
ELSE
BEGIN  
	SELECT 'ProductSettingUpdateRestriction not exists !!!'
END
GO
/***************************************************************************/



