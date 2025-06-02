/*<info serverAlias="DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250515@Virgil	
	Task: VR Auto Job - Scale out DBCust - Remove Link server of VR Jobs [RedmineID: #211727]
	DB: DBWH-bodb02
	
	Revisions:
		- 20250516@Virgil: Created [RedmineID: #211727]

	Table Related:
		CustVirtualSetting
		VRAgentAutoAdjustment
		VRCustAutoAdjustment
*/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustVirtualSetting' AND [group] = 0)
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustVirtualSetting',0,'repupdatetime',0,'custid|seqNo','Repl_GetCustVirtualSetting','Repl_PutCustVirtualSetting_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustVirtualSetting exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'VRAgentAutoAdjustment' AND [group] = 0)
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'VRAgentAutoAdjustment',0,'repupdatetime',0,'AgentID|Type','Repl_GetVRAgentAutoAdjustment','Repl_PutVRAgentAutoAdjustment_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'VRAgentAutoAdjustment exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'VRCustAutoAdjustment' AND [group] = 0)
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'VRCustAutoAdjustment',0,'repupdatetime',0,'SportType|CustID','Repl_GetVRCustAutoAdjustment','Repl_PutVRCustAutoAdjustment_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'VRCustAutoAdjustment exists !!!'
END
GO
/***************************************************************************/
