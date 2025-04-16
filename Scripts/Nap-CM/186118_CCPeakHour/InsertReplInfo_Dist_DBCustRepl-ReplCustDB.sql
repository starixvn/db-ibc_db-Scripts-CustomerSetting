/*<info serverAlias="DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250415@Winfred	
	Task: In-House
	DB: DBCustRepl-ReplCustDB
	
	Revisions:
		- 20250415@Winfred: Created [RedmineID: #186118]

	Example:			
*/
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSpreadClass')
BEGIN
	UPDATE RepInfo
	SET active = 0
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
	SET active = 0
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
	SET active = 0
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
	SET active = 0
	WHERE [group] = 0
		AND [name] =  'CustomerClassSpreadDetail_UAT'
END
ELSE
BEGIN  
	SELECT 'CustomerClassSpreadDetail_UAT not exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSpreadLeagueGroup')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassSpreadLeagueGroup',0,'repupdatetime',0,'PolicyID|LeagueGroupID','Repl_GetCustomerClassSpreadLeagueGroup_Dist','Repl_PutCustomerClassSpreadLeagueGroup',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassSpreadLeagueGroup exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSpreadLeagueGroup_UAT')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassSpreadLeagueGroup_UAT',0,'repupdatetime',0,'PolicyID|LeagueGroupID','Repl_GetCustomerClassSpreadLeagueGroup_UAT_Dist','Repl_PutCustomerClassSpreadLeagueGroup_UAT',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassSpreadLeagueGroup_UAT exists !!!'
END
GO
/***************************************************************************/



