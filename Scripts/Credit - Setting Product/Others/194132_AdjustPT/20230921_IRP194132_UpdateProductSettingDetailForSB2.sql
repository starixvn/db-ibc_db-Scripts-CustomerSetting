/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230921@Johnson
	Task: update ProductSettingDetail MaxPT for SB2
	DB: DBCust/CustDB
*/

UPDATE ProductSettingDetail WITH(ROWLOCK)
SET MaxPT = 93
WHERE SportType in (43,44)
	AND SettingType = 1
