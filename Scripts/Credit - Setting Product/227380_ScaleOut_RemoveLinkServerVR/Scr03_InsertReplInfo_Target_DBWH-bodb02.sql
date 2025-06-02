/*<info serverAlias="IRS_DBWH-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250515@Virgil	
	Task: VR Auto Job - Scale out DBCust - Remove Link server of VR Jobs [RedmineID: #211727]
	DB: DBWH-bodb02
	
	Revisions:
		- 20250515@Virgil: Created [RedmineID: #211727]

	Table Related:
		CustVirtualSetting
		VRAgentAutoAdjustment
		VRCustAutoAdjustment
*/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustVirtualSetting')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustVirtualSetting',0,'repupdatetime',0,'custid|seqNo','Repl_GetCustVirtualSetting_Dist','Repl_PutCustVirtualSetting',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustVirtualSetting exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'VRAgentAutoAdjustment')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'VRAgentAutoAdjustment',0,'repupdatetime',0,'AgentID|Type','Repl_GetVRAgentAutoAdjustment_Dist','Repl_PutVRAgentAutoAdjustment',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'VRAgentAutoAdjustment exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'VRCustAutoAdjustment')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'VRCustAutoAdjustment',0,'repupdatetime',0,'SportType|CustID','Repl_GetVRCustAutoAdjustment_Dist','Repl_PutVRCustAutoAdjustment',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'VRCustAutoAdjustment exists !!!'
END
GO
/***************************************************************************/