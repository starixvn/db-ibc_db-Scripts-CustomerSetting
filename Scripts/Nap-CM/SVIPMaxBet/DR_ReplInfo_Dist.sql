/*<info serverAlias="DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250313@Winfred	
	Task: In-House
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250313@Winfred:  [NAP CM] Customer - Increase Bet Limit Created [RedmineID: #218073]

	Example:			
*/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'SVIPMaxBetPlayer')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'SVIPMaxBetPlayer',0,'repupdatetime',0,'SiteID|custid|SportType|Bettype','DR_Repl_GetSVIPMaxBetPlayer_Dist','DR_Repl_PutSVIPMaxBetPlayer_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'SVIPMaxBetPlayer exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'SVIPMaxBetHistory')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'SVIPMaxBetHistory',0,'repupdatetime',0,'ID','DR_Repl_GetSVIPMaxBetHistory_Dist','DR_Repl_PutSVIPMaxBetHistory_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'SVIPMaxBetHistory exists !!!'
END
GO
/***************************************************************************/
