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

IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustPotentialWinLimit')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = @groupid
		AND [name] =  'CustPotentialWinLimit'
END
ELSE
BEGIN  
	SELECT 'CustPotentialWinLimit not exists !!!'
END
GO
/***************************************************************************/



