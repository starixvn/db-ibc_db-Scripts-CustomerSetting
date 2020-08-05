/*
	Created: 20200805@Johnson
	Task: update global bet limit for virtual game
	DB: DBCUST/CUSTDB
*/
DECLARE @tmpSetting TABLE(currency VARCHAR(10), MinBet MONEY, MaxBet MONEY, MinLabel VARCHAR(10), MaxLabel VARCHAR(10))

INSERT INTO @tmpSetting (currency,MinBet,MaxBet,MinLabel,MaxLabel)
SELECT	'RM'	,	5	,	10450	,	'5'	,	'10,450'
UNION ALL SELECT	'USDT'	,	1	,	2500	,	'1'	,	'2,500'
UNION ALL SELECT	'US$'	,	1	,	2500	,	'1'	,	'2,500'
UNION ALL SELECT	'TB'	,	50	,	75000	,	'50'	,	'75,000'
UNION ALL SELECT	'EURO'	,	1	,	1925	,	'1'	,	'1,925'
UNION ALL SELECT	'RMB'	,	10	,	17500	,	'10'	,	'17,500'
UNION ALL SELECT	'IN'	,	50	,	35000	,	'50'	,	'35,000'
UNION ALL SELECT	'JPY'	,	100	,	270000	,	'100'	,	'270,000'
UNION ALL SELECT	'WON'	,	1000	,	2935000	,	'1,000'	,	'2,935,000'
UNION ALL SELECT	'INH'	,	10	,	57500	,	'10'	,	'57,500'
UNION ALL SELECT	'INR'	,	10	,	175000	,	'10'	,	'175,000'
UNION ALL SELECT	'MKK'	,	1	,	2500	,	'1'	,	'2,500'
UNION ALL SELECT	'MMK'	,	1	,	2500	,	'1'	,	'2,500'
UNION ALL SELECT	'KHR'	,	5	,	10450	,	'5'	,	'10,450'

;WITH tmp AS 
(
	SELECT StakeLevelID, ROW_NUMBER() over (PARTITION by siteid,GameTypeID ORDER by MaxStake asc) rn
	FROM Dep_StakeLevel WITH(NOLOCK)
	WHERE GameTypeID IN (4601,4602) 
)
UPDATE s
SET s.MinBet = t.Minbet,
	s.MaxBet = t.MaxBet,
	s.MinLabel = t.MinLabel,
	s.MaxLabel = t.MaxLabel
FROM Dep_StakeLevel s WITH(UPDLOCK,ROWLOCK)
	INNER JOIN exchange e on s.exchangeid = e.exchangeid
	INNER JOIN @tmpSetting t ON e.currency = t.currency
	INNER JOIN tmp ON s.StakeLevelID = tmp.StakeLevelID
WHERE s.GameTypeID IN (4601,4602)
	AND tmp.rn = 1


