/*<info serverAlias="DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241220@Tacy	
	Task: In-House - DR
	DB: DBCUST-CustDB
	
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



