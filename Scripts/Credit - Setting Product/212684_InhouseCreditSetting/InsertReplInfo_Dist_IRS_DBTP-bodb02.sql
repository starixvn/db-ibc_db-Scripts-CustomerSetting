/*<info serverAlias="IRS_DBTP-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241107@Johnson	
	Task: In-House
	DB: IRS_DBTP-bodb02
	
	Revisions:
		- 20241107@Johnson: Created [RedmineID: #]

	Example:			
*/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustAgent')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 11,'CustAgent',0,'repupdatetime',0,'custid','Repl_GetCustAgent','Repl_PutCustAgent_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustAgent exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustMaster')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 11,'CustMaster',0,'repupdatetime',0,'custid','Repl_GetCustMaster','Repl_PutCustMaster_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustMaster exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustMaxPayoutSetting_Agent')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 12,'CustMaxPayoutSetting_Agent',0,'repupdatetime',0,'CustID|SportType|BetType','Repl_GetCustMaxPayoutSetting_Agent','Repl_PutCustMaxPayoutSetting_Agent_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustMaxPayoutSetting_Agent exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustMaxPayoutSetting_Member')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 12,'CustMaxPayoutSetting_Member',0,'repupdatetime',0,'CustID|SportType|BetType','Repl_GetCustMaxPayoutSetting_Member','Repl_PutCustMaxPayoutSetting_Member_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustMaxPayoutSetting_Member exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'custSub')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 11,'custSub',0,'repupdatetime',0,'subaccid','Repl_GetcustSub','Repl_PutcustSub_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'custSub exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustSuper')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 11,'CustSuper',0,'repupdatetime',0,'custid','Repl_GetCustSuper','Repl_PutCustSuper_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustSuper exists !!!'
END
GO
/***************************************************************************/

IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustDiscount3rd_Agent')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 12,'CustDiscount3rd_Agent',0,'repupdatetime',0,'CustID|SportType|BetType','Repl_GetCustDiscount3rd_Agent','Repl_PutCustDiscount3rd_Agent_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustDiscount3rd_Agent exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustDiscount3rd_Member')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 12,'CustDiscount3rd_Member',0,'repupdatetime',0,'CustID|SportType|BetType','Repl_GetCustDiscount3rd_Member','Repl_PutCustDiscount3rd_Member_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustDiscount3rd_Member exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustPTGroupSetting3rd_Member')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 12,'CustPTGroupSetting3rd_Member',0,'repupdatetime',0,'AgentID|SportType|BetType|IsLive','Repl_GetCustPTGroupSetting3rd_Member','Repl_PutCustPTGroupSetting3rd_Member_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustPTGroupSetting3rd_Member exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustPTSetting3rd_Agent')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 12,'CustPTSetting3rd_Agent',0,'repupdatetime',0,'CustID|SportType|BetType|IsLive','Repl_GetCustPTSetting3rd_Agent','Repl_PutCustPTSetting3rd_Agent_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustPTSetting3rd_Agent exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustPTSetting3rd_Member')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 12,'CustPTSetting3rd_Member',0,'repupdatetime',0,'CustID|SportType|BetType|IsLive','Repl_GetCustPTSetting3rd_Member','Repl_PutCustPTSetting3rd_Member_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustPTSetting3rd_Member exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustPTTemplate')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 12,'CustPTTemplate',0,'repupdatetime',0,'TemplateID','Repl_GetCustPTTemplate','Repl_PutCustPTTemplate_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustPTTemplate exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustPTTemplateDetail')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 12,'CustPTTemplateDetail',0,'repupdatetime',0,'TemplateID|GroupID|SubGroupID','Repl_GetCustPTTemplateDetail','Repl_PutCustPTTemplateDetail_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustPTTemplateDetail exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustQRCode')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 11,'CustQRCode',0,'repupdatetime',0,'CustID','Repl_GetCustQRCode','Repl_PutCustQRCode_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustQRCode exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustSettingMode3rd')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 12,'CustSettingMode3rd',0,'repupdatetime',0,'CustID','Repl_GetCustSettingMode3rd','Repl_PutCustSettingMode3rd_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustSettingMode3rd exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustStakeLevel_Agent')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 12,'CustStakeLevel_Agent',0,'repupdatetime',0,'CustID|SportType|BetType','Repl_GetCustStakeLevel_Agent','Repl_PutCustStakeLevel_Agent_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustStakeLevel_Agent exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustStakeLevel_Member')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 12,'CustStakeLevel_Member',0,'repupdatetime',0,'CustID|SportType|BetType','Repl_GetCustStakeLevel_Member','Repl_PutCustStakeLevel_Member_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustStakeLevel_Member exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustSuperProfile')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 12,'CustSuperProfile',0,'repupdatetime',0,'custid','Repl_GetCustSuperProfile','Repl_PutCustSuperProfile_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustSuperProfile exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustWinLossLimit_Agent')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 12,'CustWinLossLimit_Agent',0,'repupdatetime',0,'CustId|SportType|BetType','Repl_GetCustWinLossLimit_Agent','Repl_PutCustWinLossLimit_Agent_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustWinLossLimit_Agent exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustWinLossLimit_Member')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 12,'CustWinLossLimit_Member',0,'repupdatetime',0,'CustId|SportType|BetType','Repl_GetCustWinLossLimit_Member','Repl_PutCustWinLossLimit_Member_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustWinLossLimit_Member exists !!!'
END
GO
/***************************************************************************/


IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'custInfo')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 11,'custInfo',0,'repupdatetime',0,'custid','Repl_GetcustInfo','Repl_PutcustInfo_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'custInfo exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'Customer')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 11,'Customer',0,'repupdatetime',0,'custid','Repl_GetCustomer','Repl_PutCustomer_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'Customer exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustProductStatus')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 12,'CustProductStatus',0,'repupdatetime',0,'CustID','Repl_GetCustProductStatus','Repl_PutCustProductStatus_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustProductStatus exists !!!'
END
GO
/***************************************************************************/




