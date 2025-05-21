/*<info serverAlias="IRS_DBSIC-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250611@Johnson	
	Task: In-House
	DB: IRS_DBSIC-CustDB
	
	Revisions:
		- 20250611@Johnson: Created [RedmineID: #226060]

	Example:			
*/
DECLARE @groupid INT = 130 --local

IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustPotentialWinLimit')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT @groupid,'CustPotentialWinLimit',0,'repupdatetime',0,'CustID|Sporttype|Bettype','Repl_GetCustPotentialWinLimit','Repl_PutCustPotentialWinLimit',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustPotentialWinLimit exists !!!'
END
GO
/***************************************************************************/



