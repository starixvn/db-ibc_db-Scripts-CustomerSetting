/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20230704
	Task:  Insert new Product profile for Virtual Sports 3 - Deposit [RedmineID: #190952]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @ProductID SMALLINT,
		@Sporttype SMALLINT,
		@Bettype SMALLINT
SET @ProductID = 77
SET @Sporttype = 178
SET @Bettype = 5302

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
		(168, @ProductID, 4, 0, 1, 1) --Product Status
	INSERT INTO Dep_ProductSetting(ProductSettingID, ProductID, SettingType, TemplateID, DisplayOrder, SettingLevel)
	VALUES
		(169, @ProductID, 1, 0,	2, 1) --Position Taking
	INSERT INTO Dep_ProductSetting(ProductSettingID, ProductID, SettingType, TemplateID, DisplayOrder, SettingLevel)
	VALUES
		(170, @ProductID, 11, 0, 3, 2) --Bet Setting
END

--Dep_ProductSettingDetail
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
	(168, @Sporttype, @Bettype, 0, 0, 1, NULL, 0),
	(169, @Sporttype, @Bettype, 0, 0, 1, NULL, 0),
	(170, @Sporttype, @Bettype, 0, 0, 1, NULL, 0)
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
		(@Sporttype, @Bettype, 38)
END