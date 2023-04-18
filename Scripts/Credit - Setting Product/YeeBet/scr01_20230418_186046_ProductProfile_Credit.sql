/*
	Created: Luke
	Date: 20230418
	Task:  Insert new Product profile for YeeBet - Credit [RedmineID: #186046]
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

--ProductSettingDetail
DELETE psd
FROM ProductSettingDetail psd WITH (ROWLOCK)
WHERE psd.ProductID = @ProductID 

INSERT INTO ProductSettingDetail(SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, ProductSettingID, Parent_ProductSettingID, Child_DisplayOrder, SubType)
VALUES
(6, @Sporttype, @Bettype, 0, 41, NULL, NULL, NULL, NULL, NULL, 2, 4, 0, NULL, 76, NULL, 244, NULL, NULL, NULL) --Win Loss Limit
INSERT INTO ProductSettingDetail(SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, ProductSettingID, Parent_ProductSettingID, Child_DisplayOrder, SubType)
VALUES
(13, @Sporttype, @Bettype, 0, 41, NULL, NULL, 1, 0, 0, 2, 1, 0, NULL, 76, NULL, 245, NULL, 2, NULL) --Product Status
INSERT INTO ProductSettingDetail(SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, ProductSettingID, Parent_ProductSettingID, Child_DisplayOrder, SubType)
VALUES
(7, @Sporttype, @Bettype, 0, 41, NULL, NULL, NULL, NULL, NULL, 2, 6, 0, NULL, 76, 3, 246, NULL, NULL, NULL) --Stake Level
INSERT INTO ProductSettingDetail(SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, ProductSettingID, Parent_ProductSettingID, Child_DisplayOrder, SubType)
VALUES
(18, @Sporttype, @Bettype, 0, 41, 93, NULL, NULL, NULL, NULL, 2, 3, 0, NULL, 76, NULL, 247, NULL, NULL, NULL) --Position Taking
INSERT INTO ProductSettingDetail(SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, ProductSettingID, Parent_ProductSettingID, Child_DisplayOrder, SubType)
VALUES
(19, @Sporttype, @Bettype, 0, 41, NULL, 0.01, NULL, NULL, NULL, 2, 2, 0, 0.0005, 76, NULL, 248, NULL, NULL, NULL) --Commission

--ProductStatusProfile
DELETE psp
FROM ProductStatusProfile psp WITH (ROWLOCK)
WHERE psp.Sporttype = @Sporttype AND psp.Bettype = @Bettype

INSERT INTO ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
VALUES
(@Sporttype, @Bettype, 42)
