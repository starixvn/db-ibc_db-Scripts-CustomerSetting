/*<info serverAlias="IRS_DBTP-bodb02,DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20240913@Johnson	
	Task: In-House
	DB: IRS_DBTP-bodb02,DBCustRepl-ReplCustDB
	
	Revisions:
		- 20240913@Johnson: Created [RedmineID: #]

	Example:			
*/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'BetLimitControlCustSetting')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 14
		AND [name] =  'BetLimitControlCustSetting'
END
ELSE
BEGIN  
	SELECT 'BetLimitControlCustSetting not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'BetLimitControlDefaultSetting')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 14
		AND [name] =  'BetLimitControlDefaultSetting'
END
ELSE
BEGIN  
	SELECT 'BetLimitControlDefaultSetting not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'BetLimitControlProduct')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 14
		AND [name] =  'BetLimitControlProduct'
END
ELSE
BEGIN  
	SELECT 'BetLimitControlProduct not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'BetLimitControlType')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 14
		AND [name] =  'BetLimitControlType'
END
ELSE
BEGIN  
	SELECT 'BetLimitControlType not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'BetLimitControlTypeDetails')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 14
		AND [name] =  'BetLimitControlTypeDetails'
END
ELSE
BEGIN  
	SELECT 'BetLimitControlTypeDetail not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'BetRestriction_Currency')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 14
		AND [name] =  'BetRestriction_Currency'
END
ELSE
BEGIN  
	SELECT 'BetRestriction_Currency not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'BetRestriction_Customer')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 14
		AND [name] =  'BetRestriction_Customer'
END
ELSE
BEGIN  
	SELECT 'BetRestriction_Customer not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'BetRestriction_Setting')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 14
		AND [name] =  'BetRestriction_Setting'
END
ELSE
BEGIN  
	SELECT 'BetRestriction_Setting not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'BetRestriction_Site')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 14
		AND [name] =  'BetRestriction_Site'
END
ELSE
BEGIN  
	SELECT 'BetRestriction_Site not exists !!!'
END
GO
/***************************************************************************/



