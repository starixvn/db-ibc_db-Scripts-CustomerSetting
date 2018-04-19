/*
    Created: 20180320@Vicky
    Task: Update Setting Status to PROD for VS Basketball & VSWC
    DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @tbl_SportType TABLE(settingType TINYINT, sportType SMALLINT, betType SMALLINT)


INSERT INTO @tbl_SportType(settingType, sportType, betType)
VALUES ---VS Basketball
       (1, 193, 2801), 
       (2, 193, 2801),
       (6, 180, 1201),
       ---VS WC
       (1, 192, 2701),
       (2, 192, 2701)
       

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE ps
SET ps.SettingStatus = 0
FROM dbo.ProductSettingDetail ps WITH (ROWLOCK,UPDLOCK)
    INNER JOIN @tbl_SportType spt ON (spt.settingType = ps.settingType AND spt.sportType = ps.sportType AND spt.betType = ps.betType) 
    
UPDATE ProductLaunchedSiteCurrency 
SET isTest = 0
WHERE SportType IN (193, 192)