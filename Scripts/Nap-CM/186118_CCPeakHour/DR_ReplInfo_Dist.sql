/*<info serverAlias="DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250411@20240612@Winfred	
	Task: In-House
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250411@Winfred: [NAP CM] Customer Class - Add Peak Hour Spread on rule setting [186118]

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
-- Run Phase sau
--IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSpreadClass_UAT')
--BEGIN
--	UPDATE RepInfo
--	SET active = 0
--	WHERE [group] = 0
--		AND [name] =  'CustomerClassSpreadClass_UAT'
--END
--ELSE
--BEGIN  
--	SELECT 'CustomerClassSpreadClass_UAT not exists !!!'
--END
--GO
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
-- Run Phase sau
--IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustomerClassSpreadDetail_UAT')
--BEGIN
--	UPDATE RepInfo
--	SET active = 0
--	WHERE [group] = 0
--		AND [name] =  'CustomerClassSpreadDetail_UAT'
--END
--ELSE
--BEGIN  
--	SELECT 'CustomerClassSpreadDetail_UAT not exists !!!'
--END
--GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustomerClassPeakHourRanger')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassPeakHourRanger',0,'repupdatetime',0,'RangeID|WeekDay|StartRange|EndRange','DR_Repl_GetCustomerClassPeakHourRanger_Dist','DR_Repl_PutCustomerClassPeakHourRanger_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustomerClassPeakHourRanger exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustomerClassSpreadLeagueGroup')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CustomerClassSpreadLeagueGroup',0,'repupdatetime',0,'PolicyID|LeagueGroupID','DR_Repl_GetCustomerClassSpreadLeagueGroup_Dist','DR_Repl_PutCustomerClassSpreadLeagueGroup_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CustomerClassSpreadLeagueGroup exists !!!'
END
GO
/***************************************************************************/
-- Run Phase sau
--IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CustomerClassSpreadLeagueGroup_UAT')
--BEGIN
--	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
--	SELECT 0,'CustomerClassSpreadLeagueGroup_UAT',0,'repupdatetime',0,'PolicyID|LeagueGroupID','DR_Repl_GetCustomerClassSpreadLeagueGroup_UAT_Dist','DR_Repl_PutCustomerClassSpreadLeagueGroup_UAT_Dist',1000,10,60000,0
--END
--ELSE
--BEGIN 
--	SELECT 'CustomerClassSpreadLeagueGroup_UAT exists !!!'
--END
--GO
/***************************************************************************/
