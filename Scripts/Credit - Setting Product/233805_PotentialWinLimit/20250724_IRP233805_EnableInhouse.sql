/*<info serverAlias="IRS_DBTP-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250724@Johnson	
	Task: In-House
	DB: IRS_DBTP-bodb02
	
	Revisions:
		- 20250724@Johnson: Created [RedmineID: #233805]

	Example:			
*/

DECLARE @group INT = 13 --local
--DECLARE @group INT = 12 --PRO

UPDATE RepInfo
SET active = 1
WHERE [group] = @group
    AND [name] =  'CustPotentialWinLimit'