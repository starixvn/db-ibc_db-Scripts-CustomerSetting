/*<info serverAlias="IRS_DBTP-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250313@Winfred	
	Task: In-House
	DB: IRS_DBTP-bodb02
	
	Revisions:
		- 20250313@Winfred:  [NAP CM] Customer - Increase Bet Limit Created [RedmineID: #218073]

	Example:			
*/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'SVIPMaxBetPlayer')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'SVIPMaxBetPlayer',0,'repupdatetime',0,'SiteID|custid|SportType|Bettype','Repl_GetSVIPMaxBetPlayer','Repl_PutSVIPMaxBetPlayer_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'SVIPMaxBetPlayer exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'SVIPMaxBetHistory')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'SVIPMaxBetHistory',0,'repupdatetime',0,'ID','Repl_GetSVIPMaxBetHistory','Repl_PutSVIPMaxBetHistory_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'SVIPMaxBetHistory exists !!!'
END
GO
/***************************************************************************/



