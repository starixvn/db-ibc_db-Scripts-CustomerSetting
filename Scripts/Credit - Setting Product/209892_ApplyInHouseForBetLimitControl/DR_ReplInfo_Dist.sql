/*<info serverAlias="DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20240913@Johnson	
	Task: In-House
	DB: DBCUST-CustDB
	
	Revisions:
		- 20240913@Johnson: Created [RedmineID: #209892]

	Example:			
*/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'BetLimitControlCustSetting')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'BetLimitControlCustSetting',0,'repupdatetime',0,'CustID|BetLimitTypeID','DR_Repl_GetBetLimitControlCustSetting_Dist','DR_Repl_PutBetLimitControlCustSetting_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'BetLimitControlCustSetting exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'BetLimitControlDefaultSetting')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'BetLimitControlDefaultSetting',0,'repupdatetime',0,'CustID|BetLimitTypeID','DR_Repl_GetBetLimitControlDefaultSetting_Dist','DR_Repl_PutBetLimitControlDefaultSetting_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'BetLimitControlDefaultSetting exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'BetLimitControlProduct')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'BetLimitControlProduct',0,'repupdatetime',0,'ProductID','DR_Repl_GetBetLimitControlProduct_Dist','DR_Repl_PutBetLimitControlProduct_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'BetLimitControlProduct exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'BetLimitControlType')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'BetLimitControlType',0,'repupdatetime',0,'BetLimitTypeID','DR_Repl_GetBetLimitControlType_Dist','DR_Repl_PutBetLimitControlType_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'BetLimitControlType exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'BetLimitControlTypeDetails')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'BetLimitControlTypeDetails',0,'repupdatetime',0,'ID','DR_Repl_GetBetLimitControlTypeDetails_Dist','DR_Repl_PutBetLimitControlTypeDetails_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'BetLimitControlTypeDetails exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'BetRestriction_Currency')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'BetRestriction_Currency',0,'repupdatetime',0,'ExchangeID|Type|SportType','DR_Repl_GetBetRestriction_Currency_Dist','DR_Repl_PutBetRestriction_Currency_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'BetRestriction_Currency exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'BetRestriction_Customer')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'BetRestriction_Customer',0,'repupdatetime',0,'CustID|SportType','DR_Repl_GetBetRestriction_Customer_Dist','DR_Repl_PutBetRestriction_Customer_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'BetRestriction_Customer exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'BetRestriction_Setting')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'BetRestriction_Setting',0,'repupdatetime',0,'SettingID','DR_Repl_GetBetRestriction_Setting_Dist','DR_Repl_PutBetRestriction_Setting_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'BetRestriction_Setting exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'BetRestriction_Site')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'BetRestriction_Site',0,'repupdatetime',0,'SiteID|SportType','DR_Repl_GetBetRestriction_Site_Dist','DR_Repl_PutBetRestriction_Site_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'BetRestriction_Site exists !!!'
END
GO
/***************************************************************************/
