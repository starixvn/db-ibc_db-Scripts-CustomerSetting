/*
	Date: 2018-10-24
	Created: Johnson
	Task: add global setting for UUS for cash
	DB: DBCUST/CUSTDB
*/

SELECT 	4165	GameTypeID,	20	ExchangeID,	'0.25'	MinLabel,	'12.5'	MaxLabel,	0.25	MinStake,	12.5	MaxStake--	UUS	as currency
INTO #tmpStake
UNION SELECT 	4166	,	20	,	'0.5'	,	'5'	,	0.5	,	5	--	UUS	as currency
UNION SELECT 	4167	,	20	,	'0.25'	,	'50'	,	0.25	,	50	--	UUS	as currency
UNION SELECT 	4168	,	20	,	'0.1'	,	'30'	,	0.1	,	30	--	UUS	as currency
UNION SELECT 	4169	,	20	,	'0.2'	,	'20'	,	0.2	,	20	--	UUS	as currency
UNION SELECT 	4170	,	20	,	'0.3'	,	'30'	,	0.3	,	30	--	UUS	as currency
UNION SELECT 	4171	,	20	,	'0.2'	,	'20'	,	0.2	,	20	--	UUS	as currency
UNION SELECT 	4172	,	20	,	'0.25'	,	'2.5'	,	0.25	,	2.5	--	UUS	as currency
UNION SELECT 	4173	,	20	,	'0.09'	,	'9'	,	0.09	,	9	--	UUS	as currency
UNION SELECT 	4174	,	20	,	'0.2'	,	'10'	,	0.2	,	10	--	UUS	as currency

DELETE g
FROM dbo.Dep_StakeLevelGroupDetail g WITH(UPDLOCK,ROWLOCK)
	INNER JOIN dbo.Dep_StakeLevel s WITH(NOLOCK) ON g.StakeLevelID = s.StakeLevelID
	INNER JOIN #tmpStake t ON g.GameTypeID = t.GameTypeID
							AND s.exchangeid = t.exchangeid
WHERE s.GameTypeID = 4101							

INSERT INTO [dbo].[Dep_StakeLevelGroupDetail]
           ([StakeLevelID]
           ,[GameTypeID]
           ,[MinLabel]
           ,[MaxLabel]
           ,[MinStake]
           ,[MaxStake])
SELECT s.StakeLevelID, t.GameTypeID,t.MinLabel, t.MaxLabel, t.MinStake, t.MaxStake
FROM dbo.Dep_StakeLevel s WITH(NOLOCK)
	CROSS APPLY (SELECT * FROM #tmpStake t WHERE t.exchangeid = s.exchangeid) t
WHERE s.GameTypeID = 4101
