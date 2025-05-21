/*<info serverAlias="IRS_DBTP-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250506@Johnson	
	Task: In-House
	DB: IRS_DBTP-bodb02
	
	Revisions:
		- 20250506@Johnson: Created [RedmineID: #226060]

	Example:			
*/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustPotentialWinLimit')
BEGIN
	DECLARE @group INT = 13 --local
	--DECLARE @group INT = 12 --PRO

	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT @group,'CustPotentialWinLimit',0,'repupdatetime',0,'CustID|Sporttype|Bettype','Repl_GetCustPotentialWinLimit','Repl_PutCustPotentialWinLimit_Dist',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CustPotentialWinLimit exists !!!'
END
GO
/***************************************************************************/



