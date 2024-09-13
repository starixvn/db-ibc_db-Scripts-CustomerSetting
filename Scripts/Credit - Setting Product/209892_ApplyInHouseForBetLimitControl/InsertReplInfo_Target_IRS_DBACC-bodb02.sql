/*<info serverAlias="IRS_DBACC-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20240913@Johnson	
	Task: In-House
	DB: IRS_DBACC-bodb02
	
	Revisions:
		- 20240913@Johnson: Created [RedmineID: #209892]

	Example:			
*/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'BetLimitControlCustSetting')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'BetLimitControlCustSetting',0,'repupdatetime',0,'CustID|BetLimitTypeID','Repl_GetBetLimitControlCustSetting_Dist','Repl_PutBetLimitControlCustSetting',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'BetLimitControlCustSetting exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'BetLimitControlDefaultSetting')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'BetLimitControlDefaultSetting',0,'repupdatetime',0,'CustID|BetLimitTypeID','Repl_GetBetLimitControlDefaultSetting_Dist','Repl_PutBetLimitControlDefaultSetting',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'BetLimitControlDefaultSetting exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'BetLimitControlProduct')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'BetLimitControlProduct',0,'repupdatetime',0,'ProductID','Repl_GetBetLimitControlProduct_Dist','Repl_PutBetLimitControlProduct',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'BetLimitControlProduct exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'BetLimitControlType')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'BetLimitControlType',0,'repupdatetime',0,'BetLimitTypeID','Repl_GetBetLimitControlType_Dist','Repl_PutBetLimitControlType',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'BetLimitControlType exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'BetLimitControlTypeDetails')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'BetLimitControlTypeDetails',0,'repupdatetime',0,'ID','Repl_GetBetLimitControlTypeDetails_Dist','Repl_PutBetLimitControlTypeDetails',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'BetLimitControlTypeDetails exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'BetRestriction_Currency')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'BetRestriction_Currency',0,'repupdatetime',0,'ExchangeID|Type|SportType','Repl_GetBetRestriction_Currency_Dist','Repl_PutBetRestriction_Currency',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'BetRestriction_Currency exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'BetRestriction_Customer')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'BetRestriction_Customer',0,'repupdatetime',0,'CustID|SportType','Repl_GetBetRestriction_Customer_Dist','Repl_PutBetRestriction_Customer',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'BetRestriction_Customer exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'BetRestriction_Setting')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'BetRestriction_Setting',0,'repupdatetime',0,'SettingID','Repl_GetBetRestriction_Setting_Dist','Repl_PutBetRestriction_Setting',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'BetRestriction_Setting exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'BetRestriction_Site')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'BetRestriction_Site',0,'repupdatetime',0,'SiteID|SportType','Repl_GetBetRestriction_Site_Dist','Repl_PutBetRestriction_Site',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'BetRestriction_Site exists !!!'
END
GO
/***************************************************************************/



