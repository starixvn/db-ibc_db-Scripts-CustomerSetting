/*<info serverAlias="IRS_DBTP-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250313@Winfred	
	Task: In-House
	DB: IRS_DBTP-bodb02
	
	Revisions:
		- 20250313@Winfred:  [NAP CM] Customer - Increase Bet Limit Created [RedmineID: #218073]

	Example:			
*/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'SVIPMaxBetPlayer')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 0
		AND [name] =  'SVIPMaxBetPlayer'
END
ELSE
BEGIN  
	SELECT 'SVIPMaxBetPlayer not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'SVIPMaxBetHistory')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 0
		AND [name] =  'SVIPMaxBetHistory'
END
ELSE
BEGIN  
	SELECT 'SVIPMaxBetHistory not exists !!!'
END
GO
/***************************************************************************/



