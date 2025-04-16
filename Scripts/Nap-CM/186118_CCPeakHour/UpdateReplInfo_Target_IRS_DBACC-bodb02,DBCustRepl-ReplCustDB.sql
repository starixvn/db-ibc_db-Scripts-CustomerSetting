/*<info serverAlias="IRS_DBACC-bodb02,DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250415@Winfred	
	Task: In-House
	DB: IRS_DBACC-bodb02,DBCustRepl-ReplCustDB
	
	Revisions:
		- 20250415@Winfred: Created [RedmineID: #186118]

	Example:			
*/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSpreadClass')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 0
		AND [name] =  'CustomerClassSpreadClass'
END
ELSE
BEGIN  
	SELECT 'CustomerClassSpreadClass not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSpreadClass_UAT')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 0
		AND [name] =  'CustomerClassSpreadClass_UAT'
END
ELSE
BEGIN  
	SELECT 'CustomerClassSpreadClass_UAT not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSpreadDetail')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 0
		AND [name] =  'CustomerClassSpreadDetail'
END
ELSE
BEGIN  
	SELECT 'CustomerClassSpreadDetail not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSpreadDetail_UAT')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 0
		AND [name] =  'CustomerClassSpreadDetail_UAT'
END
ELSE
BEGIN  
	SELECT 'CustomerClassSpreadDetail_UAT not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSpreadLeagueGroup')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 0
		AND [name] =  'CustomerClassSpreadLeagueGroup'
END
ELSE
BEGIN  
	SELECT 'CustomerClassSpreadLeagueGroup not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSpreadLeagueGroup_UAT')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 0
		AND [name] =  'CustomerClassSpreadLeagueGroup_UAT'
END
ELSE
BEGIN  
	SELECT 'CustomerClassSpreadLeagueGroup_UAT not exists !!!'
END
GO
/***************************************************************************/



