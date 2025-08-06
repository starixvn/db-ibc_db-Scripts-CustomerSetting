/*<info serverAlias="DBGLOB-GlobCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250610@Dave	
	Task: In-House
	DB: DBGLOB-GlobCustDB
	
	Revisions:
		- 20250610@Dave: Apply Inhouse replication for remain tables [RedmineID: #229159]	
*/

IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'SportBettypeSettingMatrix')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 0
		AND [name] =  'SportBettypeSettingMatrix'
END
ELSE
BEGIN  
	SELECT 'SportBettypeSettingMatrix not exists !!!'
END
GO
/***************************************************************************/

IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'Dep_ProductStakeLevelGroup')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 0
		AND [name] =  'Dep_ProductStakeLevelGroup'
END
ELSE
BEGIN  
	SELECT 'Dep_ProductStakeLevelGroup not exists !!!'
END
GO

/***************************************************************************/

IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'DomainManagement')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 0
		AND [name] =  'DomainManagement'
END
ELSE
BEGIN  
	SELECT 'DomainManagement not exists !!!'
END
GO
/***************************************************************************/

IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductStakeLevelGroup')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 0
		AND [name] =  'ProductStakeLevelGroup'
END
ELSE
BEGIN  
	SELECT 'ProductStakeLevelGroup not exists !!!'
END
GO
/***************************************************************************/