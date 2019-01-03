/*
	Date: 2018-12-28
	Created: Paul
	Task: add global setting for UUS for credit
	DB: DBCUST/CUSTDB
*/

SELECT 	6	GroupID,	4175	GameTypeID,	20	ExchangeID,	'0.20' MinLabel, '100.00' MaxLabel, 0.20 MinStake, 100.00 MaxStake--	UUS	as currency
INTO #tmpStake
UNION SELECT 	6	,	4176	,	20	,	'0.25' MinLabel, '7.50' MaxLabel, 0.25 MinStake, 7.50 MaxStake		--		as code	UUS	as currency
UNION SELECT 	6	,	4177	,	20	,	'0.05' MinLabel, '100.00' MaxLabel, 0.05 MinStake, 100.00 MaxStake	--		as code	UUS	as currency
UNION SELECT 	6	,	4178	,	20	,	'0.50' MinLabel, '50.00' MaxLabel, 0.50 MinStake, 50.00 MaxStake	--		as code	UUS	as currency

UNION SELECT 	7	,	4175	,	20	,	'0.20' MinLabel, '200.00' MaxLabel, 0.20 MinStake, 200.00 MaxStake	--		as code	UUS	as currency
UNION SELECT 	7	,	4176	,	20	,	'0.25' MinLabel, '15.00' MaxLabel, 0.25 MinStake, 15.00 MaxStake	--		as code	UUS	as currency
UNION SELECT 	7	,	4177	,	20	,	'0.05' MinLabel, '200.00' MaxLabel, 0.05 MinStake, 200.00 MaxStake	--		as code	UUS	as currency
UNION SELECT 	7	,	4178	,	20	,	'0.50' MinLabel, '100.00' MaxLabel, 0.50 MinStake, 100.00 MaxStake	--		as code	UUS	as currency

UNION SELECT 	6	,	4175	,	72	,	'0.20' MinLabel, '100.00' MaxLabel, 0.20 MinStake, 100.00 MaxStake	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4176	,	72	,	'0.25' MinLabel, '7.50' MaxLabel, 0.25 MinStake, 7.50 MaxStake		--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4177	,	72	,	'0.05' MinLabel, '100.00' MaxLabel, 0.05 MinStake, 100.00 MaxStake	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4178	,	72	,	'0.50' MinLabel, '50.00' MaxLabel, 0.50 MinStake, 50.00 MaxStake	--	YNG	as code	YNG	as currency

UNION SELECT 	7	,	4175	,	72	,	'0.20' MinLabel, '200.00' MaxLabel, 0.20 MinStake, 200.00 MaxStake	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4176	,	72	,	'0.25' MinLabel, '15.00' MaxLabel, 0.25 MinStake, 15.00 MaxStake	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4177	,	72	,	'0.05' MinLabel, '200.00' MaxLabel, 0.05 MinStake, 200.00 MaxStake	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4178	,	72	,	'0.50' MinLabel, '100.00' MaxLabel, 0.50 MinStake, 100.00 MaxStake	--	YNG	as code	YNG	as currency


;WITH T AS(
SELECT s.StakeLevelID,t.* 
FROM StakeLevel s (NOLOCK)
CROSS APPLY (SELECT * FROM #tmpStake t WHERE s.ExchangeId = t.ExchangeID AND s.GameGroupID = t.GroupID) t
WHERE s.GameTypeID = 4101
)
MERGE StakeLevelGroupDetail as g 
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



