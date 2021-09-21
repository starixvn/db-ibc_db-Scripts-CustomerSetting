/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Johnson
	Date: 20210917
	Task: SBO RNG WAR - Change Product & Sport Name into Funky Game and add some new games
	DB: DBCust/CustDB
*/

UPDATE ProductSettingDetail WITH(ROWLOCK)
SET SettingType = 8,
	SettingLevel = 2
WHERE SettingType = 2
	AND sporttype = 224
	
UPDATE ProductSettingDetail WITH(ROWLOCK)
SET SettingLevel = 2
WHERE SettingType = 18
	AND sporttype = 224	
	
GO

SELECT 	13	exchangeid,	5500	gametypeid,	10	MinStake,	20000	MaxStake,	'10'	minlabel,	'20000' maxlabel	--	RMB
INTO #tmpSetting
UNION SELECT 	13	,	5501	,	25	,	3000	,	'25'	,	'3000'	--	RMB
UNION SELECT 	13	,	5502	,	25	,	3000	,	'25'	,	'3000'	--	RMB
UNION SELECT 	13	,	5503	,	25	,	3000	,	'25'	,	'3000'	--	RMB
UNION SELECT 	13	,	5504	,	25	,	3000	,	'25'	,	'3000'	--	RMB
UNION SELECT 	13	,	5505	,	25	,	3000	,	'25'	,	'3000'	--	RMB
UNION SELECT 	13	,	5506	,	5	,	500	,	'5'	,	'500'	--	RMB
UNION SELECT 	13	,	5507	,	5	,	500	,	'5'	,	'500'	--	RMB
UNION SELECT 	13	,	5508	,	5	,	500	,	'5'	,	'500'	--	RMB
UNION SELECT 	13	,	5509	,	5	,	500	,	'5'	,	'500'	--	RMB
UNION SELECT 	6	,	5500	,	1	,	3000	,	'1'	,	'3000'	--	EURO
UNION SELECT 	6	,	5501	,	5	,	500	,	'5'	,	'500'	--	EURO
UNION SELECT 	6	,	5502	,	5	,	500	,	'5'	,	'500'	--	EURO
UNION SELECT 	6	,	5503	,	5	,	500	,	'5'	,	'500'	--	EURO
UNION SELECT 	6	,	5504	,	5	,	500	,	'5'	,	'500'	--	EURO
UNION SELECT 	6	,	5505	,	5	,	500	,	'5'	,	'500'	--	EURO
UNION SELECT 	6	,	5506	,	1	,	100	,	'1'	,	'100'	--	EURO
UNION SELECT 	6	,	5507	,	1	,	100	,	'1'	,	'100'	--	EURO
UNION SELECT 	6	,	5508	,	1	,	100	,	'1'	,	'100'	--	EURO
UNION SELECT 	6	,	5509	,	1	,	100	,	'1'	,	'100'	--	EURO
UNION SELECT 	5	,	5500	,	10	,	12500	,	'10'	,	'12500'	--	HK$
UNION SELECT 	5	,	5501	,	25	,	3000	,	'25'	,	'3000'	--	HK$
UNION SELECT 	5	,	5502	,	25	,	3000	,	'25'	,	'3000'	--	HK$
UNION SELECT 	5	,	5503	,	25	,	3000	,	'25'	,	'3000'	--	HK$
UNION SELECT 	5	,	5504	,	25	,	3000	,	'25'	,	'3000'	--	HK$
UNION SELECT 	5	,	5505	,	25	,	3000	,	'25'	,	'3000'	--	HK$
UNION SELECT 	5	,	5506	,	5	,	500	,	'5'	,	'500'	--	HK$
UNION SELECT 	5	,	5507	,	5	,	500	,	'5'	,	'500'	--	HK$
UNION SELECT 	5	,	5508	,	5	,	500	,	'5'	,	'500'	--	HK$
UNION SELECT 	5	,	5509	,	5	,	500	,	'5'	,	'500'	--	HK$
UNION SELECT 	67	,	5500	,	10	,	12500	,	'10'	,	'12500'	--	HKK
UNION SELECT 	67	,	5501	,	25	,	3000	,	'25'	,	'3000'	--	HKK
UNION SELECT 	67	,	5502	,	25	,	3000	,	'25'	,	'3000'	--	HKK
UNION SELECT 	67	,	5503	,	25	,	3000	,	'25'	,	'3000'	--	HKK
UNION SELECT 	67	,	5504	,	25	,	3000	,	'25'	,	'3000'	--	HKK
UNION SELECT 	67	,	5505	,	25	,	3000	,	'25'	,	'3000'	--	HKK
UNION SELECT 	67	,	5506	,	5	,	500	,	'5'	,	'500'	--	HKK
UNION SELECT 	67	,	5507	,	5	,	500	,	'5'	,	'500'	--	HKK
UNION SELECT 	67	,	5508	,	5	,	500	,	'5'	,	'500'	--	HKK
UNION SELECT 	67	,	5509	,	5	,	500	,	'5'	,	'500'	--	HKK
UNION SELECT 	47	,	5500	,	5	,	28000	,	'5'	,	'28000'	--	DDD
UNION SELECT 	47	,	5501	,	5	,	10000	,	'5'	,	'10000'	--	DDD
UNION SELECT 	47	,	5502	,	5	,	10000	,	'5'	,	'10000'	--	DDD
UNION SELECT 	47	,	5503	,	5	,	10000	,	'5'	,	'10000'	--	DDD
UNION SELECT 	47	,	5504	,	5	,	10000	,	'5'	,	'10000'	--	DDD
UNION SELECT 	47	,	5505	,	5	,	10000	,	'5'	,	'10000'	--	DDD
UNION SELECT 	47	,	5506	,	5	,	1000	,	'5'	,	'1000'	--	DDD
UNION SELECT 	47	,	5507	,	5	,	1000	,	'5'	,	'1000'	--	DDD
UNION SELECT 	47	,	5508	,	5	,	1000	,	'5'	,	'1000'	--	DDD
UNION SELECT 	47	,	5509	,	5	,	1000	,	'5'	,	'1000'	--	DDD
UNION SELECT 	33	,	5500	,	5	,	28000	,	'5'	,	'28000'	--	IDD
UNION SELECT 	33	,	5501	,	5	,	10000	,	'5'	,	'10000'	--	IDD
UNION SELECT 	33	,	5502	,	5	,	10000	,	'5'	,	'10000'	--	IDD
UNION SELECT 	33	,	5503	,	5	,	10000	,	'5'	,	'10000'	--	IDD
UNION SELECT 	33	,	5504	,	5	,	10000	,	'5'	,	'10000'	--	IDD
UNION SELECT 	33	,	5505	,	5	,	10000	,	'5'	,	'10000'	--	IDD
UNION SELECT 	33	,	5506	,	5	,	1000	,	'5'	,	'1000'	--	IDD
UNION SELECT 	33	,	5507	,	5	,	1000	,	'5'	,	'1000'	--	IDD
UNION SELECT 	33	,	5508	,	5	,	1000	,	'5'	,	'1000'	--	IDD
UNION SELECT 	33	,	5509	,	5	,	1000	,	'5'	,	'1000'	--	IDD
UNION SELECT 	34	,	5500	,	5	,	28000	,	'5'	,	'28000'	--	IDR
UNION SELECT 	34	,	5501	,	5	,	10000	,	'5'	,	'10000'	--	IDR
UNION SELECT 	34	,	5502	,	5	,	10000	,	'5'	,	'10000'	--	IDR
UNION SELECT 	34	,	5503	,	5	,	10000	,	'5'	,	'10000'	--	IDR
UNION SELECT 	34	,	5504	,	5	,	10000	,	'5'	,	'10000'	--	IDR
UNION SELECT 	34	,	5505	,	5	,	10000	,	'5'	,	'10000'	--	IDR
UNION SELECT 	34	,	5506	,	5	,	1000	,	'5'	,	'1000'	--	IDR
UNION SELECT 	34	,	5507	,	5	,	1000	,	'5'	,	'1000'	--	IDR
UNION SELECT 	34	,	5508	,	5	,	1000	,	'5'	,	'1000'	--	IDR
UNION SELECT 	34	,	5509	,	5	,	1000	,	'5'	,	'1000'	--	IDR
UNION SELECT 	15	,	5500	,	5	,	28000	,	'5'	,	'28000'	--	IN
UNION SELECT 	15	,	5501	,	5	,	10000	,	'5'	,	'10000'	--	IN
UNION SELECT 	15	,	5502	,	5	,	10000	,	'5'	,	'10000'	--	IN
UNION SELECT 	15	,	5503	,	5	,	10000	,	'5'	,	'10000'	--	IN
UNION SELECT 	15	,	5504	,	5	,	10000	,	'5'	,	'10000'	--	IN
UNION SELECT 	15	,	5505	,	5	,	10000	,	'5'	,	'10000'	--	IN
UNION SELECT 	15	,	5506	,	5	,	1000	,	'5'	,	'1000'	--	IN
UNION SELECT 	15	,	5507	,	5	,	1000	,	'5'	,	'1000'	--	IN
UNION SELECT 	15	,	5508	,	5	,	1000	,	'5'	,	'1000'	--	IN
UNION SELECT 	15	,	5509	,	5	,	1000	,	'5'	,	'1000'	--	IN
UNION SELECT 	22	,	5500	,	5	,	28000	,	'5'	,	'28000'	--	IND
UNION SELECT 	22	,	5501	,	5	,	10000	,	'5'	,	'10000'	--	IND
UNION SELECT 	22	,	5502	,	5	,	10000	,	'5'	,	'10000'	--	IND
UNION SELECT 	22	,	5503	,	5	,	10000	,	'5'	,	'10000'	--	IND
UNION SELECT 	22	,	5504	,	5	,	10000	,	'5'	,	'10000'	--	IND
UNION SELECT 	22	,	5505	,	5	,	10000	,	'5'	,	'10000'	--	IND
UNION SELECT 	22	,	5506	,	5	,	1000	,	'5'	,	'1000'	--	IND
UNION SELECT 	22	,	5507	,	5	,	1000	,	'5'	,	'1000'	--	IND
UNION SELECT 	22	,	5508	,	5	,	1000	,	'5'	,	'1000'	--	IND
UNION SELECT 	22	,	5509	,	5	,	1000	,	'5'	,	'1000'	--	IND
UNION SELECT 	45	,	5500	,	1000	,	3000000	,	'1000'	,	'3e+006'	--	Won
UNION SELECT 	45	,	5501	,	5000	,	750000	,	'5000'	,	'750000'	--	Won
UNION SELECT 	45	,	5502	,	5000	,	750000	,	'5000'	,	'750000'	--	Won
UNION SELECT 	45	,	5503	,	5000	,	750000	,	'5000'	,	'750000'	--	Won
UNION SELECT 	45	,	5504	,	5000	,	750000	,	'5000'	,	'750000'	--	Won
UNION SELECT 	45	,	5505	,	5000	,	750000	,	'5000'	,	'750000'	--	Won
UNION SELECT 	45	,	5506	,	1000	,	100000	,	'1000'	,	'100000'	--	Won
UNION SELECT 	45	,	5507	,	1000	,	100000	,	'1000'	,	'100000'	--	Won
UNION SELECT 	45	,	5508	,	1000	,	100000	,	'1000'	,	'100000'	--	Won
UNION SELECT 	45	,	5509	,	1000	,	100000	,	'1000'	,	'100000'	--	Won
UNION SELECT 	69	,	5500	,	2	,	3000	,	'2'	,	'3000'	--	MMK
UNION SELECT 	69	,	5501	,	1	,	1000	,	'1'	,	'1000'	--	MMK
UNION SELECT 	69	,	5502	,	1	,	1000	,	'1'	,	'1000'	--	MMK
UNION SELECT 	69	,	5503	,	1	,	1000	,	'1'	,	'1000'	--	MMK
UNION SELECT 	69	,	5504	,	1	,	1000	,	'1'	,	'1000'	--	MMK
UNION SELECT 	69	,	5505	,	1	,	1000	,	'1'	,	'1000'	--	MMK
UNION SELECT 	69	,	5506	,	1	,	100	,	'1'	,	'100'	--	MMK
UNION SELECT 	69	,	5507	,	1	,	100	,	'1'	,	'100'	--	MMK
UNION SELECT 	69	,	5508	,	1	,	100	,	'1'	,	'100'	--	MMK
UNION SELECT 	69	,	5509	,	1	,	100	,	'1'	,	'100'	--	MMK
UNION SELECT 	2	,	5500	,	3	,	12500	,	'3'	,	'12500'	--	RM
UNION SELECT 	2	,	5501	,	25	,	3000	,	'25'	,	'3000'	--	RM
UNION SELECT 	2	,	5502	,	25	,	3000	,	'25'	,	'3000'	--	RM
UNION SELECT 	2	,	5503	,	25	,	3000	,	'25'	,	'3000'	--	RM
UNION SELECT 	2	,	5504	,	25	,	3000	,	'25'	,	'3000'	--	RM
UNION SELECT 	2	,	5505	,	25	,	3000	,	'25'	,	'3000'	--	RM
UNION SELECT 	2	,	5506	,	5	,	500	,	'5'	,	'500'	--	RM
UNION SELECT 	2	,	5507	,	5	,	500	,	'5'	,	'500'	--	RM
UNION SELECT 	2	,	5508	,	5	,	500	,	'5'	,	'500'	--	RM
UNION SELECT 	2	,	5509	,	5	,	500	,	'5'	,	'500'	--	RM
UNION SELECT 	43	,	5500	,	10	,	42000	,	'10'	,	'42000'	--	THB
UNION SELECT 	43	,	5501	,	100	,	23000	,	'100'	,	'23000'	--	THB
UNION SELECT 	43	,	5502	,	100	,	23000	,	'100'	,	'23000'	--	THB
UNION SELECT 	43	,	5503	,	100	,	23000	,	'100'	,	'23000'	--	THB
UNION SELECT 	43	,	5504	,	100	,	23000	,	'100'	,	'23000'	--	THB
UNION SELECT 	43	,	5505	,	100	,	23000	,	'100'	,	'23000'	--	THB
UNION SELECT 	43	,	5506	,	20	,	3000	,	'20'	,	'3000'	--	THB
UNION SELECT 	43	,	5507	,	20	,	3000	,	'20'	,	'3000'	--	THB
UNION SELECT 	43	,	5508	,	20	,	3000	,	'20'	,	'3000'	--	THB
UNION SELECT 	43	,	5509	,	20	,	3000	,	'20'	,	'3000'	--	THB
UNION SELECT 	35	,	5500	,	1	,	3000	,	'1'	,	'3000'	--	$US
UNION SELECT 	35	,	5501	,	1	,	500	,	'1'	,	'500'	--	$US
UNION SELECT 	35	,	5502	,	1	,	500	,	'1'	,	'500'	--	$US
UNION SELECT 	35	,	5503	,	1	,	500	,	'1'	,	'500'	--	$US
UNION SELECT 	35	,	5504	,	1	,	500	,	'1'	,	'500'	--	$US
UNION SELECT 	35	,	5505	,	1	,	500	,	'1'	,	'500'	--	$US
UNION SELECT 	35	,	5506	,	1	,	50	,	'1'	,	'50'	--	$US
UNION SELECT 	35	,	5507	,	1	,	50	,	'1'	,	'50'	--	$US
UNION SELECT 	35	,	5508	,	1	,	50	,	'1'	,	'50'	--	$US
UNION SELECT 	35	,	5509	,	1	,	50	,	'1'	,	'50'	--	$US
UNION SELECT 	3	,	5500	,	1	,	3000	,	'1'	,	'3000'	--	US$
UNION SELECT 	3	,	5501	,	1	,	500	,	'1'	,	'500'	--	US$
UNION SELECT 	3	,	5502	,	1	,	500	,	'1'	,	'500'	--	US$
UNION SELECT 	3	,	5503	,	1	,	500	,	'1'	,	'500'	--	US$
UNION SELECT 	3	,	5504	,	1	,	500	,	'1'	,	'500'	--	US$
UNION SELECT 	3	,	5505	,	1	,	500	,	'1'	,	'500'	--	US$
UNION SELECT 	3	,	5506	,	1	,	50	,	'1'	,	'50'	--	US$
UNION SELECT 	3	,	5507	,	1	,	50	,	'1'	,	'50'	--	US$
UNION SELECT 	3	,	5508	,	1	,	50	,	'1'	,	'50'	--	US$
UNION SELECT 	3	,	5509	,	1	,	50	,	'1'	,	'50'	--	US$
UNION SELECT 	64	,	5500	,	1	,	3000	,	'1'	,	'3000'	--	UT
UNION SELECT 	64	,	5501	,	1	,	500	,	'1'	,	'500'	--	UT
UNION SELECT 	64	,	5502	,	1	,	500	,	'1'	,	'500'	--	UT
UNION SELECT 	64	,	5503	,	1	,	500	,	'1'	,	'500'	--	UT
UNION SELECT 	64	,	5504	,	1	,	500	,	'1'	,	'500'	--	UT
UNION SELECT 	64	,	5505	,	1	,	500	,	'1'	,	'500'	--	UT
UNION SELECT 	64	,	5506	,	1	,	50	,	'1'	,	'50'	--	UT
UNION SELECT 	64	,	5507	,	1	,	50	,	'1'	,	'50'	--	UT
UNION SELECT 	64	,	5508	,	1	,	50	,	'1'	,	'50'	--	UT
UNION SELECT 	64	,	5509	,	1	,	50	,	'1'	,	'50'	--	UT
UNION SELECT 	16	,	5500	,	1	,	3000	,	'1'	,	'3000'	--	Yen
UNION SELECT 	16	,	5501	,	1	,	500	,	'1'	,	'500'	--	Yen
UNION SELECT 	16	,	5502	,	1	,	500	,	'1'	,	'500'	--	Yen
UNION SELECT 	16	,	5503	,	1	,	500	,	'1'	,	'500'	--	Yen
UNION SELECT 	16	,	5504	,	1	,	500	,	'1'	,	'500'	--	Yen
UNION SELECT 	16	,	5505	,	1	,	500	,	'1'	,	'500'	--	Yen
UNION SELECT 	16	,	5506	,	1	,	50	,	'1'	,	'50'	--	Yen
UNION SELECT 	16	,	5507	,	1	,	50	,	'1'	,	'50'	--	Yen
UNION SELECT 	16	,	5508	,	1	,	50	,	'1'	,	'50'	--	Yen
UNION SELECT 	16	,	5509	,	1	,	50	,	'1'	,	'50'	--	Yen
UNION SELECT 	20	,	5500	,	20000	,	200000	,	'20000'	,	'200000'	--	UUS
UNION SELECT 	20	,	5501	,	100	,	15000	,	'100'	,	'15000'	--	UUS
UNION SELECT 	20	,	5502	,	100	,	15000	,	'100'	,	'15000'	--	UUS
UNION SELECT 	20	,	5503	,	100	,	15000	,	'100'	,	'15000'	--	UUS
UNION SELECT 	20	,	5504	,	100	,	15000	,	'100'	,	'15000'	--	UUS
UNION SELECT 	20	,	5505	,	100	,	15000	,	'100'	,	'15000'	--	UUS
UNION SELECT 	20	,	5506	,	10	,	2000	,	'10'	,	'2000'	--	UUS
UNION SELECT 	20	,	5507	,	10	,	2000	,	'10'	,	'2000'	--	UUS
UNION SELECT 	20	,	5508	,	10	,	2000	,	'10'	,	'2000'	--	UUS
UNION SELECT 	20	,	5509	,	10	,	2000	,	'10'	,	'2000'	--	UUS


INSERT INTO StakeLevel(GameTypeID,ExchangeId,GameGroupID)
SELECT gametypeid, ExchangeId, 0
FROM #tmpSetting
WHERE gametypeid = 5500
ORDER BY exchangeid 

INSERT INTO [dbo].[StakeLevelGroupDetail]
           ([StakeLevelID]
           ,[GameTypeID]
           ,[MinLabel]
           ,[MaxLabel]
           ,[MinStake]
           ,[MaxStake]
           )
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake
FROM  #tmpSetting t
	INNER JOIN StakeLevel s ON s.ExchangeId = t.ExchangeId 
							AND s.GameTypeID = 5500
order by StakeLevelID
