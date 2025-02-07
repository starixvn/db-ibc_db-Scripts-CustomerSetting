/*<info serverAlias="DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241220@Tacy	
	Task: In-House - DR
	DB: DBCUST-CustDB
	
	Revisions:
		- 20241220@Tacy: Created [RedmineID: #215807]

	Example:			
*/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'Dep_CustSabaInfo')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 12,'Dep_CustSabaInfo',0,'repupdatetime',0,'CustID','DR_Repl_GetDep_CustSabaInfo_Dist','DR_Repl_PutDep_CustSabaInfo_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'Dep_CustSabaInfo exists !!!'
END
GO
/***************************************************************************/
