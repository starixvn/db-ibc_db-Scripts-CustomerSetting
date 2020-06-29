/*
	Created: 20200625@winfred
	Task: HideProduct SettingStatus = 2 (PROD) for Saba VS [Redmine: 136210]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO
UPDATE S
SET S.SettingStatus = 2
FROM ProductSettingDetail S WITH(ROWLOCK) 
WHERE Sporttype = 98 AND ProductID = 54
