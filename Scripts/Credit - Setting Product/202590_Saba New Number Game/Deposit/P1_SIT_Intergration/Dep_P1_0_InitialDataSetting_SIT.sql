/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240321@Helios
	Task: Incorporate Saba New Number Game - Init for UUS - Deposit [#202590] 
		https://nexdev.net/issues/202590
	DB: DBCust/CustDB

	Revision:
		- 20250114@Tacy: PROD - Enable Saba xD for Yes888 site [#216789]

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
	INSERT INTO Dep_ProductSetting(ProductSettingID, ProductID, SettingType, TemplateID, DisplayOrder, SettingLevel, RepUpdateTime)
	SELECT 193, @ProductID, 4, 0, 1, 1, dbo.f_GetDateTime2() UNION ALL	--Product Status
	SELECT 194, @ProductID, 1, 0, 2, 1, dbo.f_GetDateTime2()				--PT

	--Dep_ProductSetttingDetail
	INSERT INTO Dep_ProductSettingDetail(ProductSettingID, SportType, BetType, IsLive, MaxDefaultValue, SettingStatus, MinDefaultValue, IsApplyBA, RepUpdateTime)
	SELECT	193, @Sporttype, @Bettype, 0, 0, 0, NULL, 0, dbo.f_GetDateTime2() UNION ALL
	SELECT	194, @Sporttype, @Bettype, 0, 0, 0, NULL, 0, dbo.f_GetDateTime2()

	--Dep_ProductStatusProfile
	INSERT INTO Dep_ProductStatusProfile(Sporttype, Bettype, bitmapOrder, RepUpdateTime)
	SELECT @Sporttype, @Bettype, 46, dbo.f_GetDateTime2()