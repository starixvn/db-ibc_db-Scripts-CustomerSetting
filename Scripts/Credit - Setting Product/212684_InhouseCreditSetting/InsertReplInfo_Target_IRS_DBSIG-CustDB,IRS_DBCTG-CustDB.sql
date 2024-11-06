/*<info serverAlias="IRS_DBSIG-CustDB,IRS_DBCTG-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241107@Johnson	
	Task: In-House
	DB: IRS_DBSIG-CustDB,IRS_DBCTG-CustDB
	
	Revisions:
		- 20241107@Johnson: Created [RedmineID: #212684]

	Example:			
*/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'custInfo')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 11,'custInfo',0,'repupdatetime',0,'custid','Repl_GetcustInfo_Dist','Repl_PutcustInfo',1000,10,60000,0
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
	SELECT 11,'Customer',0,'repupdatetime',0,'custid','Repl_GetCustomer_Dist','Repl_PutCustomer',1000,10,60000,0
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
	SELECT 12,'CustProductStatus',0,'repupdatetime',0,'CustID','Repl_GetCustProductStatus_Dist','Repl_PutCustProductStatus',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustProductStatus exists !!!'
END
GO
/***************************************************************************/



