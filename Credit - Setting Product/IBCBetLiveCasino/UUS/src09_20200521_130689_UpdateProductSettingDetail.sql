/*
	Created: 20200423@Tiara
	Task: Update SettingStatus = 0 (PROD) for GT Casino [Redmine: #130689]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO
UPDATE S
SET S.SettingStatus = 0
FROM ProductSettingDetail S WITH(ROWLOCK) 
WHERE Sporttype = 242
