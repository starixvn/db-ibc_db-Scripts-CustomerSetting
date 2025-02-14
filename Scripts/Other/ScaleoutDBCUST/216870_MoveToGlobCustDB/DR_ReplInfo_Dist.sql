/*<info serverAlias="DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250305@Johnson	
	Task: In-House
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250305@Johnson: Created [RedmineID: #216870]

	Example:			
*/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'Winlimit_ProductGlobalSetting')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	--local
	SELECT 130,'Winlimit_ProductGlobalSetting',0,'repupdatetime',0,'ProductID|BetTypeID|GroupID|Currency|IsDeposit','Repl_GetWinlimit_ProductGlobalSetting','Repl_PutWinlimit_ProductGlobalSetting_Dist',1000,10,60000,0
	--PRO
	--SELECT 11,'Winlimit_ProductGlobalSetting',0,'repupdatetime',0,'ProductID|BetTypeID|GroupID|Currency|IsDeposit','Repl_GetWinlimit_ProductGlobalSetting','Repl_PutWinlimit_ProductGlobalSetting_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'Winlimit_ProductGlobalSetting exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'Winlimit_Group')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	--local
	SELECT 130,'Winlimit_Group',0,'repupdatetime',0,'GroupID','Repl_GetWinlimit_Group','Repl_PutWinlimit_Group_Dist',1000,10,60000,0
	--PRO
	--SELECT 11,'Winlimit_Group',0,'repupdatetime',0,'GroupID','Repl_GetWinlimit_Group','Repl_PutWinlimit_Group_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'Winlimit_Group exists !!!'
END
GO
/***************************************************************************/
