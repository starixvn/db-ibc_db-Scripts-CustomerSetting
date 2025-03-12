/*<info serverAlias="IRS_DBPRO-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241112@Johnson	
	Task: In-House
	DB: IRS_DBPRO-bodb02
	
	Revisions:
		- 20241112@Johnson: Created [RedmineID: #212684]

	Example:			
*/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'custinfo')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 11
		AND [name] =  'custinfo'
END
ELSE
BEGIN  
	SELECT 'custinfo not exists !!!'
END
GO
/***************************************************************************/



