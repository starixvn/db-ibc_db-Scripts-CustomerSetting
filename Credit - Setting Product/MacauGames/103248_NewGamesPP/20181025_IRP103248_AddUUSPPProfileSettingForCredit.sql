/*
	Date: 2018-10-25
	Created: Johnson
	Task: add global setting for UUS for credit
	DB: DBCUST/CUSTDB
*/

SELECT 	6	GroupID,	4101	GameTypeID,	20	ExchangeID,	'0.01'	MinLabel,	'100.00'	MaxLabel,	0.01	MinStake,	100.00	MaxStake--	UUS	as currency
INTO #tmpStake
UNION SELECT 	6	,	4102	,	20	,	'0.25'	,	'50.00'	,	0.25	,	50.00	--	UUS	as currency
UNION SELECT 	6	,	4103	,	20	,	'0.03'	,	'30.00'	,	0.03	,	30.00	--	UUS	as currency
UNION SELECT 	6	,	4104	,	20	,	'0.03'	,	'60.00'	,	0.03	,	60.00	--	UUS	as currency
UNION SELECT 	6	,	4105	,	20	,	'0.05'	,	'10.00'	,	0.05	,	10.00	--	UUS	as currency
UNION SELECT 	6	,	4106	,	20	,	'0.07'	,	'1.40'	,	0.07	,	1.40	--	UUS	as currency
UNION SELECT 	6	,	4107	,	20	,	'0.07'	,	'21.00'	,	0.07	,	21.00	--	UUS	as currency
UNION SELECT 	6	,	4108	,	20	,	'0.09'	,	'45.00'	,	0.09	,	45.00	--	UUS	as currency
UNION SELECT 	6	,	4109	,	20	,	'0.15'	,	'30.00'	,	0.15	,	30.00	--	UUS	as currency
UNION SELECT 	6	,	4110	,	20	,	'0.15'	,	'15.00'	,	0.15	,	15.00	--	UUS	as currency
UNION SELECT 	6	,	4111	,	20	,	'0.20'	,	'4.00'	,	0.20	,	4.00	--	UUS	as currency
UNION SELECT 	6	,	4112	,	20	,	'0.60'	,	'20.00'	,	0.60	,	20.00	--	UUS	as currency
UNION SELECT 	6	,	4113	,	20	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--	UUS	as currency
UNION SELECT 	6	,	4114	,	20	,	'0.25'	,	'25.00'	,	0.25	,	25.00	--	UUS	as currency
UNION SELECT 	6	,	4115	,	20	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--	UUS	as currency
UNION SELECT 	6	,	4116	,	20	,	'0.25'	,	'7.50'	,	0.25	,	7.50	--	UUS	as currency
UNION SELECT 	6	,	4117	,	20	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--	UUS	as currency
UNION SELECT 	6	,	4118	,	20	,	'0.25'	,	'25.00'	,	0.25	,	25.00	--	UUS	as currency
UNION SELECT 	6	,	4119	,	20	,	'0.38'	,	'38.00'	,	0.38	,	38.00	--	UUS	as currency
UNION SELECT 	6	,	4120	,	20	,	'0.50'	,	'50.00'	,	0.50	,	50.00	--	UUS	as currency
UNION SELECT 	6	,	4121	,	20	,	'0.05'	,	'250.00'	,	0.05	,	250.00	--	UUS	as currency
UNION SELECT 	6	,	4122	,	20	,	'0.25'	,	'50.00'	,	0.25	,	50.00	--	UUS	as currency
UNION SELECT 	6	,	4123	,	20	,	'0.20'	,	'20.00'	,	0.20	,	20.00	--	UUS	as currency
UNION SELECT 	6	,	4124	,	20	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--	UUS	as currency
UNION SELECT 	6	,	4125	,	20	,	'0.15'	,	'30.00'	,	0.15	,	30.00	--	UUS	as currency
UNION SELECT 	6	,	4126	,	20	,	'0.13'	,	'65.00'	,	0.13	,	65.00	--	UUS	as currency
UNION SELECT 	6	,	4127	,	20	,	'0.20'	,	'20.00'	,	0.20	,	20.00	--	UUS	as currency
UNION SELECT 	6	,	4128	,	20	,	'0.25'	,	'25.00'	,	0.25	,	25.00	--	UUS	as currency
UNION SELECT 	6	,	4129	,	20	,	'0.05'	,	'10.00'	,	0.05	,	10.00	--	UUS	as currency
UNION SELECT 	6	,	4130	,	20	,	'0.25'	,	'25.00'	,	0.25	,	25.00	--	UUS	as currency
UNION SELECT 	6	,	4131	,	20	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--	UUS	as currency
UNION SELECT 	6	,	4132	,	20	,	'0.50'	,	'10.00'	,	0.50	,	10.00	--	UUS	as currency
UNION SELECT 	6	,	4133	,	20	,	'0.25'	,	'25.00'	,	0.25	,	25.00	--	UUS	as currency
UNION SELECT 	6	,	4134	,	20	,	'0.03'	,	'30.00'	,	0.03	,	30.00	--	UUS	as currency
UNION SELECT 	6	,	4135	,	20	,	'0.50'	,	'15.00'	,	0.50	,	15.00	--	UUS	as currency
UNION SELECT 	6	,	4136	,	20	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--	UUS	as currency
UNION SELECT 	6	,	4137	,	20	,	'0.50'	,	'150.00'	,	0.50	,	150.00	--	UUS	as currency
UNION SELECT 	6	,	4138	,	20	,	'0.50'	,	'150.00'	,	0.50	,	150.00	--	UUS	as currency
UNION SELECT 	6	,	4139	,	20	,	'0.30'	,	'15.00'	,	0.30	,	15.00	--	UUS	as currency
UNION SELECT 	6	,	4140	,	20	,	'0.40'	,	'40.00'	,	0.40	,	40.00	--	UUS	as currency
UNION SELECT 	6	,	4141	,	20	,	'0.50'	,	'150.00'	,	0.50	,	150.00	--	UUS	as currency
UNION SELECT 	6	,	4142	,	20	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--	UUS	as currency
UNION SELECT 	6	,	4143	,	20	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--	UUS	as currency
UNION SELECT 	6	,	4144	,	20	,	'0.09'	,	'18.00'	,	0.09	,	18.00	--	UUS	as currency
UNION SELECT 	6	,	4145	,	20	,	'0.13'	,	'65.00'	,	0.13	,	65.00	--	UUS	as currency
UNION SELECT 	6	,	4146	,	20	,	'0.15'	,	'30.00'	,	0.15	,	30.00	--	UUS	as currency
UNION SELECT 	6	,	4147	,	20	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--	UUS	as currency
UNION SELECT 	6	,	4148	,	20	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--	UUS	as currency
UNION SELECT 	6	,	4149	,	20	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--	UUS	as currency
UNION SELECT 	6	,	4150	,	20	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--	UUS	as currency
UNION SELECT 	6	,	4151	,	20	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--	UUS	as currency
UNION SELECT 	6	,	4152	,	20	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--	UUS	as currency
UNION SELECT 	6	,	4153	,	20	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--	UUS	as currency
UNION SELECT 	6	,	4154	,	20	,	'0.30'	,	'180.00'	,	0.30	,	180.00	--	UUS	as currency
UNION SELECT 	6	,	4155	,	20	,	'0.25'	,	'25.00'	,	0.25	,	25.00	--	UUS	as currency
UNION SELECT 	6	,	4156	,	20	,	'0.25'	,	'25.00'	,	0.25	,	25.00	--	UUS	as currency
UNION SELECT 	6	,	4157	,	20	,	'0.50'	,	'150.00'	,	0.50	,	150.00	--	UUS	as currency
UNION SELECT 	6	,	4158	,	20	,	'0.50'	,	'150.00'	,	0.50	,	150.00	--	UUS	as currency
UNION SELECT 	6	,	4159	,	20	,	'0.09'	,	'45.00'	,	0.09	,	45.00	--	UUS	as currency
UNION SELECT 	6	,	4160	,	20	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--	UUS	as currency
UNION SELECT 	6	,	4161	,	20	,	'0.10'	,	'150.00'	,	0.10	,	150.00	--	UUS	as currency
UNION SELECT 	6	,	4162	,	20	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--	UUS	as currency
UNION SELECT 	6	,	4163	,	20	,	'0.05'	,	'100.00'	,	0.05	,	100.00	--	UUS	as currency
UNION SELECT 	6	,	4164	,	20	,	'0.07'	,	'350.00'	,	0.07	,	350.00	--	UUS	as currency
UNION SELECT 	6	,	4165	,	20	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--	UUS	as currency
UNION SELECT 	6	,	4166	,	20	,	'0.50'	,	'50.00'	,	0.50	,	50.00	--	UUS	as currency
UNION SELECT 	6	,	4167	,	20	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--	UUS	as currency
UNION SELECT 	6	,	4168	,	20	,	'0.10'	,	'150.00'	,	0.10	,	150.00	--	UUS	as currency
UNION SELECT 	6	,	4169	,	20	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--	UUS	as currency
UNION SELECT 	6	,	4170	,	20	,	'0.30'	,	'180.00'	,	0.30	,	180.00	--	UUS	as currency
UNION SELECT 	6	,	4171	,	20	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--	UUS	as currency
UNION SELECT 	6	,	4172	,	20	,	'0.25'	,	'3.00'	,	0.25	,	3.00	--	UUS	as currency
UNION SELECT 	6	,	4173	,	20	,	'0.09'	,	'45.00'	,	0.09	,	45.00	--	UUS	as currency
UNION SELECT 	6	,	4174	,	20	,	'0.20'	,	'20.00'	,	0.20	,	20.00	--	UUS	as currency
UNION SELECT 	7	,	4101	,	20	,	'0.01'	,	'200.00'	,	0.01	,	200.00	--	UUS	as currency
UNION SELECT 	7	,	4102	,	20	,	'0.25'	,	'100.00'	,	0.25	,	100.00	--	UUS	as currency
UNION SELECT 	7	,	4103	,	20	,	'0.03'	,	'60.00'	,	0.03	,	60.00	--	UUS	as currency
UNION SELECT 	7	,	4104	,	20	,	'0.03'	,	'120.00'	,	0.03	,	120.00	--	UUS	as currency
UNION SELECT 	7	,	4105	,	20	,	'0.05'	,	'20.00'	,	0.05	,	20.00	--	UUS	as currency
UNION SELECT 	7	,	4106	,	20	,	'0.07'	,	'2.80'	,	0.07	,	2.80	--	UUS	as currency
UNION SELECT 	7	,	4107	,	20	,	'0.07'	,	'42.00'	,	0.07	,	42.00	--	UUS	as currency
UNION SELECT 	7	,	4108	,	20	,	'0.09'	,	'90.00'	,	0.09	,	90.00	--	UUS	as currency
UNION SELECT 	7	,	4109	,	20	,	'0.15'	,	'60.00'	,	0.15	,	60.00	--	UUS	as currency
UNION SELECT 	7	,	4110	,	20	,	'0.15'	,	'30.00'	,	0.15	,	30.00	--	UUS	as currency
UNION SELECT 	7	,	4111	,	20	,	'0.20'	,	'8.00'	,	0.20	,	8.00	--	UUS	as currency
UNION SELECT 	7	,	4112	,	20	,	'0.60'	,	'40.00'	,	0.60	,	40.00	--	UUS	as currency
UNION SELECT 	7	,	4113	,	20	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--	UUS	as currency
UNION SELECT 	7	,	4114	,	20	,	'0.25'	,	'50.00'	,	0.25	,	50.00	--	UUS	as currency
UNION SELECT 	7	,	4115	,	20	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--	UUS	as currency
UNION SELECT 	7	,	4116	,	20	,	'0.25'	,	'15.00'	,	0.25	,	15.00	--	UUS	as currency
UNION SELECT 	7	,	4117	,	20	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--	UUS	as currency
UNION SELECT 	7	,	4118	,	20	,	'0.25'	,	'50.00'	,	0.25	,	50.00	--	UUS	as currency
UNION SELECT 	7	,	4119	,	20	,	'0.38'	,	'76.00'	,	0.38	,	76.00	--	UUS	as currency
UNION SELECT 	7	,	4120	,	20	,	'0.50'	,	'100.00'	,	0.50	,	100.00	--	UUS	as currency
UNION SELECT 	7	,	4121	,	20	,	'0.05'	,	'500.00'	,	0.05	,	500.00	--	UUS	as currency
UNION SELECT 	7	,	4122	,	20	,	'0.25'	,	'100.00'	,	0.25	,	100.00	--	UUS	as currency
UNION SELECT 	7	,	4123	,	20	,	'0.20'	,	'40.00'	,	0.20	,	40.00	--	UUS	as currency
UNION SELECT 	7	,	4124	,	20	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--	UUS	as currency
UNION SELECT 	7	,	4125	,	20	,	'0.15'	,	'60.00'	,	0.15	,	60.00	--	UUS	as currency
UNION SELECT 	7	,	4126	,	20	,	'0.13'	,	'130.00'	,	0.13	,	130.00	--	UUS	as currency
UNION SELECT 	7	,	4127	,	20	,	'0.20'	,	'40.00'	,	0.20	,	40.00	--	UUS	as currency
UNION SELECT 	7	,	4128	,	20	,	'0.25'	,	'50.00'	,	0.25	,	50.00	--	UUS	as currency
UNION SELECT 	7	,	4129	,	20	,	'0.05'	,	'20.00'	,	0.05	,	20.00	--	UUS	as currency
UNION SELECT 	7	,	4130	,	20	,	'0.25'	,	'50.00'	,	0.25	,	50.00	--	UUS	as currency
UNION SELECT 	7	,	4131	,	20	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--	UUS	as currency
UNION SELECT 	7	,	4132	,	20	,	'0.50'	,	'20.00'	,	0.50	,	20.00	--	UUS	as currency
UNION SELECT 	7	,	4133	,	20	,	'0.25'	,	'50.00'	,	0.25	,	50.00	--	UUS	as currency
UNION SELECT 	7	,	4134	,	20	,	'0.03'	,	'60.00'	,	0.03	,	60.00	--	UUS	as currency
UNION SELECT 	7	,	4135	,	20	,	'0.50'	,	'50.00'	,	0.50	,	50.00	--	UUS	as currency
UNION SELECT 	7	,	4136	,	20	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--	UUS	as currency
UNION SELECT 	7	,	4137	,	20	,	'0.50'	,	'300.00'	,	0.50	,	300.00	--	UUS	as currency
UNION SELECT 	7	,	4138	,	20	,	'0.50'	,	'300.00'	,	0.50	,	300.00	--	UUS	as currency
UNION SELECT 	7	,	4139	,	20	,	'0.30'	,	'30.00'	,	0.30	,	30.00	--	UUS	as currency
UNION SELECT 	7	,	4140	,	20	,	'0.40'	,	'80.00'	,	0.40	,	80.00	--	UUS	as currency
UNION SELECT 	7	,	4141	,	20	,	'0.50'	,	'300.00'	,	0.50	,	300.00	--	UUS	as currency
UNION SELECT 	7	,	4142	,	20	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--	UUS	as currency
UNION SELECT 	7	,	4143	,	20	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--	UUS	as currency
UNION SELECT 	7	,	4144	,	20	,	'0.09'	,	'36.00'	,	0.09	,	36.00	--	UUS	as currency
UNION SELECT 	7	,	4145	,	20	,	'0.13'	,	'130.00'	,	0.13	,	130.00	--	UUS	as currency
UNION SELECT 	7	,	4146	,	20	,	'0.15'	,	'60.00'	,	0.15	,	60.00	--	UUS	as currency
UNION SELECT 	7	,	4147	,	20	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--	UUS	as currency
UNION SELECT 	7	,	4148	,	20	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--	UUS	as currency
UNION SELECT 	7	,	4149	,	20	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--	UUS	as currency
UNION SELECT 	7	,	4150	,	20	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--	UUS	as currency
UNION SELECT 	7	,	4151	,	20	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--	UUS	as currency
UNION SELECT 	7	,	4152	,	20	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--	UUS	as currency
UNION SELECT 	7	,	4153	,	20	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--	UUS	as currency
UNION SELECT 	7	,	4154	,	20	,	'0.30'	,	'360.00'	,	0.30	,	360.00	--	UUS	as currency
UNION SELECT 	7	,	4155	,	20	,	'0.25'	,	'50.00'	,	0.25	,	50.00	--	UUS	as currency
UNION SELECT 	7	,	4156	,	20	,	'0.25'	,	'50.00'	,	0.25	,	50.00	--	UUS	as currency
UNION SELECT 	7	,	4157	,	20	,	'0.50'	,	'300.00'	,	0.50	,	300.00	--	UUS	as currency
UNION SELECT 	7	,	4158	,	20	,	'0.50'	,	'300.00'	,	0.50	,	300.00	--	UUS	as currency
UNION SELECT 	7	,	4159	,	20	,	'0.09'	,	'90.00'	,	0.09	,	90.00	--	UUS	as currency
UNION SELECT 	7	,	4160	,	20	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--	UUS	as currency
UNION SELECT 	7	,	4161	,	20	,	'0.10'	,	'300.00'	,	0.10	,	300.00	--	UUS	as currency
UNION SELECT 	7	,	4162	,	20	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--	UUS	as currency
UNION SELECT 	7	,	4163	,	20	,	'0.05'	,	'200.00'	,	0.05	,	200.00	--	UUS	as currency
UNION SELECT 	7	,	4164	,	20	,	'0.07'	,	'700.00'	,	0.07	,	700.00	--	UUS	as currency
UNION SELECT 	7	,	4165	,	20	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--	UUS	as currency
UNION SELECT 	7	,	4166	,	20	,	'0.50'	,	'100.00'	,	0.50	,	100.00	--	UUS	as currency
UNION SELECT 	7	,	4167	,	20	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--	UUS	as currency
UNION SELECT 	7	,	4168	,	20	,	'0.10'	,	'300.00'	,	0.10	,	300.00	--	UUS	as currency
UNION SELECT 	7	,	4169	,	20	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--	UUS	as currency
UNION SELECT 	7	,	4170	,	20	,	'0.30'	,	'360.00'	,	0.30	,	360.00	--	UUS	as currency
UNION SELECT 	7	,	4171	,	20	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--	UUS	as currency
UNION SELECT 	7	,	4172	,	20	,	'0.25'	,	'5.00'	,	0.25	,	5.00	--	UUS	as currency
UNION SELECT 	7	,	4173	,	20	,	'0.09'	,	'90.00'	,	0.09	,	90.00	--	UUS	as currency
UNION SELECT 	7	,	4174	,	20	,	'0.20'	,	'40.00'	,	0.20	,	40.00	--	UUS	as currency



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



