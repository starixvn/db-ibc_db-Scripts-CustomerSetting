/*<info serverAlias="IRS_DBACC-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241225@Virgil	
	Task: Customer Setting - Apply In-house replication for profile setting tables
	DB: IRS_DBACC-bodb02
	
	Revisions:
		- 20241225@Virgil: Created [RedmineID: #214117]

	Table Related:
		CategoryConfig
		GameGroup
		ProductBetSetting
		StakeLevel
		StakeLevelGroupDetail
		PlayCurrencySetting
*/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CategoryConfig')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'CategoryConfig',0,'repupdatetime',0,'CategoryID','Repl_GetCategoryConfig_Dist','Repl_PutCategoryConfig',1000,10,60000,0
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
	SELECT 13,'GameGroup',0,'repupdatetime',0,'GameGroupID','Repl_GetGameGroup_Dist','Repl_PutGameGroup',1000,10,60000,0
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
	SELECT 13,'ProductBetSetting',0,'repupdatetime',0,'Sporttype|Bettype|Currency','Repl_GetProductBetSetting_Dist','Repl_PutProductBetSetting',1000,10,60000,0
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
	SELECT 13,'StakeLevel',0,'repupdatetime',0,'StakeLevelID','Repl_GetStakeLevel_Dist','Repl_PutStakeLevel',1000,10,60000,0
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
	SELECT 13,'StakeLevelGroupDetail',0,'repupdatetime',0,'StakeLevelID|GameTypeID','Repl_GetStakeLevelGroupDetail_Dist','Repl_PutStakeLevelGroupDetail',1000,10,60000,0
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
	SELECT 13,'PlayCurrencySetting',0,'repupdatetime',0,'ID','Repl_GetPlayCurrencySetting_Dist','Repl_PutPlayCurrencySetting',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'PlayCurrencySetting exists !!!'
END
GO
/***************************************************************************/


