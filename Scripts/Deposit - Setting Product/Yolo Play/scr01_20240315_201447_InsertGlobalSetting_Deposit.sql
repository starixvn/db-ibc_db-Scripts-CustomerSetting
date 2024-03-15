/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke@20240315 
	Task: Yolo Play - Implement customer setting - initial setting [Redmine: #201447]
	DB: DBCUST/CustDB
*/

DECLARE @ProductID SMALLINT,
		@Sporttype SMALLINT,
		@Bettype SMALLINT

SELECT @ProductID = 84,
		@Sporttype = 189,
		@Bettype = 3650

--Dep_ProductSetting
INSERT INTO Dep_ProductSetting(ProductSettingID, ProductID, SettingType, TemplateID, DisplayOrder, SettingLevel)
	SELECT 191, @ProductID, 4, 0, 1, 1 UNION ALL	--Product Status
	SELECT 192, @ProductID, 1, 0, 2, 1				--PT

--Dep_ProductSetttingDetail
INSERT INTO Dep_ProductSettingDetail(ProductSettingID, SportType, BetType, IsLive, MaxDefaultValue, SettingStatus, MinDefaultValue, IsApplyBA)
	SELECT	191, @Sporttype, @Bettype, 0, 0, 1, NULL, 0 UNION ALL
	SELECT	192, @Sporttype, @Bettype, 0, 0, 1, NULL, 0

--Dep_ProductStatusProfile
INSERT INTO Dep_ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
	SELECT @Sporttype, @Bettype, 45