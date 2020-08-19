/*
	Created: 20200811@Elodie
	Task: Set up ProductSettingSystemDisplay for testing purpose  [Redmine: #135363] 
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

UPDATE ps 
SET SettingType = 1
FROM ProductSettingSystemDisplay ps WITH (ROWLOCK)
WHERE ProductID = 41 AND SettingType = 18

UPDATE ps 
SET SettingType = 3
FROM ProductSettingSystemDisplay ps WITH (ROWLOCK)
WHERE ProductID = 41 AND SettingType = 19

UPDATE ps 
SET SettingType = 1
FROM ProductSettingSystemDisplay ps WITH (ROWLOCK)
WHERE ProductID = 44 AND SettingType = 18