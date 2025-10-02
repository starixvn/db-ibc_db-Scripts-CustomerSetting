/*<info serverAlias="DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250916@Dave	
	Task: In-House
	DB: DBCustRepl-ReplCustDB
	
	Revisions:
		- 20250916@Dave: Created [RedmineID: #238689]

	Example:			
*/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerRemark')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'CustomerRemark',0,'repupdatetime',0,'CustID','Repl_GetCustomerRemark','Repl_PutCustomerRemark_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerRemark exists !!!'
END
GO
--select * from RepInfo where active = 1
/***************************************************************************/



