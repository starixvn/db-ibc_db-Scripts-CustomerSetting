/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20230704
	Task:  Insert global settings for Virtual Sports 3 - Deposit [RedmineID: #190952]
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
--Delete old settings
DELETE ps
FROM Dep_ProductSetting ps WITH (ROWLOCK)
WHERE ProductID = @ProductID
	AND ProductSettingID IN (168, 169, 170)

--Insert
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
		(170, @ProductID, 2, 0, 3, 1) --Bet Setting
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

--Dep_ProductBetSetting
CREATE TABLE #tempBetSetting(
	ExchangeId TINYINT,
	Currency NVARCHAR(20),
	MinBet	MONEY,
	MaxBet	MONEY,
	MaxPerMatch	MONEY
)

INSERT INTO #tempBetSetting(ExchangeId, Currency, MinBet, MaxBet, MaxPerMatch)
VALUES (13, 'RMB', 5, 3000, 10000),
		(15, 'IN', 10, 5000, 15000),
		(51, 'INH', 10, 10000, 50000),
		(7, 'DON', 10000, 10000000, 50000000),
		(2, 'RM', 10, 1500, 5000),
		(4, 'TB', 30, 15000, 50000),
		(32, 'JPY', 10, 50000, 150000),
		(45, 'Won', 1000, 600000, 1500000),
		(84, 'COP', 1000, 600000, 1500000),
		(96, 'USDT', 1, 500, 1500),
		(3, 'US$', 1, 500, 1500),
		(6, 'EURO', 1, 500, 1500),
		(9, 'AUD', 5, 3000, 10000),
		(12, 'GBP', 5, 3000, 10000),
		(41, 'CHF', 5, 3000, 10000),
		(46, 'BND', 5, 1500, 5000),
		(52, 'DKK', 5, 3000, 10000),
		(53, 'SEK', 5, 3000, 10000),
		(54, 'NOK', 5, 3000, 10000),
		(55, 'RUB', 5, 3000, 10000),
		(56, 'PLN', 5, 3000, 10000),
		(61, 'INR', 50, 30000, 100000),
		(94, 'MK', 5, 3000, 10000),
		(70, 'MKK', 5, 3000, 10000),
		(71, 'KHR', 5, 3000, 10000),
		(93, 'LAK', 1, 5000, 20000),
		(97, 'BDT', 50, 50000, 200000),
		(121, 'PKR', 100, 60000, 200000),
		(42, 'PE', 50, 22500, 75000),
		(82, 'BRL', 12, 1800, 6000),
		(122, 'KZT', 300, 200000, 700000),
		(123, 'NPR', 80, 48000, 160000),
		(133, 'TND', 2.5, 1500, 5000),
		(90, 'AED', 9, 1500, 4500),
		(134, 'ZMW', 40, 6000, 19000),
		(135, 'TZS', 5300, 800000, 2650000),
		(79, 'KES', 265, 40000, 135000),
		(50, 'CAN', 2, 3000, 10000)

INSERT INTO Dep_ProductBetSetting(Sporttype, Bettype, Currency, MinBet, MaxBet, MaxPerMatch, DefaultMinBet, DefaultMaxBet, DefaultMaxPerMatch)
SELECT @sporttype, @bettype, ExchangeId, MinBet, MaxBet, MaxPerMatch, 0 AS DefaultMinBet, 0 AS DefaultMaxBet, 0 AS DefaultMaxPerMatch 
FROM #tempBetSetting t
WHERE NOT EXISTS(
	SELECT TOP 1 1
	FROM Dep_ProductBetSetting WITH (NOLOCK)
	WHERE Sporttype = @sporttype AND Bettype = @bettype AND Currency = t.ExchangeId
)

DROP TABLE #tempBetSetting