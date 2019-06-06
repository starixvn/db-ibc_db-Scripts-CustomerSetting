/*
	Created: 20190606@Elodie
	DB: DBCUST/CustDB
	Task: Update comm interval 
*/
USE CustDB
GO

UPDATE ps
SET ps.IntervalValue = 0.0025
FROM dbo.CS_ProductSettingDetail ps WITH (NOLOCK)
WHERE ps.SettingType = 2 AND ps.IntervalValue = 0.00050000

