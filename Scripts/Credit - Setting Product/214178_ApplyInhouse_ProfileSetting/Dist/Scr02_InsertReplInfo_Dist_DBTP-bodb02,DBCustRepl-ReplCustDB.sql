/*<info serverAlias="IRS_DBTP-bodb02,DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241225@Virgil	
	Task: Customer Setting - Apply In-house replication for profile setting tables
	DB: IRS_DBTP-bodb02,DBCustRepl-ReplCustDB
	
	Revisions:
		- 20241225@Virgil: Created [RedmineID: #214117]

	Table Related: 
		ProductSiteConfig
		ProductProfileSiteCurrency
		ProductProfileSiteCurrency_UAT
		ProductSettingProfile
		ProductSettingProfile_UAT
		ProductStatusProfile
		ProductStatusSiteCurrency
		SportNonOfferedSiteCurrency	
		CategoryConfig
		GameGroup
		ProductBetSetting
		StakeLevel
		StakeLevelGroupDetail	
		PlayCurrencySetting
*/

IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductSiteConfig')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'ProductSiteConfig',0,'repupdatetime',0,'SiteID|ProductID','Repl_GetProductSiteConfig','Repl_PutProductSiteConfig_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'ProductSiteConfig exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductProfileSiteCurrency')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'ProductProfileSiteCurrency',0,'repupdatetime',0,'SiteID|Currency|ProductSettingID','Repl_GetProductProfileSiteCurrency','Repl_PutProductProfileSiteCurrency_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'ProductProfileSiteCurrency exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductProfileSiteCurrency_UAT')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'ProductProfileSiteCurrency_UAT',0,'repupdatetime',0,'SiteID|Currency|ProductSettingID','Repl_GetProductProfileSiteCurrency_UAT','Repl_PutProductProfileSiteCurrency_UAT_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'ProductProfileSiteCurrency_UAT exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductSettingProfile')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'ProductSettingProfile',0,'repupdatetime',0,'ProductSettingID','Repl_GetProductSettingProfile','Repl_PutProductSettingProfile_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'ProductSettingProfile exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductSettingProfile_UAT')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'ProductSettingProfile_UAT',0,'repupdatetime',0,'ProductSettingID','Repl_GetProductSettingProfile_UAT','Repl_PutProductSettingProfile_UAT_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'ProductSettingProfile_UAT exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductStatusProfile')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'ProductStatusProfile',0,'repupdatetime',0,'Sporttype|Bettype','Repl_GetProductStatusProfile','Repl_PutProductStatusProfile_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'ProductStatusProfile exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductStatusSiteCurrency')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'ProductStatusSiteCurrency',0,'repupdatetime',0,'SportType|BetType|Currency|SiteID','Repl_GetProductStatusSiteCurrency','Repl_PutProductStatusSiteCurrency_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'ProductStatusSiteCurrency exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'SportNonOfferedSiteCurrency')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'SportNonOfferedSiteCurrency',0,'repupdatetime',0,'SportType|BetType|Currency|SiteID','Repl_GetSportNonOfferedSiteCurrency','Repl_PutSportNonOfferedSiteCurrency_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'SportNonOfferedSiteCurrency exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CategoryConfig')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'CategoryConfig',0,'repupdatetime',0,'CategoryID','Repl_GetCategoryConfig','Repl_PutCategoryConfig_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CategoryConfig exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'GameGroup')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'GameGroup',0,'repupdatetime',0,'GameGroupID','Repl_GetGameGroup','Repl_PutGameGroup_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'GameGroup exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductBetSetting')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'ProductBetSetting',0,'repupdatetime',0,'Sporttype|Bettype|Currency','Repl_GetProductBetSetting','Repl_PutProductBetSetting_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'ProductBetSetting exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'StakeLevel')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'StakeLevel',0,'repupdatetime',0,'StakeLevelID','Repl_GetStakeLevel','Repl_PutStakeLevel_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'StakeLevel exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'StakeLevelGroupDetail')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'StakeLevelGroupDetail',0,'repupdatetime',0,'StakeLevelID|GameTypeID','Repl_GetStakeLevelGroupDetail','Repl_PutStakeLevelGroupDetail_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'StakeLevelGroupDetail exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'PlayCurrencySetting')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'PlayCurrencySetting',0,'repupdatetime',0,'StakeLevelID|GameTypeID','Repl_GetPlayCurrencySetting','Repl_PutPlayCurrencySetting_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'PlayCurrencySetting exists !!!'
END
GO
/***************************************************************************/