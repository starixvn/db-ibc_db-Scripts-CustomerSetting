/*<info serverAlias="IRS_DBACC-bodb02,IRS_DBAGE-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241115@Winfred	
	Task: In-House
	DB: IRS_DBACC-bodb02,IRS_DBAGE-bodb02
	
	Revisions:
		- 20241115@Winfred: Created [RedmineID: #185799]

	Example:			
*/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSetting_Agent')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 14,'CustomerClassSetting_Agent',0,'repupdatetime',0,'custid|SportType','Repl_GetCustomerClassSetting_Agent_Dist','Repl_PutCustomerClassSetting_Agent',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassSetting_Agent exists !!!'
END
GO
/***************************************************************************/



