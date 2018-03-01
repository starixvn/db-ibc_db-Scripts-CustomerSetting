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

INSERT INTO Sport_Bettype_Reference_Setting
(SportType, BetType, IsLicensee, isLive, Site, IsActive, SportTypeRefPT, BetTypeRefPT, isLivePT, TablePT,             StructureVerPT, SportTypeRefBetSetting, BetTypeRefBetSetting, TableBetSetting,           StructureVerBetSetting)
VALUES
(192,       2701,    0,          0,      'All', 0,       192,            2701,          0, 'CustPTSetting3rd_member', 'DCS',            192,                    2701,              'CustBetSetting3rd_Member',      'DCS'),
(192,       2702,    0,          0,      'All', 0,       192,            2701,          0, 'CustPTSetting3rd_member', 'DCS',            192,                    2701,              'CustBetSetting3rd_Member',      'DCS'),
(192,       2703,    0,          0,      'All', 0,       192,            2701,          0, 'CustPTSetting3rd_member', 'DCS',            192,                    2701,              'CustBetSetting3rd_Member',      'DCS'),
(192,       2704,    0,          0,      'All', 0,       192,            2701,          0, 'CustPTSetting3rd_member', 'DCS',            192,                    2701,              'CustBetSetting3rd_Member',      'DCS'),
(192,       2705,    0,          0,      'All', 0,       192,            2701,          0, 'CustPTSetting3rd_member', 'DCS',            192,                    2701,              'CustBetSetting3rd_Member',      'DCS'),
(192,       2706,    0,          0,      'All', 0,       192,            2701,          0, 'CustPTSetting3rd_member', 'DCS',            192,                    2701,              'CustBetSetting3rd_Member',      'DCS'),
(192,       2707,    0,          0,      'All', 0,       192,            2701,          0, 'CustPTSetting3rd_member', 'DCS',            192,                    2701,              'CustBetSetting3rd_Member',      'DCS'),
(192,       2799,    0,          0,      'All', 0,       192,            2701,          0, 'CustPTSetting3rd_member', 'DCS',            199,                    2799,              'CustBetSetting3rd_Member',      'DCS'),

(192,       2701,    1,          0,      'All', 0,       190,            2701,          0, 'Dep_CustPTSetting_member', 'DCS',           192,                    2701,              'Dep_CustBetSetting_Member',     'DCS'),
(192,       2702,    1,          0,      'All', 0,       190,            2701,          0, 'Dep_CustPTSetting_member', 'DCS',           192,                    2701,              'Dep_CustBetSetting_Member',     'DCS'),
(192,       2703,    1,          0,      'All', 0,       190,            2701,          0, 'Dep_CustPTSetting_member', 'DCS',           192,                    2701,              'Dep_CustBetSetting_Member',     'DCS'),
(192,       2704,    1,          0,      'All', 0,       190,            2701,          0, 'Dep_CustPTSetting_member', 'DCS',           192,                    2701,              'Dep_CustBetSetting_Member',     'DCS'),
(192,       2705,    1,          0,      'All', 0,       190,            2701,          0, 'Dep_CustPTSetting_member', 'DCS',           192,                    2701,              'Dep_CustBetSetting_Member',     'DCS'),
(192,       2706,    1,          0,      'All', 0,       190,            2701,          0, 'Dep_CustPTSetting_member', 'DCS',           192,                    2701,              'Dep_CustBetSetting_Member',     'DCS'),
(192,       2707,    1,          0,      'All', 0,       190,            2701,          0, 'Dep_CustPTSetting_member', 'DCS',           192,                    2701,              'Dep_CustBetSetting_Member',     'DCS'),
(192,       2799,    1,          0,      'All', 0,       190,            2701,          0, 'Dep_CustPTSetting_member', 'DCS',           199,                    2799,              'Dep_CustBetSetting_Member',     'DCS')

