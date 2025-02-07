/*<info serverAlias="IRS_DBBAH-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250109@Tacy	
	Task: In-House
	DB: IRS_DBBAH-bodb02
	
	Revisions:
		- 20241220@Tacy: Created [RedmineID: #215807]

	Example:			
*/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'Dep_CustSabaInfo')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 12
		AND [name] =  'Dep_CustSabaInfo'
END
ELSE
BEGIN  
	SELECT 'Dep_CustSabaInfo not exists !!!'
END
GO
/***************************************************************************/



