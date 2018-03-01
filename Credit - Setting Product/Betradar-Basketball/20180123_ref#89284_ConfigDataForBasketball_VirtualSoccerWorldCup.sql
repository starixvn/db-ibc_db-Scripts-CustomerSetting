/*
	Created: 20180226@Vicky
	Task: Insert product profile for Virtual Soccer World Cup
	DB: DBCUST/CustDB
*/

DECLARE @productId TINYINT
SET @productId = 5


------------------Virtual Soccer World Cup----------------------------------------------
INSERT INTO ProductSettingDetail(SettingType, SportType, BetType, IsLive, ProductID , MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus)
VALUES
                                (1          , 192      , 2701   , 0     , @productId, 90   , NULL       , NULL  , NULL    , NULL      , 2           , 3           , 1            ), --position taking
                                (2          , 192      , 2701   , 0     , @productId, NULL , NULL       , NULL  , NULL    , NULL      , 2           , 2           , 1            ) --bet setting

                                
INSERT INTO ProductBetSetting(SportType, BetType, Currency  , MinBet, IsDep, MaxBet, MaxPerMatch)
SELECT                        192      , 2701   , exchangeid, 0     , 0    , 0     , 0
FROM exchange


INSERT INTO [ProductLaunchedSiteCurrency]
       (SiteID, Currency, SportType, IsLaunched, IsTest)
SELECT  siteId, 0       , 192      , 0         , 1
FROM   [site]
WHERE IsLicensee = 0 AND isActive = 1

