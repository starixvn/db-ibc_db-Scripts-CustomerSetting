/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke@20240229 
	Task: Task: UUSlots - Integrate New Product - Implement Customer setting , Initial Setting [Redmine: #192601]
	DB: DBCUST/CustDB
*/

DECLARE @ProductID SMALLINT,
		@Sporttype SMALLINT,
		@Bettype SMALLINT

SELECT @ProductID = 78,
		@Sporttype = 216,
		@Bettype = 10000

--Dep_ProductSetting
INSERT INTO Dep_ProductSetting(ProductSettingID, ProductID, SettingType, TemplateID, DisplayOrder, SettingLevel)
	SELECT 189, @ProductID, 4, 0, 1, 1 UNION ALL	--Product Status
	SELECT 190, @ProductID, 1, 0, 2, 1				--PT

--Dep_ProductSetttingDetail
INSERT INTO Dep_ProductSettingDetail(ProductSettingID, SportType, BetType, IsLive, MaxDefaultValue, SettingStatus, MinDefaultValue, IsApplyBA)
	SELECT	189, @Sporttype, @Bettype, 0, 0, 1, NULL, 0 UNION ALL
	SELECT	190, @Sporttype, @Bettype, 0, 0, 1, NULL, 0

--Dep_ProductStatusProfile
INSERT INTO Dep_ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
	SELECT @Sporttype, @Bettype, 44