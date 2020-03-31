/*
	Created: 20200326@Elodie
	Task: Update product profile for Lottery
	DB: DBCUST/CustDB
*/

USE CustDB
GO

UPDATE dbo.ProductSettingDetail 
SET SettingLevel = CASE WHEN SettingType = 1 THEN 4 WHEN SettingType = 2 THEN 4 WHEN SettingType = 6 THEN 2 WHEN SettingType = 13 THEN 2 END
WHERE ProductID = 28

SELECT *
FROM dbo.ProductSettingDetail WITH (NOLOCK)
WHERE ProductID = 28





