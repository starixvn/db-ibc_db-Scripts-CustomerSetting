/*
    Created: 20180123@Vicky
    Task: Insert product profile for Basketball
    DB: DBTXN/bodb02
*/

IF NOT EXISTS(SELECT 1 FROM bettype WHERE typeid IN (2801,2802,2803,2804,2805,2806,2807,2808,2809,2811,2812))
BEGIN
	INSERT INTO bettype (typeid,typenamee,ParentTypeid,DisplayedTypeID)
	VALUES (2801,'Match Winner',2801,2801),
		   (2802,'1H Winner',2802,2802),
		   (2803,'Over/Under',2803,2803),
		   (2804,'1H Over/Under',2804,2804),		   
		   (2805,'Handicap',2805,2805),
	       (2806,'1H Handicap',2806,2806),
	       (2807,'Winning Margin 6 Way',2807,2807),
	       (2808,'1H Winning Margin 7 Way',2808,2808),
	       (2809,'FT Race To X Points',2809,2809),
	       --(2810,'Highest Scoring Quarter',2810,2810),
	       (2811,'Home Team Over/Under',2811,2811),
	       (2812,'Away Team Over/Under',2812,2812)
END	 


IF NOT EXISTS(SELECT 1 FROM [SportBettypeMatrix] WHERE SportType = 193)
BEGIN
	INSERT INTO SportBettypeMatrix (SportType, BetType, IsLive, ProductID, [Enabled], IsTest, EventType, SubProduct, RefTable)
	VALUES                                            (193      , 2801   , 0     , 193      , 1        , 1     , 1        , ''        , 0       )  
END


UPDATE TABLE sports SET SportName='Virtual Soccer World Cup' WHERE SportType=192




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
