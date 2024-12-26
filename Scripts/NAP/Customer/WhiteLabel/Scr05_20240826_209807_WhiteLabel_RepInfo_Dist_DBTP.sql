/*<info serverAlias="IRS_DBTP-bodb02,DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20240916@Tacy	
	Task: In-House
	DB: IRS_DBTP-bodb02,DBCustRepl-ReplCustDB
	
	Revisions:
		- 20240916@Tacy: Created [RedmineID: #209807]

	Example:			
*/

--WhiteLabelInfo
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'WhiteLabelInfo')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 12,'WhiteLabelInfo',0,'repupdatetime',0,'CustID','Repl_GetWhiteLabelInfo','Repl_PutWhiteLabelInfo_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'WhiteLabelInfo exists !!!'
END
GO
/***************************************************************************/

--WhiteLabelSetting
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'WhiteLabelSetting')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 12,'WhiteLabelSetting',0,'repupdatetime',0,'CustID|FromDate','Repl_GetWhiteLabelSetting','Repl_PutWhiteLabelSetting_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'WhiteLabelSetting exists !!!'
END
GO
/***************************************************************************/

