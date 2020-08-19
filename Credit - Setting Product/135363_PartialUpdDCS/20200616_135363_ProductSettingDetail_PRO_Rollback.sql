/*
	Created: 20200616@Elodie
	Task: Rollback ProductSettingDetail [Redmine: #135363] 
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

UPDATE ps 
SET SettingType = 1
FROM ProductSettingDetail ps WITH (ROWLOCK)
WHERE ProductID = 41 AND SettingType = 18

UPDATE ps 
SET SettingType = 3
FROM ProductSettingDetail ps WITH (ROWLOCK)
WHERE ProductID = 41 AND SettingType = 19

UPDATE ps 
SET SettingType = 1
FROM ProductSettingDetail ps WITH (ROWLOCK)
WHERE ProductID = 44 AND SettingType = 18