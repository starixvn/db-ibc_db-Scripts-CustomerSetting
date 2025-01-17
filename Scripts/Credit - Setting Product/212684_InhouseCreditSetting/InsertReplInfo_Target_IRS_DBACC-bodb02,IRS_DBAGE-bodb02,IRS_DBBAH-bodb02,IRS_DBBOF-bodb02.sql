/*<info serverAlias="IRS_DBACC-bodb02,IRS_DBAGE-bodb02,IRS_DBBAH-bodb02,IRS_DBBOF-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250117@Johnson	
	Task: In-House
	DB: IRS_DBACC-bodb02,IRS_DBAGE-bodb02,IRS_DBBAH-bodb02,IRS_DBBOF-bodb02
	
	Revisions:
		- 20250117@Johnson: Created [RedmineID: #212684]

	Example:			
*/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustAgent')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 11,'CustAgent',0,'repupdatetime',0,'custid','Repl_GetCustAgent_Dist','Repl_PutCustAgent',1000,10,60000,0
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
	SELECT 11,'CustMaster',0,'repupdatetime',0,'custid','Repl_GetCustMaster_Dist','Repl_PutCustMaster',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustMaster exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'custSub')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 11,'custSub',0,'repupdatetime',0,'subaccid','Repl_GetcustSub_Dist','Repl_PutcustSub',1000,10,60000,0
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
	SELECT 11,'CustSuper',0,'repupdatetime',0,'custid','Repl_GetCustSuper_Dist','Repl_PutCustSuper',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustSuper exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustProductStatus')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 12,'CustProductStatus',0,'repupdatetime',0,'CustID','Repl_GetCustProductStatus_Dist','Repl_PutCustProductStatus',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustProductStatus exists !!!'
END
GO
/***************************************************************************/



