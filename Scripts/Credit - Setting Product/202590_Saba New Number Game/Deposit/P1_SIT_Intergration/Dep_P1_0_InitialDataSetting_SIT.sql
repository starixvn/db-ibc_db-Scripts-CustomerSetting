/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240321@Helios
	Task: Incorporate Saba New Number Game - Init for UUS - Deposit [#202590] 
		https://nexdev.net/issues/202590
	DB: DBCust/CustDB
*/
	
	DECLARE 
		@ProductID SMALLINT,
		@Sporttype SMALLINT,
		@Bettype SMALLINT

	SELECT 
		@ProductID = 86,
		@Sporttype = 240,
		@Bettype = 10801

	--Dep_ProductSetting
	INSERT INTO Dep_ProductSetting(ProductSettingID, ProductID, SettingType, TemplateID, DisplayOrder, SettingLevel)
	SELECT 193, @ProductID, 4, 0, 1, 1 UNION ALL		--Product Status
	SELECT 194, @ProductID, 1, 0, 2, 1				--PT

	--Dep_ProductSetttingDetail
	INSERT INTO Dep_ProductSettingDetail(ProductSettingID, SportType, BetType, IsLive, MaxDefaultValue, SettingStatus, MinDefaultValue, IsApplyBA)
	SELECT	193, @Sporttype, @Bettype, 0, 0, 1, NULL, 0 UNION ALL
	SELECT	194, @Sporttype, @Bettype, 0, 0, 1, NULL, 0

	--Dep_ProductStatusProfile
	INSERT INTO Dep_ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
	SELECT @Sporttype, @Bettype, 46