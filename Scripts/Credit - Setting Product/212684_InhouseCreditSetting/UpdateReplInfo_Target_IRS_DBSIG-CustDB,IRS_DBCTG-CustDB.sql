/*<info serverAlias="IRS_DBSIG-CustDB,IRS_DBCTG-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241107@Johnson	
	Task: In-House
	DB: IRS_DBSIG-CustDB,IRS_DBCTG-CustDB
	
	Revisions:
		- 20241107@Johnson: Created [RedmineID: #212684]

	Example:			
*/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'custInfo')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 11
		AND [name] =  'custInfo'
END
ELSE
BEGIN  
	SELECT 'custInfo not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'Customer')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 11
		AND [name] =  'Customer'
END
ELSE
BEGIN  
	SELECT 'Customer not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustProductStatus')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 12
		AND [name] =  'CustProductStatus'
END
ELSE
BEGIN  
	SELECT 'CustProductStatus not exists !!!'
END
GO
/***************************************************************************/



