/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221121@Eden
	Task: Remove some setting of VS and RNG Lottery [#180640]
	DB: DBCust/CustDB
*/
USE CustDB
GO

UPDATE p
SET SettingStatus = 2
FROM ProductSettingDetail p WITH(ROWLOCK,UPDLOCK) 
WHERE productid = 5 
	AND SportType <> 180 
	AND settingtype IN(1,2,20)

UPDATE p
SET SettingLevel = 1
FROM ProductSettingDetail p WITH(ROWLOCK,UPDLOCK) 
WHERE productid = 5 
	AND SportType = 180 
	AND settingtype IN(1,2)


/*
SELECT *
FROM ProductSettingDetail p WITH(ROWLOCK,UPDLOCK) 
WHERE productid = 5 
	AND SportType = 180 
*/