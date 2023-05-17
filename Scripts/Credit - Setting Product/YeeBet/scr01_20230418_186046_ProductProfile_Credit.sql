/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20230418
	Task:  Insert new Product profile for YeeBet - Credit [RedmineID: #186046]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @ProductID SMALLINT,
		@RealProductID SMALLINT,
		@Sporttype SMALLINT,
		@Bettype SMALLINT
SET @ProductID = 41
SET @RealProductID = 76
SET @Sporttype = 159
SET @Bettype = 3151

--ProductSettingDetail
IF EXISTS (
	SELECT 1 
	FROM ProductSettingDetail WITH (NOLOCK)
	WHERE RealProductID = @RealProductID
)
BEGIN
	RAISERROR('This RealProductID has been used.', 16, 1)
END
ELSE
BEGIN
	INSERT INTO ProductSettingDetail(SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, ProductSettingID, Parent_ProductSettingID, Child_DisplayOrder, SubType)
	VALUES
	(6, @Sporttype, @Bettype, 0, @ProductID, NULL, NULL, NULL, NULL, NULL, 2, 4, 1, NULL, @RealProductID, NULL, 244, NULL, NULL, NULL) --Win Loss Limit
	INSERT INTO ProductSettingDetail(SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, ProductSettingID, Parent_ProductSettingID, Child_DisplayOrder, SubType)
	VALUES
	(13, @Sporttype, @Bettype, 0, @ProductID, NULL, NULL, 1, 0, 0, 2, 1, 1, NULL, @RealProductID, NULL, 245, NULL, NULL, NULL) --Product Status
	INSERT INTO ProductSettingDetail(SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, ProductSettingID, Parent_ProductSettingID, Child_DisplayOrder, SubType)
	VALUES
	(7, @Sporttype, @Bettype, 0, @ProductID, NULL, NULL, NULL, NULL, NULL, 2, 6, 1, NULL, @RealProductID, NULL, 246, NULL, NULL, NULL) --Stake Level
	INSERT INTO ProductSettingDetail(SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, ProductSettingID, Parent_ProductSettingID, Child_DisplayOrder, SubType)
	VALUES
	(18, @Sporttype, @Bettype, 0, @ProductID, 90, NULL, NULL, NULL, NULL, 2, 3, 1, NULL, @RealProductID, NULL, 247, NULL, NULL, NULL) --Position Taking
	INSERT INTO ProductSettingDetail(SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, ProductSettingID, Parent_ProductSettingID, Child_DisplayOrder, SubType)
	VALUES
	(19, @Sporttype, @Bettype, 0, @ProductID, NULL, 0.005, NULL, NULL, NULL, 2, 2, 1, 0.0005, @RealProductID, NULL, 248, NULL, NULL, NULL) --Commission
END

--ProductStatusProfile
IF EXISTS(
	SELECT 1
	FROM ProductStatusProfile WITH (NOLOCK)
	WHERE Sporttype = @Sporttype AND Bettype = @Bettype
)
BEGIN
	RAISERROR('This SportType and BetType have been used', 16, 1)
END
ELSE
BEGIN
	INSERT INTO ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
	VALUES
	(@Sporttype, @Bettype, 42)
END

