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
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'GameLaunchPerCurrency')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'GameLaunchPerCurrency',0,'repupdatetime',0,'SportType|BetType|Currency','Repl_GetGameLaunchPerCurrency','Repl_PutGameLaunchPerCurrency_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'GameLaunchPerCurrency exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'GameLaunchPerSite')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'GameLaunchPerSite',0,'repupdatetime',0,'SportType|BetType|SiteID','Repl_GetGameLaunchPerSite','Repl_PutGameLaunchPerSite_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'GameLaunchPerSite exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductGlobalSetting')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'ProductGlobalSetting',0,'repupdatetime',0,'Sporttype|Bettype','Repl_GetProductGlobalSetting','Repl_PutProductGlobalSetting_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'ProductGlobalSetting exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductLaunchedSiteCurrency')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'ProductLaunchedSiteCurrency',0,'repupdatetime',0,'SiteID|Currency|SportType|BetType|LaunchedLevel','Repl_GetProductLaunchedSiteCurrency','Repl_PutProductLaunchedSiteCurrency_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'ProductLaunchedSiteCurrency exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductSettingSystemDisplay')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'ProductSettingSystemDisplay',0,'repupdatetime',0,'SystemID|ProductID|SettingType','Repl_GetProductSettingSystemDisplay','Repl_PutProductSettingSystemDisplay_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'ProductSettingSystemDisplay exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductSettingUpdateRestriction')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'ProductSettingUpdateRestriction',0,'repupdatetime',0,'SystemID|ProductID|SettingType|ActorRoleID|TargetRoleID','Repl_GetProductSettingUpdateRestriction','Repl_PutProductSettingUpdateRestriction_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'ProductSettingUpdateRestriction exists !!!'
END
GO
/***************************************************************************/



