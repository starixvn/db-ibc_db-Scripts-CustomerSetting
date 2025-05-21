/*<info serverAlias="IRS_DBTP-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250506@Johnson	
	Task: In-House
	DB: IRS_DBTP-bodb02
	
	Revisions:
		- 20250506@Johnson: Created [RedmineID: #226060]

	Example:			
*/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustPotentialWinLimit')
BEGIN
	DECLARE @group INT = 13 --local
	--DECLARE @group INT = 12 --PRO

	UPDATE RepInfo
	SET active = 1
	WHERE [group] = @group
		AND [name] =  'CustPotentialWinLimit'
END
ELSE
BEGIN  
	SELECT 'CustPotentialWinLimit not exists !!!'
END
GO
/***************************************************************************/



