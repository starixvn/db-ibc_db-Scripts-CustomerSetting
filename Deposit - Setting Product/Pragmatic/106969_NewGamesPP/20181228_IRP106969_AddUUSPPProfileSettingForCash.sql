/*
	Date: 2018-12-28
	Created: Paul
	Task: add global setting for UUS for cash
	DB: DBCUST/CUSTDB
*/

SELECT 	4175	GameTypeID,	20	ExchangeID,	'0.20'	MinLabel,	'20.00'	MaxLabel,	0.20	MinStake,	20.00	MaxStake--	UUS	as currency
INTO #tmpStake
UNION SELECT 	4176	,	20	,	'0.25'	,	'2.50'	,	0.25	,	2.50	--	UUS	as currency
UNION SELECT 	4177	,	20	,	'0.05'	,	'15.00'	,	0.05	,	15.00	--	UUS	as currency
UNION SELECT 	4178	,	20	,	'0.50'	,	'25.00'	,	0.50	,	25.00	--	UUS	as currency


;WITH T AS(
SELECT s.StakeLevelID,t.* 
FROM Dep_StakeLevel s (NOLOCK)
CROSS APPLY (SELECT * FROM #tmpStake t WHERE s.ExchangeId = t.ExchangeID) t
WHERE s.GameTypeID = 4101
)
MERGE Dep_StakeLevelGroupDetail as g 
USING t ON g.GameTypeID = t.GameTypeID AND g.StakeLevelID = t.StakeLevelID 
WHEN MATCHED THEN UPDATE SET g.MinLabel = t.MinLabel,
							g.MaxLabel = t.MaxLabel,
							g.MinStake = t.MinStake,
							g.MaxStake = t.MaxStake
WHEN NOT MATCHED THEN INSERT ([StakeLevelID]
							   ,[GameTypeID]
							   ,[MinLabel]
							   ,[MaxLabel]
							   ,[MinStake]
							   ,[MaxStake]
							   )
				VALUES(t.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake);	   							


