/*
	Created: Johnson
	Date: 2018-07-26
	Task: add Pragmatic profile for UUS  
	DB: DBCUST/CUSTDB
*/

USE CUSTDB
GO

--insert product setting
INSERT INTO [dbo].[Dep_ProductSetting]
           ([ProductSettingID]
           ,[ProductID]
           ,[SettingType]
           ,[TemplateID]
           ,[DisplayOrder]
           ,[SettingLevel])
SELECT 21,32,1,0,2,1--PT by product
UNION SELECT 22,32,4,0,1,1--status by product
UNION SELECT 23,32,8,0,3,2--StakeLevelGroup by sport
GO

INSERT INTO [dbo].[Dep_ProductSettingDetail]
           ([ProductSettingID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[MaxDefaultValue]
           ,[SettingStatus]
           ,[MinDefaultValue])
SELECT 21,248,4101,0,0,0,NULL
UNION SELECT 22,248,4101,0,0,0,NULL
UNION SELECT 23,248,4101,0,0,0,NULL
GO

--insert status profile
INSERT INTO [dbo].[Dep_ProductStatusProfile]
           ([Sporttype]
           ,[Bettype]
           ,[bitmapOrder])
SELECT 248,4101,8
GO

--Insert gamegroup for stakelevel
INSERT INTO [dbo].[GameGroup]
           ([GameGroupID]
           ,[RefSportType]
           ,[RefBetType]
           ,[GroupName]
           ,[IsDeposit])
SELECT 8,248,4101,'Level 1',1
GO

--Insert Dep_StakeLevel
/*
SELECT max(StakeLevelID)+1
FROM dbo.Dep_StakeLevel WITH(NOLOCK)

CREATE TABLE #Dep_StakeLevel (StakeLevelID INT IDENTITY(495,1)
							,GameTypeID INT
							,GameGroupID INT
							,ExchangeID INT
							)

INSERT INTO #Dep_StakeLevel
SELECT 4101,8, exchangeid
FROM exchange WITH(NOLOCK)
order by exchangeid ASC
							
INSERT INTO [dbo].[Dep_StakeLevel]
           ([StakeLevelID]
           ,[GameTypeID]
           ,[GameGroupID]
           ,[ExchangeID]
           )
SELECT [StakeLevelID]
	   ,[GameTypeID]
	   ,[GameGroupID]
	   ,[ExchangeID] 
FROM #Dep_StakeLevel
*/
INSERT INTO [dbo].[Dep_StakeLevel]
           ([StakeLevelID]
           ,[GameTypeID]
           ,[GameGroupID]
           ,[ExchangeID]
           )
SELECT 	507	,	4101	,	8	,	20

GO

--Insert Dep_StakeLevelGroupDetail
/*INSERT INTO [dbo].[Dep_StakeLevelGroupDetail]
           ([StakeLevelID]
           ,[GameTypeID]
           ,[MinLabel]
           ,[MaxLabel]
           ,[MinStake]
           ,[MaxStake])
SELECT s.StakeLevelID, t.typeid,'1','100',1,100
FROM dbo.Dep_StakeLevel s WITH(NOLOCK)
	CROSS APPLY (SELECT typeid FROM dbtxn.bodb02.dbo.bettype WHERE typeid BETWEEN 4101 AND 4199) t
WHERE GameTypeID = 4101
*/

SELECT 	4101	GameTypeID,	20	exchangeid,	'0.01'	 MinLabel,	'150'	MaxLabel,	0.01	MinStake,	150	MaxStake--	USD	as code	$US	as currency
 INTO #tmpStake
UNION SELECT 	4102	,	20	,	'0.01'	,	'40'	,	0.01	,	40	--	USD	as code	$US	as currency
UNION SELECT 	4103	,	20	,	'0.03'	,	'9'	,	0.03	,	9	--	USD	as code	$US	as currency
UNION SELECT 	4104	,	20	,	'0.03'	,	'30'	,	0.03	,	30	--	USD	as code	$US	as currency
UNION SELECT 	4105	,	20	,	'0.05'	,	'15'	,	0.05	,	15	--	USD	as code	$US	as currency
UNION SELECT 	4106	,	20	,	'0.07'	,	'0.7'	,	0.07	,	0.7	--	USD	as code	$US	as currency
UNION SELECT 	4107	,	20	,	'0.07'	,	'7'	,	0.07	,	7	--	USD	as code	$US	as currency
UNION SELECT 	4108	,	20	,	'0.09'	,	'90'	,	0.09	,	90	--	USD	as code	$US	as currency
UNION SELECT 	4109	,	20	,	'0.15'	,	'22.5'	,	0.15	,	22.5	--	USD	as code	$US	as currency
UNION SELECT 	4110	,	20	,	'0.15'	,	'7.5'	,	0.15	,	7.5	--	USD	as code	$US	as currency
UNION SELECT 	4111	,	20	,	'0.2'	,	'4'	,	0.2	,	4	--	USD	as code	$US	as currency
UNION SELECT 	4112	,	20	,	'0.2'	,	'10'	,	0.2	,	10	--	USD	as code	$US	as currency
UNION SELECT 	4113	,	20	,	'0.25'	,	'50'	,	0.25	,	50	--	USD	as code	$US	as currency
UNION SELECT 	4114	,	20	,	'0.25'	,	'12.5'	,	0.25	,	12.5	--	USD	as code	$US	as currency
UNION SELECT 	4115	,	20	,	'0.25'	,	'75'	,	0.25	,	75	--	USD	as code	$US	as currency
UNION SELECT 	4116	,	20	,	'0.25'	,	'7.5'	,	0.25	,	7.5	--	USD	as code	$US	as currency
UNION SELECT 	4117	,	20	,	'0.25'	,	'150'	,	0.25	,	150	--	USD	as code	$US	as currency
UNION SELECT 	4118	,	20	,	'0.25'	,	'12.5'	,	0.25	,	12.5	--	USD	as code	$US	as currency
UNION SELECT 	4119	,	20	,	'0.38'	,	'38'	,	0.38	,	38	--	USD	as code	$US	as currency
UNION SELECT 	4120	,	20	,	'0.5'	,	'50'	,	0.5	,	50	--	USD	as code	$US	as currency
UNION SELECT 	4121	,	20	,	'0.05'	,	'500'	,	0.05	,	500	--	USD	as code	$US	as currency
UNION SELECT 	4122	,	20	,	'0.25'	,	'12.5'	,	0.25	,	12.5	--	USD	as code	$US	as currency
UNION SELECT 	4123	,	20	,	'0.2'	,	'10'	,	0.2	,	10	--	USD	as code	$US	as currency
UNION SELECT 	4124	,	20	,	'0.25'	,	'50'	,	0.25	,	50	--	USD	as code	$US	as currency
UNION SELECT 	4125	,	20	,	'0.15'	,	'30'	,	0.15	,	30	--	USD	as code	$US	as currency
UNION SELECT 	4126	,	20	,	'0.13'	,	'26'	,	0.13	,	26	--	USD	as code	$US	as currency
UNION SELECT 	4127	,	20	,	'0.2'	,	'10'	,	0.2	,	10	--	USD	as code	$US	as currency
UNION SELECT 	4128	,	20	,	'0.25'	,	'2.5'	,	0.25	,	2.5	--	USD	as code	$US	as currency
UNION SELECT 	4129	,	20	,	'0.05'	,	'15'	,	0.05	,	15	--	USD	as code	$US	as currency
UNION SELECT 	4130	,	20	,	'0.25'	,	'10'	,	0.25	,	10	--	USD	as code	$US	as currency
UNION SELECT 	4131	,	20	,	'0.25'	,	'20'	,	0.25	,	20	--	USD	as code	$US	as currency
UNION SELECT 	4132	,	20	,	'0.5'	,	'5'	,	0.5	,	5	--	USD	as code	$US	as currency
UNION SELECT 	4133	,	20	,	'0.25'	,	'7.5'	,	0.25	,	7.5	--	USD	as code	$US	as currency
UNION SELECT 	4134	,	20	,	'0.03'	,	'6'	,	0.03	,	6	--	USD	as code	$US	as currency
UNION SELECT 	4135	,	20	,	'0.5'	,	'5'	,	0.5	,	5	--	USD	as code	$US	as currency
UNION SELECT 	4136	,	20	,	'0.25'	,	'20'	,	0.25	,	20	--	USD	as code	$US	as currency
UNION SELECT 	4137	,	20	,	'0.5'	,	'25'	,	0.5	,	25	--	USD	as code	$US	as currency
UNION SELECT 	4138	,	20	,	'0.5'	,	'50'	,	0.5	,	50	--	USD	as code	$US	as currency
UNION SELECT 	4139	,	20	,	'0.3'	,	'6'	,	0.3	,	6	--	USD	as code	$US	as currency
UNION SELECT 	4140	,	20	,	'0.4'	,	'8'	,	0.4	,	8	--	USD	as code	$US	as currency
UNION SELECT 	4141	,	20	,	'0.5'	,	'40'	,	0.5	,	40	--	USD	as code	$US	as currency
UNION SELECT 	4142	,	20	,	'0.25'	,	'25'	,	0.25	,	25	--	USD	as code	$US	as currency
UNION SELECT 	4143	,	20	,	'0.25'	,	'25'	,	0.25	,	25	--	USD	as code	$US	as currency
UNION SELECT 	4144	,	20	,	'0.09'	,	'4.5'	,	0.09	,	4.5	--	USD	as code	$US	as currency
UNION SELECT 	4145	,	20	,	'0.13'	,	'26'	,	0.13	,	26	--	USD	as code	$US	as currency
UNION SELECT 	4146	,	20	,	'0.15'	,	'15'	,	0.15	,	15	--	USD	as code	$US	as currency
UNION SELECT 	4147	,	20	,	'0.2'	,	'20'	,	0.2	,	20	--	USD	as code	$US	as currency
UNION SELECT 	4148	,	20	,	'0.2'	,	'20'	,	0.2	,	20	--	USD	as code	$US	as currency
UNION SELECT 	4149	,	20	,	'0.2'	,	'20'	,	0.2	,	20	--	USD	as code	$US	as currency
UNION SELECT 	4150	,	20	,	'0.2'	,	'20'	,	0.2	,	20	--	USD	as code	$US	as currency
UNION SELECT 	4151	,	20	,	'0.2'	,	'20'	,	0.2	,	20	--	USD	as code	$US	as currency
UNION SELECT 	4152	,	20	,	'0.2'	,	'20'	,	0.2	,	20	--	USD	as code	$US	as currency
UNION SELECT 	4153	,	20	,	'0.2'	,	'20'	,	0.2	,	20	--	USD	as code	$US	as currency
UNION SELECT 	4154	,	20	,	'0.3'	,	'30'	,	0.3	,	30	--	USD	as code	$US	as currency
UNION SELECT 	4155	,	20	,	'0.25'	,	'10'	,	0.25	,	10	--	USD	as code	$US	as currency
UNION SELECT 	4156	,	20	,	'0.25'	,	'10'	,	0.25	,	10	--	USD	as code	$US	as currency
UNION SELECT 	4157	,	20	,	'0.5'	,	'40'	,	0.5	,	40	--	USD	as code	$US	as currency
UNION SELECT 	4158	,	20	,	'0.5'	,	'25'	,	0.5	,	25	--	USD	as code	$US	as currency
UNION SELECT 	4159	,	20	,	'0.09'	,	'13.5'	,	0.09	,	13.5	--	USD	as code	$US	as currency
UNION SELECT 	4160	,	20	,	'0.25'	,	'125'	,	0.25	,	125	--	USD	as code	$US	as currency
UNION SELECT 	4161	,	20	,	'0.1'	,	'50'	,	0.1	,	50	--	USD	as code	$US	as currency
UNION SELECT 	4162	,	20	,	'0.2'	,	'16'	,	0.2	,	16	--	USD	as code	$US	as currency
UNION SELECT 	4163	,	20	,	'0.05'	,	'25'	,	0.05	,	25	--	USD	as code	$US	as currency
UNION SELECT 	4164	,	20	,	'0.07'	,	'700'	,	0.07	,	700	--	USD	as code	$US	as currency


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
















