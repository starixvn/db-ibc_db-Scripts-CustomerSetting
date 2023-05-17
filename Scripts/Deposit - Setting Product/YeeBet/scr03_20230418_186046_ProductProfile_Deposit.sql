/*<info serverAlias="DBCUST-CustDB"></info>*/
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
IF EXISTS(
	SELECT 1
	FROM Dep_ProductSetting WITH (NOLOCK)
	WHERE ProductID = @ProductID
)
BEGIN
	RAISERROR('This ProductID has been used.', 16, 1)
END
ELSE
BEGIN
	INSERT INTO Dep_ProductSetting(ProductSettingID, ProductID, SettingType, TemplateID, DisplayOrder, SettingLevel)
	VALUES
		(165, @ProductID, 4, 0, 1, 1) --Product Status
	INSERT INTO Dep_ProductSetting(ProductSettingID, ProductID, SettingType, TemplateID, DisplayOrder, SettingLevel)
	VALUES
		(166, @ProductID, 1, 0,	2, 1) --Position Taking
	INSERT INTO Dep_ProductSetting(ProductSettingID, ProductID, SettingType, TemplateID, DisplayOrder, SettingLevel)
	VALUES
		(167, @ProductID, 7, 0, 3, 3) --Stake Level
END

--Dep_ProductSetttingDetail
IF EXISTS(
	SELECT 1
	FROM Dep_ProductSettingDetail WITH (NOLOCK)
	WHERE SportType = @Sporttype AND BetType = @Bettype
)
BEGIN
	RAISERROR('This SportType and BetType have been used.', 16, 1)
END
ELSE
BEGIN
INSERT INTO Dep_ProductSettingDetail(ProductSettingID, SportType, BetType, IsLive, MaxDefaultValue, SettingStatus, MinDefaultValue, IsApplyBA)
VALUES
	(165, @Sporttype, @Bettype, 0, 0, 1, NULL, 0),
	(166, @Sporttype, @Bettype, 0, 0, 1, NULL, 0),
	(167, @Sporttype, @Bettype, 0, 0, 1, NULL, 0)
END

--Dep_ProductStatusProfile
IF EXISTS(
	SELECT 1
	FROM Dep_ProductStatusProfile WITH (NOLOCK)
	WHERE Sporttype = @Sporttype AND Bettype = @Bettype
)
BEGIN
	RAISERROR('This SportType and BetType have been used.', 16, 1)
END
ELSE
BEGIN
	INSERT INTO Dep_ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
	VALUES
		(@Sporttype, @Bettype, 37)
END