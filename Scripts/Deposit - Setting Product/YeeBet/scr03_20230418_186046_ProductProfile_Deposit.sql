/*
	Created: Luke
	Date: 20230418
	Task:  Insert new Product profile for YeeBet - Deposit [RedmineID: #186046]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @ProductID SMALLINT,
		@Sporttype SMALLINT,
		@Bettype SMALLINT
SET @ProductID = 76
SET @Sporttype = 159
SET @Bettype = 3151

--Dep_ProductSetting
DELETE ps
FROM Dep_ProductSetting ps WITH (ROWLOCK)
WHERE ps.ProductID = @ProductID

INSERT INTO Dep_ProductSetting(ProductSettingID, ProductID, SettingType, TemplateID, DisplayOrder, SettingLevel)
VALUES
	(165, @ProductID, 4, 0, 1, 1) --Product Status
INSERT INTO Dep_ProductSetting(ProductSettingID, ProductID, SettingType, TemplateID, DisplayOrder, SettingLevel)
VALUES
	(166, @ProductID, 1, 0,	2, 1) --Position Taking
INSERT INTO Dep_ProductSetting(ProductSettingID, ProductID, SettingType, TemplateID, DisplayOrder, SettingLevel)
VALUES
	(167, @ProductID, 7, 0, 3, 3) --Stake Level

--Dep_ProductSetttingDetail
DELETE psd
FROM Dep_ProductSettingDetail psd WITH (ROWLOCK)
WHERE psd.SportType = @Sporttype AND psd.BetType = @Bettype

INSERT INTO Dep_ProductSettingDetail(ProductSettingID, SportType, BetType, IsLive, MaxDefaultValue, SettingStatus, MinDefaultValue, IsApplyBA)
VALUES
	(165, @Sporttype, @Bettype, 0, 0, 1, NULL, 0),
	(166, @Sporttype, @Bettype, 0, 0, 1, NULL, 0),
	(167, @Sporttype, @Bettype, 0, 0, 1, NULL, 0)

--Dep_ProductStatusProfile
DELETE psp
FROM Dep_ProductStatusProfile psp WITH (ROWLOCK)
WHERE psp.Sporttype = @Sporttype AND psp.Bettype = @Bettype

INSERT INTO Dep_ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
VALUES
	(@Sporttype, @Bettype, 37)
