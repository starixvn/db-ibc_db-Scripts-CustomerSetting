/*
	Created: 20180123@Vicky
	Task: Insert product profile for Basketball
	DB: DBCUST/CustDB
*/

DECLARE @productId TINYINT
SET @productId = 5


INSERT INTO ProductSettingDetail(SettingType, SportType, BetType, IsLive, ProductID , MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus)
VALUES                          (1          , 193      , 2801   , 0     , @productId, 90   , NULL       , NULL  , NULL    , NULL      , 2           , 3           , 1            ), --position taking
                                (2          , 193      , 2801   , 0     , @productId, NULL , NULL       , NULL  , NULL    , NULL      , 2           , 2           , 1            ), --bet setting
                                (6          , 180      , 1201   , 0     , @productId, NULL , NULL       , NULL  , NULL    , NULL      , 1           , 4           , 1            )  --member win loss limit setting


                                
INSERT INTO ProductBetSetting(SportType, BetType, Currency  , MinBet, IsDep, MaxBet, MaxPerMatch)
SELECT                        193      , 2801   , exchangeid, 0     , 0    , 0     , 0
FROM exchange



INSERT INTO [LossLimit_GlobalSetting] (ProductId, ExchangeId, MinLossLimit, DefaultLossLimit)
SELECT                                 5        , ExchangeId, MinLossLimit, DefaultLossLimit
FROM [LossLimit_GlobalSetting] WHERE ProductId = 21



INSERT INTO [ProductLaunchedSiteCurrency]
       (SiteID, Currency, SportType, IsLaunched, IsTest)
SELECT  siteId, 0       , 193      , 0         , 1
FROM   [site]
WHERE IsLicensee = 0 AND isActive = 1



INSERT INTO ProductSettingSystemDisplay(SystemID, ProductID, SettingType, DisplayMode)
VALUES                                 (5       , 5        , 6          , 3)
