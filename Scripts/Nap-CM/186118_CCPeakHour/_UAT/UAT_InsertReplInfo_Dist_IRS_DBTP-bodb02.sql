/*<info serverAlias="IRS_DBTP-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250415@Winfred	
	Task: In-House
	DB: IRS_DBTP-bodb02
	
	Revisions:
		- 20250411@Winfred: [NAP CM] Customer Class - Add Peak Hour Spread on rule setting [186118]

	Example:			
*/
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSpreadClass_UAT')
BEGIN
	UPDATE RepInfo
	SET active = 0
	WHERE [name] =  'CustomerClassSpreadClass_UAT'
END
ELSE
BEGIN  
	SELECT 'CustomerClassSpreadClass_UAT not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSpreadDetail_UAT')
BEGIN
	UPDATE RepInfo
	SET active = 0
	WHERE [name] =  'CustomerClassSpreadDetail_UAT'
END
ELSE
BEGIN  
	SELECT 'CustomerClassSpreadDetail_UAT not exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSpreadLeagueGroup_UAT')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassSpreadLeagueGroup_UAT',0,'repupdatetime',0,'PolicyID|LeagueGroupID','Repl_GetCustomerClassSpreadLeagueGroup_UAT','Repl_PutCustomerClassSpreadLeagueGroup_UAT_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustomerClassSpreadLeagueGroup_UAT exists !!!'
END
GO
/***************************************************************************/



