/*
	Date: 2018-10-24
	Created: Johnson
	Task: add global setting for UUS for cash
	DB: DBCUST/CUSTDB
*/

SELECT 	4132	GameTypeID,	20	ExchangeID,	'0.5'	MinLabel,	'5'	MaxLabel,	0.5	MinStake,	5	MaxStake--	UUS	as currency
INTO #tmpStake
UNION SELECT 	4135	,	20	,	'0.5'	,	'5'	,	0.5	,	5	--	UUS	as currency
UNION SELECT 	4165	,	20	,	'0.25'	,	'12.5'	,	0.25	,	12.5	--	UUS	as currency
UNION SELECT 	4166	,	20	,	'0.5'	,	'5'	,	0.5	,	5	--	UUS	as currency
UNION SELECT 	4167	,	20	,	'0.25'	,	'50'	,	0.25	,	50	--	UUS	as currency
UNION SELECT 	4168	,	20	,	'0.1'	,	'30'	,	0.1	,	30	--	UUS	as currency
UNION SELECT 	4169	,	20	,	'0.2'	,	'20'	,	0.2	,	20	--	UUS	as currency
UNION SELECT 	4170	,	20	,	'0.3'	,	'30'	,	0.3	,	30	--	UUS	as currency
UNION SELECT 	4171	,	20	,	'0.2'	,	'20'	,	0.2	,	20	--	UUS	as currency
UNION SELECT 	4172	,	20	,	'0.25'	,	'2.5'	,	0.25	,	2.5	--	UUS	as currency
UNION SELECT 	4173	,	20	,	'0.09'	,	'9'	,	0.09	,	9	--	UUS	as currency
UNION SELECT 	4174	,	20	,	'0.2'	,	'10'	,	0.2	,	10	--	UUS	as currency


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


