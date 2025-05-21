/*<info serverAlias="DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250122@Winfred	
	DB: DBCUST-CustDB
	Task: Apply Inhouse replication for Customer Class
	
	Revisions:
		- 20250121@Winfred: [NAP CM] Scale Out DBCUST - Apply Inhouse replication for Customer Class[Redmine: #214119]

	Example:			
*/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustomerClassPolicyManagement')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'CustomerClassPolicyManagement',0,'repupdatetime',0,'PolicyID','DR_Repl_GetCustomerClassPolicyManagement_Dist','DR_Repl_PutCustomerClassPolicyManagement_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustomerClassPolicyManagement exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustomerClassPolicyManagement_UAT')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'CustomerClassPolicyManagement_UAT',0,'repupdatetime',0,'PolicyID','DR_Repl_GetCustomerClassPolicyManagement_UAT_Dist','DR_Repl_PutCustomerClassPolicyManagement_UAT_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustomerClassPolicyManagement_UAT exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustomerClassPolicyRule')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'CustomerClassPolicyRule',0,'repupdatetime',0,'PolicyID|RuleID','DR_Repl_GetCustomerClassPolicyRule_Dist','DR_Repl_PutCustomerClassPolicyRule_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustomerClassPolicyRule exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustomerClassPolicyRule_UAT')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'CustomerClassPolicyRule_UAT',0,'repupdatetime',0,'PolicyID|RuleID','DR_Repl_GetCustomerClassPolicyRule_UAT_Dist','DR_Repl_PutCustomerClassPolicyRule_UAT_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustomerClassPolicyRule_UAT exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustomerClassRule')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'CustomerClassRule',0,'repupdatetime',0,'RuleID','DR_Repl_GetCustomerClassRule_Dist','DR_Repl_PutCustomerClassRule_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustomerClassRule exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustomerClassRule_UAT')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'CustomerClassRule_UAT',0,'repupdatetime',0,'RuleID','DR_Repl_GetCustomerClassRule_UAT_Dist','DR_Repl_PutCustomerClassRule_UAT_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustomerClassRule_UAT exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustomerClassRuleLeagueGroup')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'CustomerClassRuleLeagueGroup',0,'repupdatetime',0,'RuleID|LeagueGroupID','DR_Repl_GetCustomerClassRuleLeagueGroup_Dist','DR_Repl_PutCustomerClassRuleLeagueGroup_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustomerClassRuleLeagueGroup exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustomerClassRuleLeagueGroup_UAT')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'CustomerClassRuleLeagueGroup_UAT',0,'repupdatetime',0,'RuleID|LeagueGroupID','DR_Repl_GetCustomerClassRuleLeagueGroup_UAT_Dist','DR_Repl_PutCustomerClassRuleLeagueGroup_UAT_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustomerClassRuleLeagueGroup_UAT exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustomerClassSetting')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'CustomerClassSetting',0,'repupdatetime',0,'custid|SportType','DR_Repl_GetCustomerClassSetting_Dist','DR_Repl_PutCustomerClassSetting_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustomerClassSetting exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustomerClassSiteManagement')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'CustomerClassSiteManagement',0,'repupdatetime',0,'PolicyID|Site|Currency|Platform','DR_Repl_GetCustomerClassSiteManagement_Dist','DR_Repl_PutCustomerClassSiteManagement_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustomerClassSiteManagement exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustomerClassSiteManagement_UAT')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'CustomerClassSiteManagement_UAT',0,'repupdatetime',0,'PolicyID|Site|Currency|Platform','DR_Repl_GetCustomerClassSiteManagement_UAT_Dist','DR_Repl_PutCustomerClassSiteManagement_UAT_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustomerClassSiteManagement_UAT exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustomerClassSpread')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'CustomerClassSpread',0,'repupdatetime',0,'PolicyID','DR_Repl_GetCustomerClassSpread_Dist','DR_Repl_PutCustomerClassSpread_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustomerClassSpread exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustomerClassSpread_UAT')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'CustomerClassSpread_UAT',0,'repupdatetime',0,'PolicyID','DR_Repl_GetCustomerClassSpread_UAT_Dist','DR_Repl_PutCustomerClassSpread_UAT_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustomerClassSpread_UAT exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustomerClassSpreadClass')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'CustomerClassSpreadClass',0,'repupdatetime',0,'PolicyID|CustomerClass','DR_Repl_GetCustomerClassSpreadClass_Dist','DR_Repl_PutCustomerClassSpreadClass_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustomerClassSpreadClass exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustomerClassSpreadClass_UAT')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'CustomerClassSpreadClass_UAT',0,'repupdatetime',0,'PolicyID|CustomerClass','DR_Repl_GetCustomerClassSpreadClass_UAT_Dist','DR_Repl_PutCustomerClassSpreadClass_UAT_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustomerClassSpreadClass_UAT exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'VRMemberBigStake')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'VRMemberBigStake',0,'repupdatetime',0,'CustID|Type','DR_Repl_GetVRMemberBigStake_Dist','DR_Repl_PutVRMemberBigStake_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'VRMemberBigStake exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustomerClassSpreadDetail')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'CustomerClassSpreadDetail',0,'repupdatetime',0,'PolicyID|SiteID|Currency|Platform|SportType','DR_Repl_GetCustomerClassSpreadDetail_Dist','DR_Repl_PutCustomerClassSpreadDetail_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustomerClassSpreadDetail exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustomerClassSMQueue')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'CustomerClassSMQueue',0,'repupdatetime',0,'ID','DR_Repl_GetCustomerClassSMQueue_Dist','DR_Repl_PutCustomerClassSMQueue_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustomerClassSMQueue exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustomerClassSpreadDetail_UAT')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'CustomerClassSpreadDetail_UAT',0,'repupdatetime',0,'PolicyID|SiteID|Currency|Platform|SportType','DR_Repl_GetCustomerClassSpreadDetail_UAT_Dist','DR_Repl_PutCustomerClassSpreadDetail_UAT_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustomerClassSpreadDetail_UAT exists !!!'
END
GO
/***************************************************************************/
