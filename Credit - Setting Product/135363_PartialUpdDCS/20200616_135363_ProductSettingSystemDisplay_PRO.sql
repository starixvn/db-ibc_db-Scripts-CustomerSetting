/*
	Created: 20200811@Elodie
	Task: Set up ProductSettingSystemDisplay for testing purpose  [Redmine: #135363] 
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

UPDATE ps 
SET SettingType = 18
FROM ProductSettingSystemDisplay ps WITH (ROWLOCK)
WHERE ProductID = 41 AND SettingType = 1

UPDATE ps 
SET SettingType = 19
FROM ProductSettingSystemDisplay ps WITH (ROWLOCK)
WHERE ProductID = 41 AND SettingType = 3

UPDATE ps 
SET SettingType = 18
FROM ProductSettingSystemDisplay ps WITH (ROWLOCK)
WHERE ProductID = 44 AND SettingType = 1