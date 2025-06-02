/*<info serverAlias="DBCustRepl-ReplCustDB,IRS_DBWH-bodb02" executers="" isFunction="0" isNested="0"></info>*/
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

IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustVirtualSetting')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 0
		AND [name] =  'CustVirtualSetting'
END
ELSE
BEGIN  
	SELECT 'CustVirtualSetting not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'VRAgentAutoAdjustment')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 0
		AND [name] =  'VRAgentAutoAdjustment'
END
ELSE
BEGIN  
	SELECT 'VRAgentAutoAdjustment not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'VRCustAutoAdjustment')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 0
		AND [name] =  'VRCustAutoAdjustment'
END
ELSE
BEGIN  
	SELECT 'VRCustAutoAdjustment not exists !!!'
END
GO
/***************************************************************************/