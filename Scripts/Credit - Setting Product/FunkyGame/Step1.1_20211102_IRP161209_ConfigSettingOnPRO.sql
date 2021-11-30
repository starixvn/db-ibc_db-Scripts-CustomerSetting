/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Johnson
	Date: 20211102
	Task: SBO RNG WAR - Change Product & Sport Name into Funky Game and add some new games
	DB: DBCust/CustDB
*/

--update disabled settingtype 2	
UPDATE ProductSettingDetail WITH(ROWLOCK)
SET SettingStatus = 2
WHERE SettingType = 2
	AND sporttype = 224	
	
	
GO

UPDATE ProductSettingDetail WITH(ROWLOCK)
SET SettingStatus = 0
WHERE SettingType = 8
	AND sporttype = 224		