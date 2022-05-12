/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220412@Johnson
	Task: Virtual Games - Incorporate 6 new games of Mine & Tower scheme [#RedmineID:#169418]
	DB: DBCUST/CustDB
*/

UPDATE ProductSettingDetail WITH(ROWLOCK)
SET SettingStatus = 0 
WHERE SettingType = 7
	AND sporttype = 245
	AND bettype = 4605
	