/*<info serverAlias="IRS_DBTP-bodb02,DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241114@Winfred	
	Task: In-House
	DB: IRS_DBTP-bodb02,DBCustRepl-ReplCustDB
	
	Revisions:
		- 20241114@Winfred: Created [RedmineID: #]

	Example:			
*/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSetting_Agent')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 14
		AND [name] =  'CustomerClassSetting_Agent'
END
ELSE
BEGIN  
	SELECT 'CustomerClassSetting_Agent not exists !!!'
END
GO
/***************************************************************************/



