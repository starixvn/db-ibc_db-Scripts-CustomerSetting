/*<info serverAlias="IRS_DBTP-bodb02,DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241114@Winfred	
	Task: In-House
	DB: IRS_DBTP-bodb02,DBCustRepl-ReplCustDB
	
	Revisions:
		- 20241114@Winfred: Created [RedmineID: #]

	Example:			
*/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSetting_Agent')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'CustomerClassSetting_Agent',0,'repupdatetime',0,'custid|SportType','Repl_GetCustomerClassSetting_Agent','Repl_PutCustomerClassSetting_Agent_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassSetting_Agent exists !!!'
END
GO
/***************************************************************************/



