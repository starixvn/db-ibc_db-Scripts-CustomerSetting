/*<info serverAlias="DBCustRepl-ReplCustDB,IRS_DBWH-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250519@Winfred	
	DB: DBCustRepl-ReplCustDB,IRS_DBWH-bodb02
	Task: Remove Link server of VR Jobs
	
	Revisions:
		- 20250519@Winfred: VR Auto Job - Scale out DBCust - Remove Link server of VR Jobs [RedmineID: #211727]

	Example:			
*/
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'VRMemberBigStake')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [name] =  'VRMemberBigStake'
END
ELSE
BEGIN  
	SELECT 'VRMemberBigStake not exists !!!'
END
GO
/***************************************************************************/

