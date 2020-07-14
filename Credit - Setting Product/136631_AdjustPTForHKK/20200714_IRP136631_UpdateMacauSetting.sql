/*
	Created: 20200710@Johnson
	Task: update global PP setting for HKK 
	DB: DBCUST/CUSTDB
*/

CREATE TABLE #tmpSetting (GameTypeID INT, MinStake MONEY, MaxStake MONEY, MinLabel VARCHAR(10), MaxLabel VARCHAR(10))

INSERT INTO #tmpSetting(GameTypeID,MinStake,MaxStake,MinLabel,MaxLabel)
SELECT 	4001	,	0.01	,	62.5	,	'0.01'	,	'62.5'	--	Amazon
UNION ALL SELECT 	4002	,	0.25	,	62.5	,	'0.25'	,	'62.5'	--	Big Haul
UNION ALL SELECT 	4003	,	0.2	,	50	,	'0.2'	,	'50'	--	Bushido Code
UNION ALL SELECT 	4005	,	0.25	,	62.5	,	'0.25'	,	'62.5'	--	Catch the Waves
UNION ALL SELECT 	4006	,	0.01	,	22.5	,	'0.01'	,	'22.5'	--	Chinese Treasure
UNION ALL SELECT 	4007	,	0.01	,	22.5	,	'0.01'	,	'22.5'	--	Chinese Zodiac
UNION ALL SELECT 	4008	,	0.1	,	25	,	'0.1'	,	'25'	--	Dancing Lions
UNION ALL SELECT 	4009	,	0.5	,	125	,	'0.5'	,	'125'	--	Dragon King
UNION ALL SELECT 	4010	,	0.25	,	62.5	,	'0.25'	,	'62.5'	--	Dragons and Pearls
UNION ALL SELECT 	4011	,	0.25	,	62.5	,	'0.25'	,	'62.5'	--	Fish 'O' Mania
UNION ALL SELECT 	4012	,	0.5	,	125	,	'0.5'	,	'125'	--	Fortune Panda
UNION ALL SELECT 	4013	,	0.09	,	22.5	,	'0.09'	,	'22.5'	--	God of Wealth
UNION ALL SELECT 	4014	,	0.25	,	62.5	,	'0.25'	,	'62.5'	--	Gold of Ra
UNION ALL SELECT 	4015	,	0.1	,	25	,	'0.1'	,	'25'	--	Guardian Lion
UNION ALL SELECT 	4016	,	0.01	,	50	,	'0.01'	,	'50'	--	Ice World
UNION ALL SELECT 	4017	,	0.01	,	22.5	,	'0.01'	,	'22.5'	--	Infinite Turbo
UNION ALL SELECT 	4018	,	0.25	,	62.5	,	'0.25'	,	'62.5'	--	King of Time
UNION ALL SELECT 	4019	,	0.2	,	50	,	'0.2'	,	'50'	--	Lady Luck
UNION ALL SELECT 	4020	,	0.1	,	25	,	'0.1'	,	'25'	--	Mystic Riches
UNION ALL SELECT 	4021	,	0.2	,	50	,	'0.2'	,	'50'	--	Phoenix Princess
UNION ALL SELECT 	4023	,	0.25	,	62.5	,	'0.25'	,	'62.5'	--	Temple Treasures
UNION ALL SELECT 	4024	,	0.1	,	25	,	'0.1'	,	'25'	--	Thai Dragon
UNION ALL SELECT 	4025	,	0.2	,	50	,	'0.2'	,	'50'	--	Treasure Reef
UNION ALL SELECT 	4026	,	0.2	,	50	,	'0.2'	,	'50'	--	Venetia
UNION ALL SELECT 	4028	,	0.1	,	25	,	'0.1'	,	'25'	--	Wild Dolphin
UNION ALL SELECT 	4029	,	0.5	,	125	,	'0.5'	,	'125'	--	Wolf Quest
UNION ALL SELECT 	4030	,	0.15	,	37.5	,	'0.15'	,	'37.5'	--	World Snooker Masters
UNION ALL SELECT 	4031	,	0.15	,	37.5	,	'0.15'	,	'37.5'	--	Caishen’s Quest
UNION ALL SELECT 	4032	,	0.25	,	62.5	,	'0.25'	,	'62.5'	--	Lucky Dragons
UNION ALL SELECT 	4033	,	0.09	,	22.5	,	'0.09'	,	'22.5'	--	Highway Cash
UNION ALL SELECT 	4035	,	0.09	,	22.5	,	'0.09'	,	'22.5'	--	Goldbeard's Treasure
UNION ALL SELECT 	4036	,	0.09	,	22.5	,	'0.09'	,	'22.5'	--	Double Triple 8
UNION ALL SELECT 	4037	,	0.09	,	22.5	,	'0.09'	,	'22.5'	--	Gods of Fortune
UNION ALL SELECT 	4038	,	0.25	,	62.5	,	'0.25'	,	'62.5'	--	Busy Bees
UNION ALL SELECT 	4039	,	0.1	,	10	,	'0.1'	,	'10'	--	Funny Monkey
UNION ALL SELECT 	4040	,	0.09	,	22.5	,	'0.09'	,	'22.5'	--	Gods of Fortune Deluxe
UNION ALL SELECT 	4041	,	0.5	,	125	,	'0.5'	,	'125'	--	Golf Tour
UNION ALL SELECT 	4042	,	0.1	,	100	,	'0.1'	,	'100'	--	Lucky 8's
UNION ALL SELECT 	4043	,	0.1	,	1000	,	'0.1'	,	'1000'	--	Triple Lion
UNION ALL SELECT 	4047	,	0.15	,	37.5	,	'0.15'	,	'37.5'	--	Twin Dragon



DECLARE @StakeLevelID INT

SELECT @StakeLevelID = StakeLevelID
FROM StakeLevel WITH(NOLOCK)
WHERE GameTypeID = 4001 
	AND exchangeid = 67

UPDATE s
SET s.MinStake = t.MinStake,
	s.MaxStake = t.MaxStake,
	s.MinLabel = t.MinLabel,
	s.MaxLabel = t.MaxLabel
FROM StakeLevelGroupDetail s WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #tmpSetting t ON s.GameTypeID = t.GameTypeID
WHERE s.StakeLevelID = @StakeLevelID	
