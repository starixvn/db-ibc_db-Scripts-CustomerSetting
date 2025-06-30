/*<info serverAlias="DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250519@Winfred	
	DB: DBCustRepl-ReplCustDB
	Task: Remove Link server of VR Jobs
	
	Revisions:
		- 20250519@Winfred: VR Auto Job - Scale out DBCust - Remove Link server of VR Jobs [RedmineID: #211727]

	Example:			
*/
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'VRMemberBigStake')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'VRMemberBigStake',0,'repupdatetime',0,'CustID|Type','Repl_GetVRMemberBigStake','Repl_PutVRMemberBigStake_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'VRMemberBigStake exists !!!'
END
GO



