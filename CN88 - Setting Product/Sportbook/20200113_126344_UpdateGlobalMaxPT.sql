/*
	Created: 20200113@Elodie
	DB: DBCUST/CustDB
	Task: Update Global MaxPT 
*/
USE CustDB
GO

UPDATE ps
SET ps.MaxPT = 92
FROM dbo.CS_ProductSettingDetail ps WITH (ROWLOCK)
WHERE SettingType = 1 AND SportType = 1

SELECT *
FROM dbo.CS_ProductSettingDetail ps WITH (NOLOCK)
WHERE SettingType = 1 AND SportType = 1