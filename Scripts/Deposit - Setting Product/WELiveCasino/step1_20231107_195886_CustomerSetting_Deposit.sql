/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20231107
	Task: WE Live Casino - Implement customer setting - Initial setting [Redmine: #195886]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @ProductID SMALLINT,
		@Sporttype SMALLINT,
		@Bettype SMALLINT

SELECT @ProductID = 80,
		@Sporttype = 228,
		@Bettype = 10300

--Dep_ProductSetting
INSERT INTO Dep_ProductSetting(ProductSettingID, ProductID, SettingType, TemplateID, DisplayOrder, SettingLevel)
	SELECT 177, @ProductID, 4, 0, 1, 1 --Product Status
UNION ALL
	SELECT 178, @ProductID, 7, 0, 3, 3 --Stake Level
UNION ALL 
	SELECT 179, @ProductID, 1, 0, 2, 1 --PT


--Dep_ProductSetttingDetail
INSERT INTO Dep_ProductSettingDetail(ProductSettingID, SportType, BetType, IsLive, MaxDefaultValue, SettingStatus, MinDefaultValue, IsApplyBA)
	SELECT	177, @Sporttype, @Bettype, 0, 0, 1, NULL, 0
UNION ALL
	SELECT	178, @Sporttype, @Bettype, 0, 0, 1, NULL, 0
UNION ALL
	SELECT	179, @Sporttype, @Bettype, 0, 0, 1, NULL, 0


--Dep_ProductStatusProfile
INSERT INTO Dep_ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
	SELECT @Sporttype, @Bettype, 40
