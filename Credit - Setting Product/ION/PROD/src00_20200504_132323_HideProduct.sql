/*
	Created: 20200504@Eden
	Task: Update SettingStatus = 2 (PROD) for ION, RNG War [Redmine: 132323]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO
UPDATE S
SET S.SettingStatus = 2
FROM ProductSettingDetail S WITH(ROWLOCK) 
WHERE Sporttype IN (225, 224)
