/*<info serverAlias="IRS_DBBAH-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250109@Tacy	
	Task: In-House
	DB: IRS_DBBAH-bodb02
	
	Revisions:
		- 20241220@Tacy: Created [RedmineID: #215807]

	Example:			
*/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'Dep_CustSabaInfo')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 12,'Dep_CustSabaInfo',0,'repupdatetime',0,'CustID','Repl_GetDep_CustSabaInfo_Dist','Repl_PutDep_CustSabaInfo',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'Dep_CustSabaInfo exists !!!'
END
GO
/***************************************************************************/



