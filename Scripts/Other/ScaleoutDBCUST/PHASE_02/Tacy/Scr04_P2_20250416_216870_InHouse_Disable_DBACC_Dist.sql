/*<info serverAlias="IRS_DBACC-bodb02,IRS_DBTP-bodb02,DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250116@Tacy	
	Task: Disable In-house on DBACC, Distributor
	DB: IRS_DBACC-bodb02,IRS_DBTP-bodb02,DBCustRepl-ReplCustDB
	
	Revisions:
		- 20250116@Tacy: Created [RedmineID: #216870]
*/

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
	Dep_ProductSetting
	Dep_ProductSettingDetail
	Dep_ProductStatusProfile
*/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'Dep_ProductSetting')
BEGIN
	UPDATE RepInfo
	SET active = 0
	WHERE [name] =  'Dep_ProductSetting'
END
ELSE
BEGIN  
	SELECT 'Dep_ProductSetting not exists !!!'
END

IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'Dep_ProductSettingDetail')
BEGIN
	UPDATE RepInfo
	SET active = 0
	WHERE [name] =  'Dep_ProductSettingDetail'
END
ELSE
BEGIN  
	SELECT 'Dep_ProductSettingDetail not exists !!!'
END

IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'Dep_ProductStatusProfile')
BEGIN
	UPDATE RepInfo
	SET active = 0
	WHERE [name] =  'Dep_ProductStatusProfile'
END
ELSE
BEGIN  
	SELECT 'Dep_ProductStatusProfile not exists !!!'
END

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
	Dep_ProductBetSetting
	Dep_StakeLevel
	Dep_StakeLevelGroupDetail

	GameGroup

	ProductBetSetting
	StakeLevel

	GameRoundBetLimitSettings
*/
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

IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'Dep_StakeLevel')
BEGIN
	UPDATE RepInfo
	SET active = 0
	WHERE [name] =  'Dep_StakeLevel'
END
ELSE
BEGIN  
	SELECT 'Dep_StakeLevel not exists !!!'
END

IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'Dep_StakeLevelGroupDetail')
BEGIN
	UPDATE RepInfo
	SET active = 0
	WHERE [name] =  'Dep_StakeLevelGroupDetail'
END
ELSE
BEGIN  
	SELECT 'Dep_StakeLevelGroupDetail not exists !!!'
END

IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'GameGroup')
BEGIN
	UPDATE RepInfo
	SET active = 0
	WHERE [name] =  'GameGroup'
END
ELSE
BEGIN  
	SELECT 'GameGroup not exists !!!'
END

IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductBetSetting')
BEGIN
	UPDATE RepInfo
	SET active = 0
	WHERE [name] =  'ProductBetSetting'
END
ELSE
BEGIN  
	SELECT 'ProductBetSetting not exists !!!'
END

IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'StakeLevel')
BEGIN
	UPDATE RepInfo
	SET active = 0
	WHERE [name] =  'StakeLevel'
END
ELSE
BEGIN  
	SELECT 'StakeLevel not exists !!!'
END

IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'GameRoundBetLimitSettings')
BEGIN
	UPDATE RepInfo
	SET active = 0
	WHERE [group] = 12
		AND [name] =  'GameRoundBetLimitSettings'
END
ELSE
BEGIN  
	SELECT 'GameRoundBetLimitSettings not exists !!!'
END

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* -- on DBACC & DBTP 

	DomainManagement
	ProductStakeLevelGroup
	Dep_ProductStakeLevelGroup
*/
IF @@SERVERNAME NOT IN ('DB-60\DevDBcust', 'TESTDBCUST', 'SITIHRDISTC1', 'IHRDISTC1') 
BEGIN
	IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'DomainManagement')
	BEGIN
		UPDATE RepInfo
		SET active = 0
		WHERE [name] =  'DomainManagement'
	END
	ELSE
	BEGIN  
		SELECT 'DomainManagement not exists !!!'
	END
		
	IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductStakeLevelGroup')
	BEGIN
		UPDATE RepInfo
		SET active = 0
		WHERE [name] =  'ProductStakeLevelGroup'
	END
	ELSE
	BEGIN  
		SELECT 'ProductStakeLevelGroup not exists !!!'
	END
		
	IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'Dep_ProductStakeLevelGroup')
	BEGIN
		UPDATE RepInfo
		SET active = 0
		WHERE [name] =  'Dep_ProductStakeLevelGroup'
	END
	ELSE
	BEGIN  
		SELECT 'Dep_ProductStakeLevelGroup not exists !!!'
	END
END

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* --DBTP only

	GameLaunchPerCurrency
	GameLaunchPerSite
	
	LossLimit_GlobalSetting
	MaxPayoutGlobalSetting
	PlayCurrencySetting
*/
IF @@SERVERNAME IN ('DB92\TESTDBTP', 'DBTP10C')
BEGIN
	IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'GameLaunchPerCurrency')
	BEGIN
		UPDATE RepInfo
		SET active = 0
		WHERE [name] =  'GameLaunchPerCurrency'
	END
	ELSE
	BEGIN  
		SELECT 'GameLaunchPerCurrency not exists !!!'
	END

	IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'GameLaunchPerSite')
	BEGIN
		UPDATE RepInfo
		SET active = 0
		WHERE [name] =  'GameLaunchPerSite'
	END
	ELSE
	BEGIN  
		SELECT 'GameLaunchPerSite not exists !!!'
	END
	
	IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'LossLimit_GlobalSetting')
	BEGIN
		UPDATE RepInfo
		SET active = 0
		WHERE [name] =  'LossLimit_GlobalSetting'
	END
	ELSE
	BEGIN  
		SELECT 'LossLimit_GlobalSetting not exists !!!'
	END
		
	IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'MaxPayoutGlobalSetting')
	BEGIN
		UPDATE RepInfo
		SET active = 0
		WHERE [name] =  'MaxPayoutGlobalSetting'
	END
	ELSE
	BEGIN  
		SELECT 'MaxPayoutGlobalSetting not exists !!!'
	END

	IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'PlayCurrencySetting')
	BEGIN
		UPDATE RepInfo
		SET active = 0
		WHERE [name] =  'PlayCurrencySetting'
	END
	ELSE
	BEGIN  
		SELECT 'PlayCurrencySetting not exists !!!'
	END
END
GO