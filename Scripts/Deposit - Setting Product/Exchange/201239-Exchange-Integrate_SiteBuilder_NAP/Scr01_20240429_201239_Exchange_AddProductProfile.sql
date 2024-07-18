/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240429 
	Task: Licensee/NAP - Integrate Exchange [RedmineID: #201239]
	DB: DBCUST/CustDB 
*/

DECLARE @ProductID SMALLINT,
		@Sporttype SMALLINT,
		@Bettype SMALLINT

SELECT @ProductID = 31,
		@Sporttype = 221,
		@Bettype = 8001

--Dep_ProductSettingType
INSERT INTO Dep_ProductSettingType ([SettingType], [SettingName], [SettingNameDetail])
	SELECT 18,	'Position Taking',	'PositionTaking'

--Dep_ProductSetting
INSERT INTO Dep_ProductSetting(ProductSettingID, ProductID, SettingType, TemplateID, DisplayOrder, SettingLevel)
	SELECT 195, @ProductID, 18, 0, 2, 1				--PT

UPDATE Dep_ProductSetting WITH (ROWLOCK, UPDLOCK)
SET DisplayOrder=4
WHERE ProductID=31 AND  SettingType=5		--Charge Comm

--Dep_ProductSetttingDetail
INSERT INTO Dep_ProductSettingDetail(ProductSettingID, SportType, BetType, IsLive, MaxDefaultValue, SettingStatus, MinDefaultValue, IsApplyBA)
	SELECT	195, @Sporttype, @Bettype, 0, 0, 1, NULL, 0
