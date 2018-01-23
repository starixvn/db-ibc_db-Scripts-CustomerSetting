/*
	Created: 20180123@Vicky
	Task: Insert product profile for Basketball
	DB: DBCUST/CustDB
*/

DECLARE @productId TINYINT
SET @productId = 5

------------------------START Insert for table ProductSettingDetail--------------------
--Insert for sporttype = 193
INSERT INTO ProductSettingDetail(SettingType, SportType, BetType, IsLive, ProductID , MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus)
VALUES                          (1          , 193      , 2801   , 0     , @productId, 90   , NULL       , NULL  , NULL    , NULL      , 2           , 3           , 0            ), --position taking
                                (2          , 193      , 2801   , 0     , @productId, NULL , NULL       , NULL  , NULL    , NULL      , 2           , 2           , 0            ), --bet setting
                                (6          , 193      , 2801   , 0     , @productId, NULL , NULL       , NULL  , NULL    , NULL      , 1           , 4           , 0            )  --member win loss limit setting
                                
--Insert for sporttype  is 199                                
IF NOT EXISTS(SELECT 1 FROM ProductSettingDetail WHERE SettingType = 2 AND SportType = 199 AND BetType = 2799)
BEGIN
	INSERT INTO ProductSettingDetail(SettingType, SportType, BetType, IsLive, ProductID , MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus)
VALUES                              (2          , 199      , 2799   , 0     , @productId, NULL , NULL       , NULL  , NULL    , NULL      , 2           , 2           , 0            )
END
------------------------END Insert for table ProductSettingDetail--------------------




------------------------START Insert for table ProductBetSetting--------------------
--Insert for sporttype = 193
INSERT INTO ProductBetSetting(SportType, BetType, Currency  , MinBet, IsDep, MaxBet, MaxPerMatch)
SELECT                        193      , 2701   , exchangeid, 0     , 0    , 0     , 0
FROM exchange

--Insert for sporttype = 199
IF NOT EXISTS(SELECT 1 FROM ProductBetSetting WHERE SportType = 199 AND BetType = 2799)
BEGIN
	INSERT INTO ProductBetSetting(SportType, BetType, Currency  , MinBet, IsDep, MaxBet, MaxPerMatch)
	SELECT                        199      , 2799   , exchangeid, 0     , 0    , 0     , 0
	FROM exchange
END
------------------------END Insert for table ProductBetSetting--------------------


------------------------START Insert for global setting of loss limit--------------------
INSERT INTO [LossLimit_GlobalSetting] (ProductId, ExchangeId, MinLossLimit, DefaultLossLimit)
SELECT 5, exchangeid, MinLossLimit,DefaultLossLimit
FROM [LossLimit_GlobalSetting] WHERE ProductId=21
------------------------START Insert for global setting of loss limit--------------------

  
INSERT INTO [ProductLaunchedSiteCurrency]
       (SiteID, Currency, SportType, IsLaunched, IsTest)
SELECT  siteId, 0       , 193      , 0        , 1
FROM   [site]
WHERE IsLicensee = 0 AND isActive = 1

