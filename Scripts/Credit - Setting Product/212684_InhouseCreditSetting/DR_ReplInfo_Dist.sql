/*<info serverAlias="DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241107@Johnson	
	Task: In-House
	DB: DBCUST-CustDB
	
	Revisions:
		- 20241107@Johnson: Created [RedmineID: #212684]

	Example:			
*/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustAgent')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustAgent',0,'repupdatetime',0,'custid','DR_Repl_GetCustAgent_Dist','DR_Repl_PutCustAgent_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustAgent exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustMaster')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustMaster',0,'repupdatetime',0,'custid','DR_Repl_GetCustMaster_Dist','DR_Repl_PutCustMaster_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustMaster exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'custSub')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'custSub',0,'repupdatetime',0,'subaccid','DR_Repl_GetcustSub_Dist','DR_Repl_PutcustSub_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'custSub exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustSuper')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustSuper',0,'repupdatetime',0,'custid','DR_Repl_GetCustSuper_Dist','DR_Repl_PutCustSuper_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustSuper exists !!!'
END
GO


/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustDiscount3rd_Agent')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustDiscount3rd_Agent',0,'repupdatetime',0,'CustID|SportType|BetType','DR_Repl_GetCustDiscount3rd_Agent_Dist','DR_Repl_PutCustDiscount3rd_Agent_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustDiscount3rd_Agent exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustDiscount3rd_Member')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustDiscount3rd_Member',0,'repupdatetime',0,'CustID|SportType|BetType','DR_Repl_GetCustDiscount3rd_Member_Dist','DR_Repl_PutCustDiscount3rd_Member_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustDiscount3rd_Member exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustMaxPayoutSetting_Agent')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustMaxPayoutSetting_Agent',0,'repupdatetime',0,'CustID|SportType|BetType','DR_Repl_GetCustMaxPayoutSetting_Agent_Dist','DR_Repl_PutCustMaxPayoutSetting_Agent_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustMaxPayoutSetting_Agent exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustMaxPayoutSetting_Member')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustMaxPayoutSetting_Member',0,'repupdatetime',0,'CustID|SportType|BetType','DR_Repl_GetCustMaxPayoutSetting_Member_Dist','DR_Repl_PutCustMaxPayoutSetting_Member_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustMaxPayoutSetting_Member exists !!!'
END
GO

/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustPTGroupSetting3rd_Member')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustPTGroupSetting3rd_Member',0,'repupdatetime',0,'AgentID|SportType|BetType|IsLive','DR_Repl_GetCustPTGroupSetting3rd_Member_Dist','DR_Repl_PutCustPTGroupSetting3rd_Member_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustPTGroupSetting3rd_Member exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustPTSetting3rd_Agent')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustPTSetting3rd_Agent',0,'repupdatetime',0,'CustID|SportType|BetType|IsLive','DR_Repl_GetCustPTSetting3rd_Agent_Dist','DR_Repl_PutCustPTSetting3rd_Agent_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustPTSetting3rd_Agent exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustPTSetting3rd_Member')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustPTSetting3rd_Member',0,'repupdatetime',0,'CustID|SportType|BetType|IsLive','DR_Repl_GetCustPTSetting3rd_Member_Dist','DR_Repl_PutCustPTSetting3rd_Member_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustPTSetting3rd_Member exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustPTTemplate')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustPTTemplate',0,'repupdatetime',0,'TemplateID','DR_Repl_GetCustPTTemplate_Dist','DR_Repl_PutCustPTTemplate_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustPTTemplate exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustPTTemplateDetail')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustPTTemplateDetail',0,'repupdatetime',0,'TemplateID|GroupID|SubGroupID','DR_Repl_GetCustPTTemplateDetail_Dist','DR_Repl_PutCustPTTemplateDetail_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustPTTemplateDetail exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustQRCode')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustQRCode',0,'repupdatetime',0,'CustID','DR_Repl_GetCustQRCode_Dist','DR_Repl_PutCustQRCode_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustQRCode exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustSettingMode3rd')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustSettingMode3rd',0,'repupdatetime',0,'CustID','DR_Repl_GetCustSettingMode3rd_Dist','DR_Repl_PutCustSettingMode3rd_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustSettingMode3rd exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustStakeLevel_Agent')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustStakeLevel_Agent',0,'repupdatetime',0,'CustID|SportType|BetType','DR_Repl_GetCustStakeLevel_Agent_Dist','DR_Repl_PutCustStakeLevel_Agent_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustStakeLevel_Agent exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustStakeLevel_Member')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustStakeLevel_Member',0,'repupdatetime',0,'CustID|SportType|BetType','DR_Repl_GetCustStakeLevel_Member_Dist','DR_Repl_PutCustStakeLevel_Member_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustStakeLevel_Member exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustSuperProfile')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustSuperProfile',0,'repupdatetime',0,'custid','DR_Repl_GetCustSuperProfile_Dist','DR_Repl_PutCustSuperProfile_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustSuperProfile exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustWinLossLimit_Agent')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustWinLossLimit_Agent',0,'repupdatetime',0,'CustId|SportType|BetType','DR_Repl_GetCustWinLossLimit_Agent_Dist','DR_Repl_PutCustWinLossLimit_Agent_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustWinLossLimit_Agent exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustWinLossLimit_Member')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustWinLossLimit_Member',0,'repupdatetime',0,'CustId|SportType|BetType','DR_Repl_GetCustWinLossLimit_Member_Dist','DR_Repl_PutCustWinLossLimit_Member_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustWinLossLimit_Member exists !!!'
END
GO
/***************************************************************************/


IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'custInfo')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'custInfo',0,'repupdatetime',0,'custid','DR_Repl_GetcustInfo_Dist','DR_Repl_PutcustInfo_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'custInfo exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'Customer')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'Customer',0,'repupdatetime',0,'custid','DR_Repl_GetCustomer_Dist','DR_Repl_PutCustomer_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'Customer exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustProductStatus')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustProductStatus',0,'repupdatetime',0,'CustID','DR_Repl_GetCustProductStatus_Dist','DR_Repl_PutCustProductStatus_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustProductStatus exists !!!'
END
GO
/***************************************************************************/
