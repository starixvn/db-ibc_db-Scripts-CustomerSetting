/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20240405@Winfred
	DB: DBCUST/CustDB
	Task:  [NAP CM] Spread Mng - Support for user to upload Spread setting
	Revisions:
		- 20240405@Winfred: [NAP CM] Spread Mng - Support for user to upload Spread setting [RedmineID: #203435] 
*/
--===================================================================================
	DECLARE @CustomerClass VARCHAR(MAX) = '200,203,204,205,2000,2001,2002,2003,2004,2005, 2100,2101,2102,2103,2104,2105,2200,2201,2202,2203,2204,2205,2303,2304,2305,2403,2404,2405'
	CREATE TABLE #CCSpread(PolicyID INT, PolicyTitle VARCHAR(500), siteID VARCHAR(MAX), CurrencyID INT, platform TINYINT, SportType SMALLINT, spread DECIMAL(19,2), isFinished BIT DEFAULT(0) )
		
	INSERT INTO #CCSpread(PolicyID, PolicyTitle, siteID, CurrencyID, Platform, SportType, Spread)
	SELECT 1 AS PolicyID, 'BK-INH-W88-LowProfit' AS PolicyTitle, '94' AS siteID, 51 AS CurrencyID, 3 AS Platform, 2 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 2 AS PolicyID, 'BK-Won-alog-LowProfit' AS PolicyTitle, '36' AS siteID, 45 AS CurrencyID, 3 AS Platform, 2 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 3 AS PolicyID, 'BK-IN-Lic-LowProfit' AS PolicyTitle, '125,171' AS siteID, 15 AS CurrencyID, 1 AS Platform, 2 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 4 AS PolicyID, 'BK-INH-Lic-LowProfit' AS PolicyTitle, '291,482,536,884,282' AS siteID, 51 AS CurrencyID, 1 AS Platform, 2 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 5 AS PolicyID, 'BK-INH2-FB88CV-LowProfit' AS PolicyTitle, '755' AS siteID, 125 AS CurrencyID, 1 AS Platform, 2 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 6 AS PolicyID, 'BK-RM-Lic-LowProfit' AS PolicyTitle, '499,171,354,302,282' AS siteID, 2 AS CurrencyID, 1 AS Platform, 2 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 7 AS PolicyID, 'BK-RMB-Lic-LowProfit' AS PolicyTitle, '182,36,560,225,245,354,901,711,290' AS siteID, 13 AS CurrencyID, 1 AS Platform, 2 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 8 AS PolicyID, 'BK-RMB2-BSSB168CV-LowProfit' AS PolicyTitle, '758' AS siteID, 124 AS CurrencyID, 1 AS Platform, 2 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 9 AS PolicyID, 'BK-TB-Lic-LowProfit' AS PolicyTitle, '354,565' AS siteID, 4 AS CurrencyID, 1 AS Platform, 2 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 10 AS PolicyID, 'BK-US$-winwinsw-LowProfit' AS PolicyTitle, '1134' AS siteID, 3 AS CurrencyID, 1 AS Platform, 2 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 11 AS PolicyID, 'BK-Won-Lic-LowProfit' AS PolicyTitle, '30,1354' AS siteID, 45 AS CurrencyID, 1 AS Platform, 2 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 12 AS PolicyID, 'BK-RMB-JDYGaming-LowProfit' AS PolicyTitle, '709' AS siteID, 13 AS CurrencyID, 5 AS Platform, 2 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 13 AS PolicyID, 'BK-IN-Lic-LowProfit' AS PolicyTitle, '36,163,885,788,486' AS siteID, 15 AS CurrencyID, 2 AS Platform, 2 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 14 AS PolicyID, 'BK-INH-Lic-LowProfit' AS PolicyTitle, '333,583,482,767,884' AS siteID, 51 AS CurrencyID, 2 AS Platform, 2 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 15 AS PolicyID, 'BK-INR-alog-LowProfit' AS PolicyTitle, '36' AS siteID, 61 AS CurrencyID, 2 AS Platform, 2 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 16 AS PolicyID, 'BK-RM-Lic-LowProfit' AS PolicyTitle, '354,448' AS siteID, 2 AS CurrencyID, 2 AS Platform, 2 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 17 AS PolicyID, 'BK-RMB-Lic-LowProfit' AS PolicyTitle, '364,31,207,1145,724,221,1084,171,274,245,44,176,452,709,419,711,504,304,1040,806,669,924,253,315,686,952' AS siteID, 
		   13 AS CurrencyID, 2 AS Platform, 2 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 18 AS PolicyID, 'BK-RMB2-Lic-LowProfit' AS PolicyTitle, '735,739,766,879' AS siteID, 124 AS CurrencyID, 2 AS Platform, 2 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 19 AS PolicyID, 'BK-TB-Lic-LowProfit' AS PolicyTitle, '182,275,583,639,918' AS siteID, 4 AS CurrencyID, 2 AS Platform, 2 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 20 AS PolicyID, 'BK-US$-W88-LowProfit' AS PolicyTitle, '94' AS siteID, 3 AS CurrencyID, 2 AS Platform, 2 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 21 AS PolicyID, 'BK-Won-Lic-LowProfit' AS PolicyTitle, '30,993,333,94' AS siteID, 45 AS CurrencyID, 2 AS Platform, 2 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 22 AS PolicyID, 'BK-RMB-livv88sw-LowProfit' AS PolicyTitle, '591' AS siteID, 13 AS CurrencyID, 3 AS Platform, 2 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 23 AS PolicyID, 'BK-IN-Lic-LowProfit' AS PolicyTitle, '165,700,198,676,104,556,486,282' AS siteID, 15 AS CurrencyID, 1 AS Platform, 2 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 24 AS PolicyID, 'BK-INH-Lic-LowProfit' AS PolicyTitle, '30,191,125,325,1033,555,171,1168,333,419,887,629,863,483,454,722,633,1082,336,1102,767,919' AS siteID, 
		   51 AS CurrencyID, 1 AS Platform, 2 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 25 AS PolicyID, 'BK-PE2-Lic-LowProfit' AS PolicyTitle, '926,865' AS siteID, 128 AS CurrencyID, 1 AS Platform, 2 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 26 AS PolicyID, 'BK-RM-Lic-LowProfit' AS PolicyTitle, '30,145,542,629,448,507' AS siteID, 2 AS CurrencyID, 1 AS Platform, 2 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 27 AS PolicyID, 'BK-RMB-Lic-LowProfit' AS PolicyTitle, '30,418,191,1244,317,133,364,31,1077,207,1145,215,177,724,261,221,888,44,204,165,333,713,419,591,504,297,629,448,1040,806,440,253,536,1026,714,315,94,437,416,377,464,884,658,710,791,477' AS siteID, 
		   13 AS CurrencyID, 1 AS Platform, 2 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 28 AS PolicyID, 'BK-RMB2-Lic-LowProfit' AS PolicyTitle, '737,733,735,738,763,739,762,792,749' AS siteID, 124 AS CurrencyID, 1 AS Platform, 2 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 29 AS PolicyID, 'BK-TB-Lic-LowProfit' AS PolicyTitle, '125,499,1108,639,448,454,712,104,836,918,507,1152,282' AS siteID, 4 AS CurrencyID, 1 AS Platform, 2 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 30 AS PolicyID, 'BK-US$-GamingSoft-LowProfit' AS PolicyTitle, '171' AS siteID, 3 AS CurrencyID, 1 AS Platform, 2 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 31 AS PolicyID, 'BK-USDT-Lic-LowProfit' AS PolicyTitle, '575,872,561,336,94,507,960' AS siteID, 96 AS CurrencyID, 1 AS Platform, 2 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 32 AS PolicyID, 'BK-USDT2-W88CV-LowProfit' AS PolicyTitle, '744' AS siteID, 206 AS CurrencyID, 1 AS Platform, 2 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 33 AS PolicyID, 'BK-Won-Lic-LowProfit' AS PolicyTitle, '418,36,942,993,485,171,333,576' AS siteID, 45 AS CurrencyID, 1 AS Platform, 2 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 34 AS PolicyID, 'BK-Won2-W88CV-LowProfit' AS PolicyTitle, '744' AS siteID, 130 AS CurrencyID, 1 AS Platform, 2 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 35 AS PolicyID, 'BK-RMB2-Xinli2CV-LowProfit' AS PolicyTitle, '792' AS siteID, 124 AS CurrencyID, 5 AS Platform, 2 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 36 AS PolicyID, 'BK-BDT-Baji-LowProfit' AS PolicyTitle, '589' AS siteID, 97 AS CurrencyID, 2 AS Platform, 2 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 37 AS PolicyID, 'BK-IN-zt828-LowProfit' AS PolicyTitle, '282' AS siteID, 15 AS CurrencyID, 2 AS Platform, 2 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 38 AS PolicyID, 'BK-INH-ZhiFeng176-LowProfit' AS PolicyTitle, '934' AS siteID, 51 AS CurrencyID, 2 AS Platform, 2 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 39 AS PolicyID, 'BK-INR-Lic-LowProfit' AS PolicyTitle, '839,377' AS siteID, 61 AS CurrencyID, 2 AS Platform, 2 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 40 AS PolicyID, 'BK-RM-W88-LowProfit' AS PolicyTitle, '94' AS siteID, 2 AS CurrencyID, 2 AS Platform, 2 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 41 AS PolicyID, 'BK-RMB-Lic-LowProfit' AS PolicyTitle, '1008,1244,1077,853,177,888,848,713,901,591,769,1078,1162,927,416,579,767,1148,658,710,823' AS siteID, 
		   13 AS CurrencyID, 2 AS Platform, 2 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 42 AS PolicyID, 'BK-RMB2-Lic-LowProfit' AS PolicyTitle, '734,762' AS siteID, 124 AS CurrencyID, 2 AS Platform, 2 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 43 AS PolicyID, 'BK-TB-Lic-LowProfit' AS PolicyTitle, '125,712,836,1152' AS siteID, 4 AS CurrencyID, 2 AS Platform, 2 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 44 AS PolicyID, 'BK-US$-ZF026-LowProfit' AS PolicyTitle, '884' AS siteID, 3 AS CurrencyID, 2 AS Platform, 2 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 45 AS PolicyID, 'BK-USDT-Lic-LowProfit' AS PolicyTitle, '575,872,561,94,507' AS siteID, 96 AS CurrencyID, 2 AS Platform, 2 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 46 AS PolicyID, 'BK-USDT2-W88CV-LowProfit' AS PolicyTitle, '744' AS siteID, 206 AS CurrencyID, 2 AS Platform, 2 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 47 AS PolicyID, 'BK-Won-Lic-LowProfit' AS PolicyTitle, '942,485,171,354,576' AS siteID, 45 AS CurrencyID, 2 AS Platform, 2 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 48 AS PolicyID, 'BK-Won2-W88CV-LowProfit' AS PolicyTitle, '744' AS siteID, 130 AS CurrencyID, 2 AS Platform, 2 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 49 AS PolicyID, 'BK-RMB-ZhiFeng032-LowProfit' AS PolicyTitle, '477' AS siteID, 13 AS CurrencyID, 4 AS Platform, 2 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 1 AS PolicyID, 'ES-Won-alog-LowProfit' AS PolicyTitle, '36' AS siteID, 45 AS CurrencyID, 3 AS Platform, 43 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 2 AS PolicyID, 'ES-IN-Macaubet-LowProfit' AS PolicyTitle, '53' AS siteID, 15 AS CurrencyID, 1 AS Platform, 43 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 3 AS PolicyID, 'ES-INH-Lic-LowProfit' AS PolicyTitle, '30,325,31,555,241,291,1168,354,813,483,482,722,633,336,94,767,282' AS siteID, 
		   51 AS CurrencyID, 1 AS Platform, 43 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 4 AS PolicyID, 'ES-INH2-W88CV-LowProfit' AS PolicyTitle, '744' AS siteID, 125 AS CurrencyID, 1 AS Platform, 43 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 5 AS PolicyID, 'ES-INR-Happy8-LowProfit' AS PolicyTitle, '354' AS siteID, 61 AS CurrencyID, 1 AS Platform, 43 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 6 AS PolicyID, 'ES-PKR-Baji-LowProfit' AS PolicyTitle, '589' AS siteID, 121 AS CurrencyID, 1 AS Platform, 43 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 7 AS PolicyID, 'ES-RM-Lic-LowProfit' AS PolicyTitle, '241,171,354,405,448,507,282' AS siteID, 2 AS CurrencyID, 1 AS Platform, 43 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 8 AS PolicyID, 'ES-RMB-Lic-LowProfit' AS PolicyTitle, '30,364,31,1145,724,888,44,354,204,713,419,711,591,504,297,1040,714,315,437,464,960,710' AS siteID, 
		   13 AS CurrencyID, 1 AS Platform, 43 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 9 AS PolicyID, 'ES-RMB2-Lic-LowProfit' AS PolicyTitle, '763,762' AS siteID, 124 AS CurrencyID, 1 AS Platform, 43 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 10 AS PolicyID, 'ES-TB-Lic-LowProfit' AS PolicyTitle, '813,94,282' AS siteID, 4 AS CurrencyID, 1 AS Platform, 43 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 11 AS PolicyID, 'ES-US$-winwinsw-LowProfit' AS PolicyTitle, '1134' AS siteID, 3 AS CurrencyID, 1 AS Platform, 43 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 12 AS PolicyID, 'ES-USDT-Lic-LowProfit' AS PolicyTitle, '575,94,960' AS siteID, 96 AS CurrencyID, 1 AS Platform, 43 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 13 AS PolicyID, 'ES-Won-Lic-LowProfit' AS PolicyTitle, '30,942,485,171,354,576' AS siteID, 45 AS CurrencyID, 1 AS Platform, 43 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 14 AS PolicyID, 'ES-IN-Lic-LowProfit' AS PolicyTitle, '98,700' AS siteID, 15 AS CurrencyID, 2 AS Platform, 43 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 15 AS PolicyID, 'ES-INH-Lic-LowProfit' AS PolicyTitle, '191,325,177,354,482,344,768,336,904,1102,884,692,282' AS siteID, 51 AS CurrencyID, 2 AS Platform, 43 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 16 AS PolicyID, 'ES-RM-Lic-LowProfit' AS PolicyTitle, '30,36,354,542,448' AS siteID, 2 AS CurrencyID, 2 AS Platform, 43 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 17 AS PolicyID, 'ES-RMB-Lic-LowProfit' AS PolicyTitle, '36,31,1077,764,1145,354,713,419,1078,1050,714,94,377,658' AS siteID, 13 AS CurrencyID, 2 AS Platform, 43 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 18 AS PolicyID, 'ES-RMB2-Lic-LowProfit' AS PolicyTitle, '763,792' AS siteID, 124 AS CurrencyID, 2 AS Platform, 43 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 19 AS PolicyID, 'ES-TB-Lic-LowProfit' AS PolicyTitle, '125,808,813' AS siteID, 4 AS CurrencyID, 2 AS Platform, 43 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 20 AS PolicyID, 'ES-TB2-W88CV-LowProfit' AS PolicyTitle, '744' AS siteID, 126 AS CurrencyID, 2 AS Platform, 43 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 21 AS PolicyID, 'ES-US$-Lic-LowProfit' AS PolicyTitle, '583,448' AS siteID, 3 AS CurrencyID, 2 AS Platform, 43 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 22 AS PolicyID, 'ES-USDT-Lic-LowProfit' AS PolicyTitle, '575,960' AS siteID, 96 AS CurrencyID, 2 AS Platform, 43 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 23 AS PolicyID, 'ES-Won-Lic-LowProfit' AS PolicyTitle, '30,36,942,993,171,576' AS siteID, 45 AS CurrencyID, 2 AS Platform, 43 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 1 AS PolicyID, 'OS-INR-alog-LowProfit' AS PolicyTitle, '36' AS siteID, 61 AS CurrencyID, 3 AS Platform, 99 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 2 AS PolicyID, 'OS-BDT-Lic-LowProfit' AS PolicyTitle, '589,454' AS siteID, 97 AS CurrencyID, 1 AS Platform, 99 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 3 AS PolicyID, 'OS-IN-Lic-LowProfit' AS PolicyTitle, '125,171,104,94,302' AS siteID, 15 AS CurrencyID, 1 AS Platform, 99 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 4 AS PolicyID, 'OS-INH-Lic-LowProfit' AS PolicyTitle, '325,1168,354,333,813,633,336,767,282' AS siteID, 51 AS CurrencyID, 1 AS Platform, 99 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 5 AS PolicyID, 'OS-INH2-FB88CV-LowProfit' AS PolicyTitle, '755' AS siteID, 125 AS CurrencyID, 1 AS Platform, 99 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 6 AS PolicyID, 'OS-INR-Lic-LowProfit' AS PolicyTitle, '30,589,839,454' AS siteID, 61 AS CurrencyID, 1 AS Platform, 99 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 7 AS PolicyID, 'OS-PE2-Lic-LowProfit' AS PolicyTitle, '926,865' AS siteID, 128 AS CurrencyID, 1 AS Platform, 99 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 8 AS PolicyID, 'OS-RM-Lic-LowProfit' AS PolicyTitle, '30,499,241,448,94,507,302,282' AS siteID, 2 AS CurrencyID, 1 AS Platform, 99 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 9 AS PolicyID, 'OS-RMB-Lic-LowProfit' AS PolicyTitle, '364,560,1145,225,354,713,901,711,591,806,253,315,416' AS siteID, 13 AS CurrencyID, 1 AS Platform, 99 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 10 AS PolicyID, 'OS-TB-Lic-LowProfit' AS PolicyTitle, '125,499,645,1108,808,171,375,743,94,565,1152' AS siteID, 4 AS CurrencyID, 1 AS Platform, 99 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 11 AS PolicyID, 'OS-Won-BPLE-LowProfit' AS PolicyTitle, '485' AS siteID, 45 AS CurrencyID, 1 AS Platform, 99 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 12 AS PolicyID, 'OS-RMB-Lic-LowProfit' AS PolicyTitle, '31,709' AS siteID, 13 AS CurrencyID, 5 AS Platform, 99 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 13 AS PolicyID, 'OS-BDT-Lic-LowProfit' AS PolicyTitle, '549,589,454,536' AS siteID, 97 AS CurrencyID, 2 AS Platform, 99 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 14 AS PolicyID, 'OS-IN-Lic-LowProfit' AS PolicyTitle, '58,676,143,282' AS siteID, 15 AS CurrencyID, 2 AS Platform, 99 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 15 AS PolicyID, 'OS-INH-Lic-LowProfit' AS PolicyTitle, '589,840,333,482,481,282' AS siteID, 51 AS CurrencyID, 2 AS Platform, 99 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 16 AS PolicyID, 'OS-INR-Lic-LowProfit' AS PolicyTitle, '191,325,36,589,225,354,536,94,884,1062,915' AS siteID, 61 AS CurrencyID, 2 AS Platform, 99 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 17 AS PolicyID, 'OS-JPY-w84sw-LowProfit' AS PolicyTitle, '1102' AS siteID, 32 AS CurrencyID, 2 AS Platform, 99 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 18 AS PolicyID, 'OS-NPR-khmerA2-LowProfit' AS PolicyTitle, '605' AS siteID, 123 AS CurrencyID, 2 AS Platform, 99 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 19 AS PolicyID, 'OS-PKR-Baji-LowProfit' AS PolicyTitle, '589' AS siteID, 121 AS CurrencyID, 2 AS Platform, 99 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 20 AS PolicyID, 'OS-RM-Lic-LowProfit' AS PolicyTitle, '138,522,496,1083' AS siteID, 2 AS CurrencyID, 2 AS Platform, 99 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 21 AS PolicyID, 'OS-RMB-Lic-LowProfit' AS PolicyTitle, '1008,317,364,764,1145,840,44,535,711,548,1078,436,629,806,924,473,767,686,464,884,952' AS siteID, 
		   13 AS CurrencyID, 2 AS Platform, 99 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 22 AS PolicyID, 'OS-RMB2-Lic-LowProfit' AS PolicyTitle, '766,749' AS siteID, 124 AS CurrencyID, 2 AS Platform, 99 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 23 AS PolicyID, 'OS-TB-Lic-LowProfit' AS PolicyTitle, '125,499,275,808,104,918,1134,568' AS siteID, 4 AS CurrencyID, 2 AS Platform, 99 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 24 AS PolicyID, 'OS-US$-Lic-LowProfit' AS PolicyTitle, '171,454,94' AS siteID, 3 AS CurrencyID, 2 AS Platform, 99 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 25 AS PolicyID, 'OS-USDT-liv66SW-LowProfit' AS PolicyTitle, '575' AS siteID, 96 AS CurrencyID, 2 AS Platform, 99 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 26 AS PolicyID, 'OS-Won-Lic-LowProfit' AS PolicyTitle, '942,576' AS siteID, 45 AS CurrencyID, 2 AS Platform, 99 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 27 AS PolicyID, 'OS-INH-Lic-LowProfit' AS PolicyTitle, '482,904,884' AS siteID, 51 AS CurrencyID, 1 AS Platform, 99 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 28 AS PolicyID, 'OS-RM-TCGMYR-LowProfit' AS PolicyTitle, '1083' AS siteID, 2 AS CurrencyID, 1 AS Platform, 99 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 29 AS PolicyID, 'OS-US$-Lic-LowProfit' AS PolicyTitle, '848,522,448' AS siteID, 3 AS CurrencyID, 1 AS Platform, 99 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 30 AS PolicyID, 'OS-USDT-liv66SW-LowProfit' AS PolicyTitle, '575' AS siteID, 96 AS CurrencyID, 1 AS Platform, 99 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 31 AS PolicyID, 'OS-Won-Lic-LowProfit' AS PolicyTitle, '36,171,94' AS siteID, 45 AS CurrencyID, 1 AS Platform, 99 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 32 AS PolicyID, 'OS-Won2-W88CV-LowProfit' AS PolicyTitle, '744' AS siteID, 130 AS CurrencyID, 1 AS Platform, 99 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 33 AS PolicyID, 'OS-INH-vnggame-LowProfit' AS PolicyTitle, '904' AS siteID, 51 AS CurrencyID, 2 AS Platform, 99 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 34 AS PolicyID, 'OS-INR-Mybet88-LowProfit' AS PolicyTitle, '260' AS siteID, 61 AS CurrencyID, 2 AS Platform, 99 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 35 AS PolicyID, 'OS-RMB-FPGagent-LowProfit' AS PolicyTitle, '1283' AS siteID, 13 AS CurrencyID, 2 AS Platform, 99 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 36 AS PolicyID, 'OS-US$-Baji-LowProfit' AS PolicyTitle, '589' AS siteID, 3 AS CurrencyID, 2 AS Platform, 99 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 37 AS PolicyID, 'OS-US$2-W88CV-LowProfit' AS PolicyTitle, '744' AS siteID, 132 AS CurrencyID, 2 AS Platform, 99 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 38 AS PolicyID, 'OS-USDT-OSUSDT-LowProfit' AS PolicyTitle, '561' AS siteID, 96 AS CurrencyID, 2 AS Platform, 99 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 1 AS PolicyID, 'SC-IN-Lic-LowProfit' AS PolicyTitle, '56,53' AS siteID, 15 AS CurrencyID, 3 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 2 AS PolicyID, 'SC-INH-Lic-LowProfit' AS PolicyTitle, '30,94' AS siteID, 51 AS CurrencyID, 3 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 3 AS PolicyID, 'SC-RMB-alog-LowProfit' AS PolicyTitle, '36' AS siteID, 13 AS CurrencyID, 3 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 4 AS PolicyID, 'SC-EURO-alog-LowProfit' AS PolicyTitle, '36' AS siteID, 6 AS CurrencyID, 1 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 5 AS PolicyID, 'SC-IN-Lic-LowProfit' AS PolicyTitle, '30,56,171,583,448,545,532' AS siteID, 15 AS CurrencyID, 1 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 6 AS PolicyID, 'SC-INH-Lic-LowProfit' AS PolicyTitle, '30,191,125,574,138,325,36,31,589,808,1033,177,555,171,628,354,333,813,583,887,722,344,1082,904,1102,416,767,919,282' AS siteID, 
		   51 AS CurrencyID, 1 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 7 AS PolicyID, 'SC-INH2-W88CV-LowProfit' AS PolicyTitle, '744' AS siteID, 125 AS CurrencyID, 1 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 8 AS PolicyID, 'SC-RM-Lic-LowProfit' AS PolicyTitle, '574,241,145,583,260' AS siteID, 2 AS CurrencyID, 1 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 9 AS PolicyID, 'SC-RMB-Lic-LowProfit' AS PolicyTitle, '36,261,171,248,504,1078,1040,253,536,292,686' AS siteID, 13 AS CurrencyID, 1 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 10 AS PolicyID, 'SC-RMB2-Lic-LowProfit' AS PolicyTitle, '758,735,763' AS siteID, 124 AS CurrencyID, 1 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 11 AS PolicyID, 'SC-TB-Lic-LowProfit' AS PolicyTitle, '30,36,31,171,375,448,94,302' AS siteID, 4 AS CurrencyID, 1 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 12 AS PolicyID, 'SC-US$-khmerA2-LowProfit' AS PolicyTitle, '605' AS siteID, 3 AS CurrencyID, 1 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 13 AS PolicyID, 'SC-USDT-W88-LowProfit' AS PolicyTitle, '94' AS siteID, 96 AS CurrencyID, 1 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 14 AS PolicyID, 'SC-Won-Lic-LowProfit' AS PolicyTitle, '485,354' AS siteID, 45 AS CurrencyID, 1 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 15 AS PolicyID, 'SC-INH2-FB88CV-LowProfit' AS PolicyTitle, '755' AS siteID, 125 AS CurrencyID, 5 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 16 AS PolicyID, 'SC-RMB-asiabet88-LowProfit' AS PolicyTitle, '31' AS siteID, 13 AS CurrencyID, 5 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 17 AS PolicyID, 'SC-BDT-TSEnter-LowProfit' AS PolicyTitle, '536' AS siteID, 97 AS CurrencyID, 2 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 18 AS PolicyID, 'SC-IN-Lic-LowProfit' AS PolicyTitle, '30,574,138,36,840,1002,912,700,198,58,583,53,448,104,556,143,788,532,94' AS siteID, 
		   15 AS CurrencyID, 2 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 19 AS PolicyID, 'SC-INH-Lic-LowProfit' AS PolicyTitle, '30,418,191,125,752,574,138,123,325,31,589,1033,1059,555,1243,171,708,628,1168,354,180,333,813,605,535,887,979,483,482,454,932,722,633,344,536,336,904,1121,315,1102,767,271,884,661,692,934,1072,282' AS siteID,	  51 AS CurrencyID, 2 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 20 AS PolicyID, 'SC-INR-12Bet-LowProfit' AS PolicyTitle, '30' AS siteID, 61 AS CurrencyID, 2 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 21 AS PolicyID, 'SC-MKK-568WinSW-LowProfit' AS PolicyTitle, '574' AS siteID, 70 AS CurrencyID, 2 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 22 AS PolicyID, 'SC-PE2-Lic-LowProfit' AS PolicyTitle, '926,865' AS siteID, 128 AS CurrencyID, 2 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 23 AS PolicyID, 'SC-PKR-Baji-LowProfit' AS PolicyTitle, '589' AS siteID, 121 AS CurrencyID, 2 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 24 AS PolicyID, 'SC-RM-Lic-LowProfit' AS PolicyTitle, '574,145,333,522,436,260,448,1083,94,507' AS siteID, 2 AS CurrencyID, 2 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 25 AS PolicyID, 'SC-RMB-Lic-LowProfit' AS PolicyTitle, '1008,133,364,31,427,221,848,245,44,559,204,165,333,713,535,901,711,591,504,548,462,629,214,998,924,475,315,94,437,377,464,960,791,488,490,573' AS siteID, 
		   13 AS CurrencyID, 2 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 26 AS PolicyID, 'SC-RMB2-Lic-LowProfit' AS PolicyTitle, '734,741,739,766,990' AS siteID, 124 AS CurrencyID, 2 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 27 AS PolicyID, 'SC-TB-Lic-LowProfit' AS PolicyTitle, '30,499,275,645,1108,808,354,870,333,813,419,375,712,104,918,768,94,302,568,1065,1152,282' AS siteID, 
		   4 AS CurrencyID, 2 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 28 AS PolicyID, 'SC-US$-Lic-LowProfit' AS PolicyTitle, '848,282' AS siteID, 3 AS CurrencyID, 2 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 29 AS PolicyID, 'SC-Won-Lic-LowProfit' AS PolicyTitle, '30,325,333' AS siteID, 45 AS CurrencyID, 2 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 30 AS PolicyID, 'SC-Won2-W88CV-LowProfit' AS PolicyTitle, '744' AS siteID, 130 AS CurrencyID, 2 AS Platform, 1 AS SportType, 0.02 AS Spread UNION ALL 
	SELECT 31 AS PolicyID, 'SC-RM-iBET-LowProfit' AS PolicyTitle, '145' AS siteID, 2 AS CurrencyID, 3 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 32 AS PolicyID, 'SC-TB-Lic-LowProfit' AS PolicyTitle, '30,36' AS siteID, 4 AS CurrencyID, 3 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 33 AS PolicyID, 'SC-IN-Lic-LowProfit' AS PolicyTitle, '125,574,138,36,163,912,700,198,53,104,885,94' AS siteID, 15 AS CurrencyID, 1 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 34 AS PolicyID, 'SC-IN2-W88CV-LowProfit' AS PolicyTitle, '744' AS siteID, 129 AS CurrencyID, 1 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 35 AS PolicyID, 'SC-INH-Lic-LowProfit' AS PolicyTitle, '522,605,297,448,863,483,482,669,454,932,633,860,336,884,658,1072' AS siteID, 
		   51 AS CurrencyID, 1 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 36 AS PolicyID, 'SC-RM-Lic-LowProfit' AS PolicyTitle, '499,656,549,333,405,542,629,448,1083,94,534,507,810,282' AS siteID, 2 AS CurrencyID, 1 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 37 AS PolicyID, 'SC-RMB-Lic-LowProfit' AS PolicyTitle, '30,1008,418,191,1244,317,182,133,412,364,31,764,207,1145,215,225,177,724,630,221,199,888,44,354,559,204,165,333,713,419,535,887,591,297,629,448,806,669,214,1162,440,1050,1026,360,714,315,437,767,290,464,884,658,710,791,477' AS siteID, 
		   13 AS CurrencyID, 1 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 38 AS PolicyID, 'SC-RMB2-Lic-LowProfit' AS PolicyTitle, '737,761,733,738,739,766,762,744,792,749' AS siteID, 124 AS CurrencyID, 1 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 39 AS PolicyID, 'SC-TB-Lic-LowProfit' AS PolicyTitle, '125,574,499,325,275,645,1108,808,639,1174,454,712,104,623,836,918,507,565,884,519,568,1065,1152,282' AS siteID, 
		   4 AS CurrencyID, 1 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 40 AS PolicyID, 'SC-TB2-W88CV-LowProfit' AS PolicyTitle, '744' AS siteID, 126 AS CurrencyID, 1 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 41 AS PolicyID, 'SC-US$-Lic-LowProfit' AS PolicyTitle, '125,171,848,583,448,94,1134,282' AS siteID, 3 AS CurrencyID, 1 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 42 AS PolicyID, 'SC-USDT-Lic-LowProfit' AS PolicyTitle, '575,872,561,336,507,960' AS siteID, 96 AS CurrencyID, 1 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 43 AS PolicyID, 'SC-USDT2-W88CV-LowProfit' AS PolicyTitle, '744' AS siteID, 206 AS CurrencyID, 1 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 44 AS PolicyID, 'SC-Won-Lic-LowProfit' AS PolicyTitle, '30,942,993,1354,171,576' AS siteID, 45 AS CurrencyID, 1 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 45 AS PolicyID, 'SC-Won2-W88CV-LowProfit' AS PolicyTitle, '744' AS siteID, 130 AS CurrencyID, 1 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 46 AS PolicyID, 'SC-RMB-Dawoo-LowProfit' AS PolicyTitle, '225' AS siteID, 13 AS CurrencyID, 5 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 47 AS PolicyID, 'SC-RMB2-Xinli2CV-LowProfit' AS PolicyTitle, '792' AS siteID, 124 AS CurrencyID, 5 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 48 AS PolicyID, 'SC-BDT-Baji-LowProfit' AS PolicyTitle, '589' AS siteID, 97 AS CurrencyID, 2 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 49 AS PolicyID, 'SC-IN-Lic-LowProfit' AS PolicyTitle, '125,499,98,196,299,1119,165,486' AS siteID, 15 AS CurrencyID, 2 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 50 AS PolicyID, 'SC-IN2-W88CV-LowProfit' AS PolicyTitle, '744' AS siteID, 129 AS CurrencyID, 2 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 51 AS PolicyID, 'SC-INH-Lic-LowProfit' AS PolicyTitle, '1016,808,840,522,863,1195,919,1237' AS siteID, 51 AS CurrencyID, 2 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 52 AS PolicyID, 'SC-INR-Baji-LowProfit' AS PolicyTitle, '589' AS siteID, 61 AS CurrencyID, 2 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 53 AS PolicyID, 'SC-RM-Lic-LowProfit' AS PolicyTitle, '250,354,1294,496,629' AS siteID, 2 AS CurrencyID, 2 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 54 AS PolicyID, 'SC-RM2-W88CV-LowProfit' AS PolicyTitle, '744' AS siteID, 131 AS CurrencyID, 2 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 55 AS PolicyID, 'SC-RMB-Lic-LowProfit' AS PolicyTitle, '574,1244,1077,1033,177,724,888,304,769,297,872,806,1050,714,869,416,673,1015,658,710,952' AS siteID, 
		   13 AS CurrencyID, 2 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 56 AS PolicyID, 'SC-RMB2-VKGAMECV-LowProfit' AS PolicyTitle, '762' AS siteID, 124 AS CurrencyID, 2 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 57 AS PolicyID, 'SC-TB-Lic-LowProfit' AS PolicyTitle, '125,840,583,887,639' AS siteID, 4 AS CurrencyID, 2 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 58 AS PolicyID, 'SC-US$-Lic-LowProfit' AS PolicyTitle, '605,448,884' AS siteID, 3 AS CurrencyID, 2 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 59 AS PolicyID, 'SC-USDT-Lic-LowProfit' AS PolicyTitle, '575,872,561,94,507,960' AS siteID, 96 AS CurrencyID, 2 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 60 AS PolicyID, 'SC-USDT2-W88CV-LowProfit' AS PolicyTitle, '744' AS siteID, 206 AS CurrencyID, 2 AS Platform, 1 AS SportType, 0.04 AS Spread UNION ALL 
	SELECT 61 AS PolicyID, 'SC-Won-Lic-LowProfit' AS PolicyTitle, '993,485,354' AS siteID, 45 AS CurrencyID, 2 AS Platform, 1 AS SportType, 0.04 AS Spread  

	DECLARE @SportType SMALLINT, @PolicyTitle VARCHAR(500), @Sites VARCHAR(MAX), @Currencies VARCHAR(MAX)
	, @Platforms VARCHAR(MAX), @Spread DECIMAL(4,2), @Enable BIT, @UserID INT, @IsTest TINYINT, @IP VARCHAR(50) = '' , @PolicyID INT 
	, @ErrMsg NVARCHAR(MAX), @ErrCode INT
	
	SELECT @ErrCode=0, @ErrMsg='' , @Enable = 1, @UserID = 10278938, @IsTest = 0, @IP = '10.18.200.204'
	select * from #CCSpread

	WHILE (1 = 1)
	BEGIN


		UPDATE TOP (1) #CCSpread
		SET isFinished = 1
			,@PolicyTitle = PolicyTitle
			,@Sites = siteID
			,@Currencies = CurrencyID
			,@Platforms = Platform
			,@Spread = Spread
			,@SportType = SportType
		WHERE isFinished = 0	
			
		IF @@ROWCOUNT = 0 BREAK 
		-- 10278938 : starixIT
			SELECT @PolicyTitle, @Sites, @Currencies, @Platforms, @Spread, @SportType
		EXEC NAP_LM_CustomerClassSpreadIns @PolicyID = @PolicyID OUTPUT, @PolicyTitle = @PolicyTitle, @CustomerClasses = @CustomerClass, @SportType = @SportType, @Sites = @Sites, @Currencies = @Currencies, @Platforms = @Platforms, @Spread = @Spread, @Enable = @Enable ,
		 @ErrCode =@ErrCode OUTPUT, @ErrMsg = @ErrMsg OUTPUT,  @IP = @IP, @UserID = @UserID, @IsTest = @IsTest

	END

	DROP TABLE #CCSpread

	