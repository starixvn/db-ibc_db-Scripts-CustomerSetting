/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221121@Eden
	Task: Remove some setting of VS and RNG Lottery 
		ADD new settingtype for Winloss limit [#180640]
	DB: DBCust/CustDB
*/
USE CustDB
GO
--VS
--> Delete all PT and bet setting bettype of VS exclude Virtual Soccer
UPDATE p
SET SettingStatus = 2
FROM ProductSettingDetail p WITH(ROWLOCK,UPDLOCK) 
WHERE productid = 5 
	AND SportType <> 180 
	AND settingtype IN(1,2,20)

--> Update setting level 
UPDATE p
SET SettingLevel = 1
FROM ProductSettingDetail p WITH(ROWLOCK,UPDLOCK) 
WHERE productid = 5 
	AND SportType = 180 
	AND settingtype IN(1,2)

---Lottery
--> Delete all PT and bet setting bettype of Lottery exclude MaxDice bettype
UPDATE p
SET SettingStatus = 2
FROM ProductSettingDetail p WITH(ROWLOCK,UPDLOCK) 
WHERE productid = 44 
	AND SportType = 220 
	AND bettype <> 1024
	AND settingtype IN(2,18)

--> Update setting level 
UPDATE p
SET SettingLevel = 2
FROM ProductSettingDetail p WITH(ROWLOCK,UPDLOCK) 
WHERE productid = 44 
	AND SportType = 220 
	AND bettype = 1024
	AND settingtype IN(2,18)

--Remove all Winloss limit setting of RNG Lottery exclude Lottery
UPDATE p
SET SettingStatus = 2
FROM ProductSettingDetail p WITH(ROWLOCK,UPDLOCK) 
WHERE productid = 44 
	AND settingtype = 6
	AND SportType <> 220

UPDATE p
SET SettingLevel = 1,
	SettingType = 22
FROM ProductSettingDetail p WITH(ROWLOCK,UPDLOCK) 
WHERE productid = 44 
	AND settingtype = 6
	AND SportType = 220

/*
SELECT *
FROM ProductSettingDetail p WITH(NOLOCK) 
WHERE productid = 5 
	AND SportType = 180 

SELECT *
FROM ProductSettingDetail p WITH(NOLOCK) 
WHERE productid = 44 
	AND SportType = 220 
	AND bettype <> 1024
	AND settingtype IN(2,18)

SELECT *
FROM ProductSettingDetail p WITH(ROWLOCK,UPDLOCK) 
WHERE productid = 44 
	AND settingtype IN(6,22)
*/
--Insert ProductSettingType
INSERT INTO ProductSettingType(SettingType,SettingName,SettingNameDetail)
SELECT 22,'Win Loss Limit','WinLossLimit'
WHERE NOT EXISTS( SELECT 1 FROM ProductSettingType WITH(NOLOCK) WHERE SettingType = 22)