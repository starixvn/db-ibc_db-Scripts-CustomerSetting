/*<info serverAlias="IRS_DBACC-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250211@Winfred	
	DB: IRS_DBACC-bodb02
	Task: Apply Inhouse replication for Customer Class
	
	Revisions:
		- 20250121@Winfred: [NAP CM] Scale Out DBCUST - Apply Inhouse replication for Customer Class[Redmine: #20119]

	Example:			
*/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassPolicyManagement')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 0
		AND [name] =  'CustomerClassPolicyManagement'
END
ELSE
BEGIN  
	SELECT 'CustomerClassPolicyManagement not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassPolicyRule')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 0
		AND [name] =  'CustomerClassPolicyRule'
END
ELSE
BEGIN  
	SELECT 'CustomerClassPolicyRule not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassRule')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 0
		AND [name] =  'CustomerClassRule'
END
ELSE
BEGIN  
	SELECT 'CustomerClassRule not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassRuleLeagueGroup')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 0
		AND [name] =  'CustomerClassRuleLeagueGroup'
END
ELSE
BEGIN  
	SELECT 'CustomerClassRuleLeagueGroup not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSetting')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 0
		AND [name] =  'CustomerClassSetting'
END
ELSE
BEGIN  
	SELECT 'CustomerClassSetting not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSiteManagement')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 0
		AND [name] =  'CustomerClassSiteManagement'
END
ELSE
BEGIN  
	SELECT 'CustomerClassSiteManagement not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSpread')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 0
		AND [name] =  'CustomerClassSpread'
END
ELSE
BEGIN  
	SELECT 'CustomerClassSpread not exists !!!'
END
GO
/***************************************************************************/
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
