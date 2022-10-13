/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220923@Tacy
	Task: UPDATE Product profile for Microgaming [redmine:#175853]
	DB: DBCust/CustDB
*/
UPDATE ProductSettingDetail
SET SettingStatus=0
WHERE SportType=155
