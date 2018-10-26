/*
	Date: 2018-10-25
	Created: Johnson
	Task: add global setting for UUS for credit
	DB: DBCUST/CUSTDB
*/

SELECT 	6	GroupID,	4101	GameTypeID,	20	ExchangeID,	'0.01'	MinLabel,	'100.00'	MaxLabel,	0.01	MinStake,	100.00	MaxStake--	UUS	as currency
INTO #tmpStake
UNION SELECT 	6	,	4102	,	20	,	'0.25'	,	'50.00'	,	0.25	,	50.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4103	,	20	,	'0.03'	,	'30.00'	,	0.03	,	30.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4104	,	20	,	'0.03'	,	'60.00'	,	0.03	,	60.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4105	,	20	,	'0.05'	,	'10.00'	,	0.05	,	10.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4106	,	20	,	'0.07'	,	'1.40'	,	0.07	,	1.40	--		as code	UUS	as currency
UNION SELECT 	6	,	4107	,	20	,	'0.07'	,	'21.00'	,	0.07	,	21.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4108	,	20	,	'0.09'	,	'45.00'	,	0.09	,	45.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4109	,	20	,	'0.15'	,	'30.00'	,	0.15	,	30.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4110	,	20	,	'0.15'	,	'15.00'	,	0.15	,	15.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4111	,	20	,	'0.20'	,	'4.00'	,	0.20	,	4.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4112	,	20	,	'0.60'	,	'20.00'	,	0.60	,	20.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4113	,	20	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4114	,	20	,	'0.25'	,	'25.00'	,	0.25	,	25.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4115	,	20	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4116	,	20	,	'0.25'	,	'7.50'	,	0.25	,	7.50	--		as code	UUS	as currency
UNION SELECT 	6	,	4117	,	20	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4118	,	20	,	'0.25'	,	'25.00'	,	0.25	,	25.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4119	,	20	,	'0.38'	,	'38.00'	,	0.38	,	38.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4120	,	20	,	'0.50'	,	'50.00'	,	0.50	,	50.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4121	,	20	,	'0.05'	,	'250.00'	,	0.05	,	250.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4122	,	20	,	'0.25'	,	'50.00'	,	0.25	,	50.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4123	,	20	,	'0.20'	,	'20.00'	,	0.20	,	20.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4124	,	20	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4125	,	20	,	'0.15'	,	'30.00'	,	0.15	,	30.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4126	,	20	,	'0.13'	,	'65.00'	,	0.13	,	65.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4127	,	20	,	'0.20'	,	'20.00'	,	0.20	,	20.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4128	,	20	,	'0.25'	,	'25.00'	,	0.25	,	25.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4129	,	20	,	'0.05'	,	'10.00'	,	0.05	,	10.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4130	,	20	,	'0.25'	,	'25.00'	,	0.25	,	25.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4131	,	20	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4132	,	20	,	'0.50'	,	'10.00'	,	0.50	,	10.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4133	,	20	,	'0.25'	,	'25.00'	,	0.25	,	25.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4134	,	20	,	'0.03'	,	'30.00'	,	0.03	,	30.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4135	,	20	,	'0.50'	,	'15.00'	,	0.50	,	15.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4136	,	20	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4137	,	20	,	'0.50'	,	'150.00'	,	0.50	,	150.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4138	,	20	,	'0.50'	,	'150.00'	,	0.50	,	150.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4139	,	20	,	'0.30'	,	'15.00'	,	0.30	,	15.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4140	,	20	,	'0.40'	,	'40.00'	,	0.40	,	40.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4141	,	20	,	'0.50'	,	'150.00'	,	0.50	,	150.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4142	,	20	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4143	,	20	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4144	,	20	,	'0.09'	,	'18.00'	,	0.09	,	18.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4145	,	20	,	'0.13'	,	'65.00'	,	0.13	,	65.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4146	,	20	,	'0.15'	,	'30.00'	,	0.15	,	30.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4147	,	20	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4148	,	20	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4149	,	20	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4150	,	20	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4151	,	20	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4152	,	20	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4153	,	20	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4154	,	20	,	'0.30'	,	'180.00'	,	0.30	,	180.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4155	,	20	,	'0.25'	,	'25.00'	,	0.25	,	25.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4156	,	20	,	'0.25'	,	'25.00'	,	0.25	,	25.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4157	,	20	,	'0.50'	,	'150.00'	,	0.50	,	150.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4158	,	20	,	'0.50'	,	'150.00'	,	0.50	,	150.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4159	,	20	,	'0.09'	,	'45.00'	,	0.09	,	45.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4160	,	20	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4161	,	20	,	'0.10'	,	'150.00'	,	0.10	,	150.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4162	,	20	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4163	,	20	,	'0.05'	,	'100.00'	,	0.05	,	100.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4164	,	20	,	'0.07'	,	'350.00'	,	0.07	,	350.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4165	,	20	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4166	,	20	,	'0.50'	,	'50.00'	,	0.50	,	50.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4167	,	20	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4168	,	20	,	'0.10'	,	'150.00'	,	0.10	,	150.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4169	,	20	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4170	,	20	,	'0.30'	,	'180.00'	,	0.30	,	180.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4171	,	20	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4172	,	20	,	'0.25'	,	'3.00'	,	0.25	,	3.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4173	,	20	,	'0.09'	,	'45.00'	,	0.09	,	45.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4174	,	20	,	'0.20'	,	'20.00'	,	0.20	,	20.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4101	,	20	,	'0.01'	,	'200.00'	,	0.01	,	200.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4102	,	20	,	'0.25'	,	'100.00'	,	0.25	,	100.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4103	,	20	,	'0.03'	,	'60.00'	,	0.03	,	60.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4104	,	20	,	'0.03'	,	'120.00'	,	0.03	,	120.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4105	,	20	,	'0.05'	,	'20.00'	,	0.05	,	20.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4106	,	20	,	'0.07'	,	'2.80'	,	0.07	,	2.80	--		as code	UUS	as currency
UNION SELECT 	7	,	4107	,	20	,	'0.07'	,	'42.00'	,	0.07	,	42.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4108	,	20	,	'0.09'	,	'90.00'	,	0.09	,	90.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4109	,	20	,	'0.15'	,	'60.00'	,	0.15	,	60.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4110	,	20	,	'0.15'	,	'30.00'	,	0.15	,	30.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4111	,	20	,	'0.20'	,	'8.00'	,	0.20	,	8.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4112	,	20	,	'0.60'	,	'40.00'	,	0.60	,	40.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4113	,	20	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4114	,	20	,	'0.25'	,	'50.00'	,	0.25	,	50.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4115	,	20	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4116	,	20	,	'0.25'	,	'15.00'	,	0.25	,	15.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4117	,	20	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4118	,	20	,	'0.25'	,	'50.00'	,	0.25	,	50.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4119	,	20	,	'0.38'	,	'76.00'	,	0.38	,	76.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4120	,	20	,	'0.50'	,	'100.00'	,	0.50	,	100.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4121	,	20	,	'0.05'	,	'500.00'	,	0.05	,	500.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4122	,	20	,	'0.25'	,	'100.00'	,	0.25	,	100.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4123	,	20	,	'0.20'	,	'40.00'	,	0.20	,	40.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4124	,	20	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4125	,	20	,	'0.15'	,	'60.00'	,	0.15	,	60.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4126	,	20	,	'0.13'	,	'130.00'	,	0.13	,	130.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4127	,	20	,	'0.20'	,	'40.00'	,	0.20	,	40.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4128	,	20	,	'0.25'	,	'50.00'	,	0.25	,	50.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4129	,	20	,	'0.05'	,	'20.00'	,	0.05	,	20.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4130	,	20	,	'0.25'	,	'50.00'	,	0.25	,	50.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4131	,	20	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4132	,	20	,	'0.50'	,	'20.00'	,	0.50	,	20.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4133	,	20	,	'0.25'	,	'50.00'	,	0.25	,	50.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4134	,	20	,	'0.03'	,	'60.00'	,	0.03	,	60.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4135	,	20	,	'0.50'	,	'50.00'	,	0.50	,	50.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4136	,	20	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4137	,	20	,	'0.50'	,	'300.00'	,	0.50	,	300.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4138	,	20	,	'0.50'	,	'300.00'	,	0.50	,	300.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4139	,	20	,	'0.30'	,	'30.00'	,	0.30	,	30.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4140	,	20	,	'0.40'	,	'80.00'	,	0.40	,	80.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4141	,	20	,	'0.50'	,	'300.00'	,	0.50	,	300.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4142	,	20	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4143	,	20	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4144	,	20	,	'0.09'	,	'36.00'	,	0.09	,	36.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4145	,	20	,	'0.13'	,	'130.00'	,	0.13	,	130.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4146	,	20	,	'0.15'	,	'60.00'	,	0.15	,	60.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4147	,	20	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4148	,	20	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4149	,	20	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4150	,	20	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4151	,	20	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4152	,	20	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4153	,	20	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4154	,	20	,	'0.30'	,	'360.00'	,	0.30	,	360.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4155	,	20	,	'0.25'	,	'50.00'	,	0.25	,	50.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4156	,	20	,	'0.25'	,	'50.00'	,	0.25	,	50.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4157	,	20	,	'0.50'	,	'300.00'	,	0.50	,	300.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4158	,	20	,	'0.50'	,	'300.00'	,	0.50	,	300.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4159	,	20	,	'0.09'	,	'90.00'	,	0.09	,	90.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4160	,	20	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4161	,	20	,	'0.10'	,	'300.00'	,	0.10	,	300.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4162	,	20	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4163	,	20	,	'0.05'	,	'200.00'	,	0.05	,	200.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4164	,	20	,	'0.07'	,	'700.00'	,	0.07	,	700.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4165	,	20	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4166	,	20	,	'0.50'	,	'100.00'	,	0.50	,	100.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4167	,	20	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4168	,	20	,	'0.10'	,	'300.00'	,	0.10	,	300.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4169	,	20	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4170	,	20	,	'0.30'	,	'360.00'	,	0.30	,	360.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4171	,	20	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4172	,	20	,	'0.25'	,	'5.00'	,	0.25	,	5.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4173	,	20	,	'0.09'	,	'90.00'	,	0.09	,	90.00	--		as code	UUS	as currency
UNION SELECT 	7	,	4174	,	20	,	'0.20'	,	'40.00'	,	0.20	,	40.00	--		as code	UUS	as currency
UNION SELECT 	6	,	4101	,	72	,	'0.01'	,	'100.00'	,	0.01	,	100.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4102	,	72	,	'0.25'	,	'50.00'	,	0.25	,	50.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4103	,	72	,	'0.03'	,	'30.00'	,	0.03	,	30.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4104	,	72	,	'0.03'	,	'60.00'	,	0.03	,	60.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4105	,	72	,	'0.05'	,	'10.00'	,	0.05	,	10.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4106	,	72	,	'0.07'	,	'1.40'	,	0.07	,	1.40	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4107	,	72	,	'0.07'	,	'21.00'	,	0.07	,	21.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4108	,	72	,	'0.09'	,	'45.00'	,	0.09	,	45.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4109	,	72	,	'0.15'	,	'30.00'	,	0.15	,	30.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4110	,	72	,	'0.15'	,	'15.00'	,	0.15	,	15.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4111	,	72	,	'0.20'	,	'4.00'	,	0.20	,	4.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4112	,	72	,	'0.60'	,	'20.00'	,	0.60	,	20.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4113	,	72	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4114	,	72	,	'0.25'	,	'25.00'	,	0.25	,	25.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4115	,	72	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4116	,	72	,	'0.25'	,	'7.50'	,	0.25	,	7.50	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4117	,	72	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4118	,	72	,	'0.25'	,	'25.00'	,	0.25	,	25.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4119	,	72	,	'0.38'	,	'38.00'	,	0.38	,	38.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4120	,	72	,	'0.50'	,	'50.00'	,	0.50	,	50.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4121	,	72	,	'0.05'	,	'250.00'	,	0.05	,	250.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4122	,	72	,	'0.25'	,	'50.00'	,	0.25	,	50.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4123	,	72	,	'0.20'	,	'20.00'	,	0.20	,	20.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4124	,	72	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4125	,	72	,	'0.15'	,	'30.00'	,	0.15	,	30.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4126	,	72	,	'0.13'	,	'65.00'	,	0.13	,	65.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4127	,	72	,	'0.20'	,	'20.00'	,	0.20	,	20.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4128	,	72	,	'0.25'	,	'25.00'	,	0.25	,	25.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4129	,	72	,	'0.05'	,	'10.00'	,	0.05	,	10.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4130	,	72	,	'0.25'	,	'25.00'	,	0.25	,	25.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4131	,	72	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4132	,	72	,	'0.50'	,	'10.00'	,	0.50	,	10.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4133	,	72	,	'0.25'	,	'25.00'	,	0.25	,	25.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4134	,	72	,	'0.03'	,	'30.00'	,	0.03	,	30.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4135	,	72	,	'0.50'	,	'15.00'	,	0.50	,	15.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4136	,	72	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4137	,	72	,	'0.50'	,	'150.00'	,	0.50	,	150.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4138	,	72	,	'0.50'	,	'150.00'	,	0.50	,	150.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4139	,	72	,	'0.30'	,	'15.00'	,	0.30	,	15.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4140	,	72	,	'0.40'	,	'40.00'	,	0.40	,	40.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4141	,	72	,	'0.50'	,	'150.00'	,	0.50	,	150.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4142	,	72	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4143	,	72	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4144	,	72	,	'0.09'	,	'18.00'	,	0.09	,	18.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4145	,	72	,	'0.13'	,	'65.00'	,	0.13	,	65.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4146	,	72	,	'0.15'	,	'30.00'	,	0.15	,	30.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4147	,	72	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4148	,	72	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4149	,	72	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4150	,	72	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4151	,	72	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4152	,	72	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4153	,	72	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4154	,	72	,	'0.30'	,	'180.00'	,	0.30	,	180.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4155	,	72	,	'0.25'	,	'25.00'	,	0.25	,	25.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4156	,	72	,	'0.25'	,	'25.00'	,	0.25	,	25.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4157	,	72	,	'0.50'	,	'150.00'	,	0.50	,	150.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4158	,	72	,	'0.50'	,	'150.00'	,	0.50	,	150.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4159	,	72	,	'0.09'	,	'45.00'	,	0.09	,	45.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4160	,	72	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4161	,	72	,	'0.10'	,	'150.00'	,	0.10	,	150.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4162	,	72	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4163	,	72	,	'0.05'	,	'100.00'	,	0.05	,	100.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4164	,	72	,	'0.07'	,	'350.00'	,	0.07	,	350.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4165	,	72	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4166	,	72	,	'0.50'	,	'50.00'	,	0.50	,	50.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4167	,	72	,	'0.25'	,	'75.00'	,	0.25	,	75.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4168	,	72	,	'0.10'	,	'150.00'	,	0.10	,	150.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4169	,	72	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4170	,	72	,	'0.30'	,	'180.00'	,	0.30	,	180.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4171	,	72	,	'0.20'	,	'100.00'	,	0.20	,	100.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4172	,	72	,	'0.25'	,	'3.00'	,	0.25	,	3.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4173	,	72	,	'0.09'	,	'45.00'	,	0.09	,	45.00	--	YNG	as code	YNG	as currency
UNION SELECT 	6	,	4174	,	72	,	'0.20'	,	'20.00'	,	0.20	,	20.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4101	,	72	,	'0.01'	,	'200.00'	,	0.01	,	200.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4102	,	72	,	'0.25'	,	'100.00'	,	0.25	,	100.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4103	,	72	,	'0.03'	,	'60.00'	,	0.03	,	60.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4104	,	72	,	'0.03'	,	'120.00'	,	0.03	,	120.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4105	,	72	,	'0.05'	,	'20.00'	,	0.05	,	20.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4106	,	72	,	'0.07'	,	'2.80'	,	0.07	,	2.80	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4107	,	72	,	'0.07'	,	'42.00'	,	0.07	,	42.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4108	,	72	,	'0.09'	,	'90.00'	,	0.09	,	90.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4109	,	72	,	'0.15'	,	'60.00'	,	0.15	,	60.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4110	,	72	,	'0.15'	,	'30.00'	,	0.15	,	30.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4111	,	72	,	'0.20'	,	'8.00'	,	0.20	,	8.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4112	,	72	,	'0.60'	,	'40.00'	,	0.60	,	40.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4113	,	72	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4114	,	72	,	'0.25'	,	'50.00'	,	0.25	,	50.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4115	,	72	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4116	,	72	,	'0.25'	,	'15.00'	,	0.25	,	15.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4117	,	72	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4118	,	72	,	'0.25'	,	'50.00'	,	0.25	,	50.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4119	,	72	,	'0.38'	,	'76.00'	,	0.38	,	76.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4120	,	72	,	'0.50'	,	'100.00'	,	0.50	,	100.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4121	,	72	,	'0.05'	,	'500.00'	,	0.05	,	500.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4122	,	72	,	'0.25'	,	'100.00'	,	0.25	,	100.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4123	,	72	,	'0.20'	,	'40.00'	,	0.20	,	40.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4124	,	72	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4125	,	72	,	'0.15'	,	'60.00'	,	0.15	,	60.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4126	,	72	,	'0.13'	,	'130.00'	,	0.13	,	130.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4127	,	72	,	'0.20'	,	'40.00'	,	0.20	,	40.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4128	,	72	,	'0.25'	,	'50.00'	,	0.25	,	50.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4129	,	72	,	'0.05'	,	'20.00'	,	0.05	,	20.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4130	,	72	,	'0.25'	,	'50.00'	,	0.25	,	50.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4131	,	72	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4132	,	72	,	'0.50'	,	'20.00'	,	0.50	,	20.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4133	,	72	,	'0.25'	,	'50.00'	,	0.25	,	50.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4134	,	72	,	'0.03'	,	'60.00'	,	0.03	,	60.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4135	,	72	,	'0.50'	,	'50.00'	,	0.50	,	50.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4136	,	72	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4137	,	72	,	'0.50'	,	'300.00'	,	0.50	,	300.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4138	,	72	,	'0.50'	,	'300.00'	,	0.50	,	300.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4139	,	72	,	'0.30'	,	'30.00'	,	0.30	,	30.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4140	,	72	,	'0.40'	,	'80.00'	,	0.40	,	80.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4141	,	72	,	'0.50'	,	'300.00'	,	0.50	,	300.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4142	,	72	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4143	,	72	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4144	,	72	,	'0.09'	,	'36.00'	,	0.09	,	36.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4145	,	72	,	'0.13'	,	'130.00'	,	0.13	,	130.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4146	,	72	,	'0.15'	,	'60.00'	,	0.15	,	60.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4147	,	72	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4148	,	72	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4149	,	72	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4150	,	72	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4151	,	72	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4152	,	72	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4153	,	72	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4154	,	72	,	'0.30'	,	'360.00'	,	0.30	,	360.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4155	,	72	,	'0.25'	,	'50.00'	,	0.25	,	50.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4156	,	72	,	'0.25'	,	'50.00'	,	0.25	,	50.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4157	,	72	,	'0.50'	,	'300.00'	,	0.50	,	300.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4158	,	72	,	'0.50'	,	'300.00'	,	0.50	,	300.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4159	,	72	,	'0.09'	,	'90.00'	,	0.09	,	90.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4160	,	72	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4161	,	72	,	'0.10'	,	'300.00'	,	0.10	,	300.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4162	,	72	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4163	,	72	,	'0.05'	,	'200.00'	,	0.05	,	200.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4164	,	72	,	'0.07'	,	'700.00'	,	0.07	,	700.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4165	,	72	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4166	,	72	,	'0.50'	,	'100.00'	,	0.50	,	100.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4167	,	72	,	'0.25'	,	'150.00'	,	0.25	,	150.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4168	,	72	,	'0.10'	,	'300.00'	,	0.10	,	300.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4169	,	72	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4170	,	72	,	'0.30'	,	'360.00'	,	0.30	,	360.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4171	,	72	,	'0.20'	,	'200.00'	,	0.20	,	200.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4172	,	72	,	'0.25'	,	'5.00'	,	0.25	,	5.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4173	,	72	,	'0.09'	,	'90.00'	,	0.09	,	90.00	--	YNG	as code	YNG	as currency
UNION SELECT 	7	,	4174	,	72	,	'0.20'	,	'40.00'	,	0.20	,	40.00	--	YNG	as code	YNG	as currency

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



