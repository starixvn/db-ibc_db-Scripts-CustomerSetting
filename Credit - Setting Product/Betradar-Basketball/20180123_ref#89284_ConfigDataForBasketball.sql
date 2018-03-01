/*
	Created: 20180123@Vicky
	Task: Insert product profile for Virtual Basketball
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



INSERT INTO Sport_Bettype_Reference_Setting
(SportType, BetType, IsLicensee, isLive, Site, IsActive, SportTypeRefPT, BetTypeRefPT, isLivePT, TablePT,             StructureVerPT, SportTypeRefBetSetting, BetTypeRefBetSetting, TableBetSetting,           StructureVerBetSetting)
VALUES
(193,       2801,    0,          0,      'All', 0,       193,            2801,          0, 'CustPTSetting3rd_member', 'DCS',            193,                    2801,              'CustBetSetting3rd_Member',      'DCS'),
(193,       2802,    0,          0,      'All', 0,       193,            2801,          0, 'CustPTSetting3rd_member', 'DCS',            193,                    2801,              'CustBetSetting3rd_Member',      'DCS'),
(193,       2803,    0,          0,      'All', 0,       193,            2801,          0, 'CustPTSetting3rd_member', 'DCS',            193,                    2801,              'CustBetSetting3rd_Member',      'DCS'),
(193,       2804,    0,          0,      'All', 0,       193,            2801,          0, 'CustPTSetting3rd_member', 'DCS',            193,                    2801,              'CustBetSetting3rd_Member',      'DCS'),
(193,       2805,    0,          0,      'All', 0,       193,            2801,          0, 'CustPTSetting3rd_member', 'DCS',            193,                    2801,              'CustBetSetting3rd_Member',      'DCS'),
(193,       2806,    0,          0,      'All', 0,       193,            2801,          0, 'CustPTSetting3rd_member', 'DCS',            193,                    2801,              'CustBetSetting3rd_Member',      'DCS'),
(193,       2807,    0,          0,      'All', 0,       193,            2801,          0, 'CustPTSetting3rd_member', 'DCS',            193,                    2801,              'CustBetSetting3rd_Member',      'DCS'),
(193,       2808,    0,          0,      'All', 0,       193,            2801,          0, 'CustPTSetting3rd_member', 'DCS',            193,                    2801,              'CustBetSetting3rd_Member',      'DCS'),
(193,       2809,    0,          0,      'All', 0,       193,            2801,          0, 'CustPTSetting3rd_member', 'DCS',            193,                    2801,              'CustBetSetting3rd_Member',      'DCS'),
(193,       2811,    0,          0,      'All', 0,       193,            2801,          0, 'CustPTSetting3rd_member', 'DCS',            193,                    2801,              'CustBetSetting3rd_Member',      'DCS'),
(193,       2812,    0,          0,      'All', 0,       193,            2801,          0, 'CustPTSetting3rd_member', 'DCS',            193,                    2801,              'CustBetSetting3rd_Member',      'DCS'),
(193,       2799,    0,          0,      'All', 0,       193,            2801,          0, 'CustPTSetting3rd_member', 'DCS',            199,                    2799,              'CustBetSetting3rd_Member',      'DCS'),

(193,       2801,    1,          0,      'All', 0,       190,            2801,          0, 'Dep_CustPTSetting_member', 'DCS',           193,                    2801,              'Dep_CustBetSetting_Member',     'DCS'),
(193,       2802,    1,          0,      'All', 0,       190,            2801,          0, 'Dep_CustPTSetting_member', 'DCS',           193,                    2801,              'Dep_CustBetSetting_Member',     'DCS'),
(193,       2803,    1,          0,      'All', 0,       190,            2801,          0, 'Dep_CustPTSetting_member', 'DCS',           193,                    2801,              'Dep_CustBetSetting_Member',     'DCS'),
(193,       2804,    1,          0,      'All', 0,       190,            2801,          0, 'Dep_CustPTSetting_member', 'DCS',           193,                    2801,              'Dep_CustBetSetting_Member',     'DCS'),
(193,       2805,    1,          0,      'All', 0,       190,            2801,          0, 'Dep_CustPTSetting_member', 'DCS',           193,                    2801,              'Dep_CustBetSetting_Member',     'DCS'),
(193,       2806,    1,          0,      'All', 0,       190,            2801,          0, 'Dep_CustPTSetting_member', 'DCS',           193,                    2801,              'Dep_CustBetSetting_Member',     'DCS'),
(193,       2807,    1,          0,      'All', 0,       190,            2801,          0, 'Dep_CustPTSetting_member', 'DCS',           193,                    2801,              'Dep_CustBetSetting_Member',     'DCS'),
(193,       2808,    1,          0,      'All', 0,       190,            2801,          0, 'Dep_CustPTSetting_member', 'DCS',           193,                    2801,              'Dep_CustBetSetting_Member',     'DCS'),
(193,       2809,    1,          0,      'All', 0,       190,            2801,          0, 'Dep_CustPTSetting_member', 'DCS',           193,                    2801,              'Dep_CustBetSetting_Member',     'DCS'),
(193,       2811,    1,          0,      'All', 0,       190,            2801,          0, 'Dep_CustPTSetting_member', 'DCS',           193,                    2801,              'Dep_CustBetSetting_Member',     'DCS'),
(193,       2812,    1,          0,      'All', 0,       190,            2801,          0, 'Dep_CustPTSetting_member', 'DCS',           193,                    2801,              'Dep_CustBetSetting_Member',     'DCS'),
(193,       2799,    1,          0,      'All', 0,       190,            2801,          0, 'Dep_CustPTSetting_member', 'DCS',           199,                    2799,              'Dep_CustBetSetting_Member',     'DCS')


