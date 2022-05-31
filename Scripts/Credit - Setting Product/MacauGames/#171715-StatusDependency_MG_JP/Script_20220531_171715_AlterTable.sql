/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20220531@Eden
	Task: Add new column [redmine : 171715]
	DB: DBCUST/CUSTDB
*/
USE CUSTDB
GO
ALTER TABLE ProductSettingDetail ADD ProductSettingID INT , Parent_ProductSettingID INT
GO
-- UPDATE ProductSettingDetail.ProductSettingID
;WITH TMP AS(
SELECT SettingType, SportType, BetType, IsLive
	, RN = ROW_NUMBER() OVER( ORDER BY SettingType, SportType, BetType, IsLive)
FROM ProductSettingDetail WITH(NOLOCK)
)
UPDATE p
SET p.ProductSettingID = t.RN
FROM ProductSettingDetail p WITH(ROWLOCK,UPDLOCK)
	INNER JOIN TMP t 
		ON t.SettingType = p.SettingType
		AND t.SportType = p.SportType
		AND t.IsLive = p.IsLive
		AND t.BetType = p.BetType

--Set UNIQUE for ProductSettingID
ALTER TABLE ProductSettingDetail ALTER COLUMN  ProductSettingID INT NOT NULL
ALTER TABLE ProductSettingDetail ADD CONSTRAINT UQ_ProductSettingID UNIQUE (ProductSettingID)
GO

