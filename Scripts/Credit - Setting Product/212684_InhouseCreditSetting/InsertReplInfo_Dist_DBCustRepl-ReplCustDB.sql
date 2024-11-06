/*<info serverAlias="DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241107@Johnson	
	Task: In-House
	DB: DBCustRepl-ReplCustDB
	
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




