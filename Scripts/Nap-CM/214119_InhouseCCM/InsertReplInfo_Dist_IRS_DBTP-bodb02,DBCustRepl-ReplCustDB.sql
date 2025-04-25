/*<info serverAlias="IRS_DBTP-bodb02,DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250211@Winfred	
	DB: IRS_DBTP-bodb02,DBCustRepl-ReplCustDB
	Task: Apply Inhouse replication for Customer Class
	
	Revisions:
		- 20250121@Winfred: [NAP CM] Scale Out DBCUST - Apply Inhouse replication for Customer Class[Redmine: #20119]

	Example:			
*/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassPolicyManagement')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassPolicyManagement',0,'repupdatetime',0,'PolicyID','Repl_GetCustomerClassPolicyManagement','Repl_PutCustomerClassPolicyManagement_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassPolicyManagement exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassPolicyManagement_UAT')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassPolicyManagement_UAT',0,'repupdatetime',0,'PolicyID','Repl_GetCustomerClassPolicyManagement_UAT','Repl_PutCustomerClassPolicyManagement_UAT_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassPolicyManagement_UAT exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassPolicyRule')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassPolicyRule',0,'repupdatetime',0,'PolicyID|RuleID','Repl_GetCustomerClassPolicyRule','Repl_PutCustomerClassPolicyRule_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassPolicyRule exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassPolicyRule_UAT')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassPolicyRule_UAT',0,'repupdatetime',0,'PolicyID|RuleID','Repl_GetCustomerClassPolicyRule_UAT','Repl_PutCustomerClassPolicyRule_UAT_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassPolicyRule_UAT exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassRule')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassRule',0,'repupdatetime',0,'RuleID','Repl_GetCustomerClassRule','Repl_PutCustomerClassRule_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassRule exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassRule_UAT')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassRule_UAT',0,'repupdatetime',0,'RuleID','Repl_GetCustomerClassRule_UAT','Repl_PutCustomerClassRule_UAT_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassRule_UAT exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassRuleLeagueGroup')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassRuleLeagueGroup',0,'repupdatetime',0,'RuleID|LeagueGroupID','Repl_GetCustomerClassRuleLeagueGroup','Repl_PutCustomerClassRuleLeagueGroup_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassRuleLeagueGroup exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassRuleLeagueGroup_UAT')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassRuleLeagueGroup_UAT',0,'repupdatetime',0,'RuleID|LeagueGroupID','Repl_GetCustomerClassRuleLeagueGroup_UAT','Repl_PutCustomerClassRuleLeagueGroup_UAT_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassRuleLeagueGroup_UAT exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSetting')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassSetting',0,'repupdatetime',0,'custid|SportType','Repl_GetCustomerClassSetting','Repl_PutCustomerClassSetting_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassSetting exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSiteManagement')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassSiteManagement',0,'repupdatetime',0,'PolicyID|Site|Currency|Platform','Repl_GetCustomerClassSiteManagement','Repl_PutCustomerClassSiteManagement_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassSiteManagement exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSiteManagement_UAT')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassSiteManagement_UAT',0,'repupdatetime',0,'PolicyID|Site|Currency|Platform','Repl_GetCustomerClassSiteManagement_UAT','Repl_PutCustomerClassSiteManagement_UAT_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassSiteManagement_UAT exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSpread')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassSpread',0,'repupdatetime',0,'PolicyID','Repl_GetCustomerClassSpread','Repl_PutCustomerClassSpread_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassSpread exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSpread_UAT')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassSpread_UAT',0,'repupdatetime',0,'PolicyID','Repl_GetCustomerClassSpread_UAT','Repl_PutCustomerClassSpread_UAT_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassSpread_UAT exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSpreadClass')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassSpreadClass',0,'repupdatetime',0,'PolicyID|CustomerClass','Repl_GetCustomerClassSpreadClass','Repl_PutCustomerClassSpreadClass_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassSpreadClass exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSpreadClass_UAT')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassSpreadClass_UAT',0,'repupdatetime',0,'PolicyID|CustomerClass','Repl_GetCustomerClassSpreadClass_UAT','Repl_PutCustomerClassSpreadClass_UAT_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassSpreadClass_UAT exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSpreadDetail')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassSpreadDetail',0,'repupdatetime',0,'PolicyID|SiteID|Currency|Platform|SportType','Repl_GetCustomerClassSpreadDetail','Repl_PutCustomerClassSpreadDetail_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassSpreadDetail exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSpreadDetail_UAT')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassSpreadDetail_UAT',0,'repupdatetime',0,'PolicyID|SiteID|Currency|Platform|SportType','Repl_GetCustomerClassSpreadDetail_UAT','Repl_PutCustomerClassSpreadDetail_UAT_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassSpreadDetail_UAT exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'VRMemberBigStake')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'VRMemberBigStake',0,'repupdatetime',0,'CustID|Type','Repl_GetVRMemberBigStake','Repl_PutVRMemberBigStake_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'VRMemberBigStake exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSMQueue')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassSMQueue',0,'repupdatetime',0,'ID','Repl_GetCustomerClassSMQueue','Repl_PutCustomerClassSMQueue_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassSMQueue exists !!!'
END
GO
/***************************************************************************/



