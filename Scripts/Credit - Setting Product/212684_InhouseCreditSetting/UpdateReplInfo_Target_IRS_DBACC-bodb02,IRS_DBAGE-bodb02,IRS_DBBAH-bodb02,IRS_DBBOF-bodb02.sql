/*<info serverAlias="IRS_DBACC-bodb02,IRS_DBAGE-bodb02,IRS_DBBAH-bodb02,IRS_DBBOF-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250117@Johnson	
	Task: In-House
	DB: IRS_DBACC-bodb02,IRS_DBAGE-bodb02,IRS_DBBAH-bodb02,IRS_DBBOF-bodb02
	
	Revisions:
		- 20250117@Johnson: Created [RedmineID: #212684]

	Example:			
*/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustAgent')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 11
		AND [name] =  'CustAgent'
END
ELSE
BEGIN  
	SELECT 'CustAgent not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustMaster')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 11
		AND [name] =  'CustMaster'
END
ELSE
BEGIN  
	SELECT 'CustMaster not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'custSub')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 11
		AND [name] =  'custSub'
END
ELSE
BEGIN  
	SELECT 'custSub not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustSuper')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 11
		AND [name] =  'CustSuper'
END
ELSE
BEGIN  
	SELECT 'CustSuper not exists !!!'
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



