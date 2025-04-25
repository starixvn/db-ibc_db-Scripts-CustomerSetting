/*<info serverAlias="IRS_DBACC-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250211@Winfred	
	DB: IRS_DBACC-bodb02
	Task: Apply Inhouse replication for Customer Class
	
	Revisions:
		- 20250121@Winfred: [NAP CM] Scale Out DBCUST - Apply Inhouse replication for Customer Class[Redmine: #20119]

	Example:			
*/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassPolicyManagement')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassPolicyManagement',0,'repupdatetime',0,'PolicyID','Repl_GetCustomerClassPolicyManagement_Dist','Repl_PutCustomerClassPolicyManagement',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassPolicyManagement exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassPolicyRule')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassPolicyRule',0,'repupdatetime',0,'PolicyID|RuleID','Repl_GetCustomerClassPolicyRule_Dist','Repl_PutCustomerClassPolicyRule',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassPolicyRule exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassRule')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassRule',0,'repupdatetime',0,'RuleID','Repl_GetCustomerClassRule_Dist','Repl_PutCustomerClassRule',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassRule exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassRuleLeagueGroup')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassRuleLeagueGroup',0,'repupdatetime',0,'RuleID|LeagueGroupID','Repl_GetCustomerClassRuleLeagueGroup_Dist','Repl_PutCustomerClassRuleLeagueGroup',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassRuleLeagueGroup exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSetting')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassSetting',0,'repupdatetime',0,'custid|SportType','Repl_GetCustomerClassSetting_Dist','Repl_PutCustomerClassSetting',1000,10,60000,0
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
	SELECT 0,'CustomerClassSiteManagement',0,'repupdatetime',0,'PolicyID|Site|Currency|Platform','Repl_GetCustomerClassSiteManagement_Dist','Repl_PutCustomerClassSiteManagement',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassSiteManagement exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSpread')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassSpread',0,'repupdatetime',0,'PolicyID','Repl_GetCustomerClassSpread_Dist','Repl_PutCustomerClassSpread',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassSpread exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSpreadClass')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassSpreadClass',0,'repupdatetime',0,'PolicyID|CustomerClass','Repl_GetCustomerClassSpreadClass_Dist','Repl_PutCustomerClassSpreadClass',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassSpreadClass exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSpreadDetail')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassSpreadDetail',0,'repupdatetime',0,'PolicyID|SiteID|Currency|Platform|SportType','Repl_GetCustomerClassSpreadDetail_Dist','Repl_PutCustomerClassSpreadDetail',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassSpreadDetail exists !!!'
END
GO

