/*
    Created: 20180320@Vicky
    Task: Update Setting Status to PROD for VS Basketball & VSWC
    DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @tbl_SportType TABLE(settingType TINYINT, sportType SMALLINT, betType SMALLINT)


INSERT INTO @tbl_SportType(settingType, sportType, betType)
VALUES (8, 248, 4101), 
       

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE ps
SET ps.SettingStatus = 0
FROM dbo.ProductSettingDetail ps WITH (ROWLOCK,UPDLOCK)
    INNER JOIN @tbl_SportType spt ON (spt.settingType = ps.settingType AND spt.sportType = ps.sportType AND spt.betType = ps.betType) 
    
