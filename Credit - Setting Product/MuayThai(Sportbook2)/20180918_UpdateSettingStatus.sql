/*
	Created: 20180918@Winnie
	Task: Update setting status for MuayThai
	DB: DBCust/CustDB
*/

UPDATE ProductSettingSystemDisplay WITH(ROWLOCK,UPDLOCK)
	SET SettingType=13
WHERE ProductID=16

UPDATE ProductSettingDetail WITH(ROWLOCK,UPDLOCK)
	SET SettingType=13
WHERE ProductID=16 AND SettingType=4
