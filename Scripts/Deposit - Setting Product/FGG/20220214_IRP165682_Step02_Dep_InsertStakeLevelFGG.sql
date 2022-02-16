/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220214@Johnson
	Task: Dep Insert StakeLevel for FGG [Redmine: #165682]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

CREATE TABLE #temp(
	GameTypeID		INT,
	[MinLabel]		VARCHAR(30),
	[MaxLabel]		VARCHAR(30),
	[MinStake]		[decimal](19, 8) NULL,
	[MaxStake]		[decimal](19, 8) NULL,
	[ExchangeId]	[int] 
) ON [PRIMARY]

GO
INSERT #temp (GameTypeID, ExchangeId, MinLabel, MaxLabel, MinStake, MaxStake)
SELECT 	8201	,	13	,	'50'	,	'1,500'	,	50	,	1500	--	RMB
UNION ALL SELECT 	8201	,	13	,	'100'	,	'5,000'	,	100	,	5000	--	RMB
UNION ALL SELECT 	8201	,	13	,	'200'	,	'10,000'	,	200	,	10000	--	RMB
UNION ALL SELECT 	8201	,	66	,	'50'	,	'1,500'	,	50	,	1500	--	YUN
UNION ALL SELECT 	8201	,	66	,	'100'	,	'5,000'	,	100	,	5000	--	YUN
UNION ALL SELECT 	8201	,	66	,	'200'	,	'10,000'	,	200	,	10000	--	YUN
UNION ALL SELECT 	8201	,	12	,	'8'	,	'300'	,	8	,	300	--	GBP
UNION ALL SELECT 	8201	,	12	,	'20'	,	'1,000'	,	20	,	1000	--	GBP
UNION ALL SELECT 	8201	,	6	,	'8'	,	'300'	,	8	,	300	--	EURO
UNION ALL SELECT 	8201	,	6	,	'20'	,	'1,000'	,	20	,	1000	--	EURO
UNION ALL SELECT 	8201	,	15	,	'400'	,	'20,000'	,	400	,	20000	--	IN
UNION ALL SELECT 	8201	,	15	,	'200'	,	'10,000'	,	200	,	10000	--	IN
UNION ALL SELECT 	8201	,	15	,	'20'	,	'2,000'	,	20	,	2000	--	IN
UNION ALL SELECT 	8201	,	45	,	'8,950'	,	'268,500'	,	8950	,	268500	--	Won
UNION ALL SELECT 	8201	,	45	,	'17,900'	,	'895,000'	,	17900	,	895000	--	Won
UNION ALL SELECT 	8201	,	45	,	'35,800'	,	'1,790,000'	,	35800	,	1790000	--	Won
UNION ALL SELECT 	8201	,	69	,	'5'	,	'500'	,	5	,	500	--	MMK
UNION ALL SELECT 	8201	,	69	,	'20'	,	'1,000'	,	20	,	1000	--	MMK
UNION ALL SELECT 	8201	,	69	,	'100'	,	'3,000'	,	100	,	3000	--	MMK
UNION ALL SELECT 	8201	,	2	,	'10'	,	'1,000'	,	10	,	1000	--	RM
UNION ALL SELECT 	8201	,	2	,	'30'	,	'3,000'	,	30	,	3000	--	RM
UNION ALL SELECT 	8201	,	2	,	'50'	,	'5,000'	,	50	,	5000	--	RM
UNION ALL SELECT 	8201	,	4	,	'50'	,	'5,000'	,	50	,	5000	--	TB
UNION ALL SELECT 	8201	,	4	,	'500'	,	'25,000'	,	500	,	25000	--	TB
UNION ALL SELECT 	8201	,	4	,	'1,000'	,	'50,000'	,	1000	,	50000	--	TB
UNION ALL SELECT 	8201	,	51	,	'35'	,	'3,500'	,	35	,	3500	--	INH
UNION ALL SELECT 	8201	,	51	,	'350'	,	'17,500'	,	350	,	17500	--	INH
UNION ALL SELECT 	8201	,	51	,	'700'	,	'35,000'	,	700	,	35000	--	INH
UNION ALL SELECT 	8201	,	20	,	'35'	,	'3,500'	,	35	,	3500	--	UUS
UNION ALL SELECT 	8201	,	20	,	'350'	,	'17,500'	,	350	,	17500	--	UUS
UNION ALL SELECT 	8201	,	20	,	'700'	,	'35,000'	,	700	,	35000	--	UUS
UNION ALL SELECT 	8201	,	35	,	'8'	,	'300'	,	8	,	300	--	$US
UNION ALL SELECT 	8201	,	35	,	'20'	,	'1,000'	,	20	,	1000	--	$US
UNION ALL SELECT 	8201	,	35	,	'40'	,	'20,000'	,	40	,	20000	--	$US
UNION ALL SELECT 	8201	,	96	,	'40'	,	'20,000'	,	40	,	20000	--	USDT
UNION ALL SELECT 	8201	,	96	,	'20'	,	'1,000'	,	20	,	1000	--	USDT
UNION ALL SELECT 	8201	,	96	,	'8'	,	'300'	,	8	,	300	--	USDT
UNION ALL SELECT 	8201	,	61	,	'500'	,	'15,000'	,	500	,	15000	--	INR
UNION ALL SELECT 	8201	,	61	,	'1,000'	,	'50,000'	,	1000	,	50000	--	INR

DELETE S
FROM Dep_StakeLevel S WITH(ROWLOCK) 
WHERE S.GameTypeID = 8201
	AND S.ExchangeId IN (2,4,6,12,13,15,20,35,45,51,61,66,69,96)

DECLARE @MaxStakeLevelID INT
SELECT @MaxStakeLevelID = MAX(StakeLevelID) FROM DEP_StakeLevel WITH(NOLOCK)

INSERT INTO DEP_StakeLevel(
				GameTypeID
				,MinLabel
				,MaxLabel
				,MinStake
				,MaxStake
				,ExchangeId
				,GameGroupID
				,SiteID
				,StakeLevelID
		)
SELECT	t.GameTypeID,
		t.MinLabel,
		t.MaxLabel,
		t.MinStake,
		t.MaxStake,
		ExchangeId,
		GameGroupID = 0,
		s.SiteId,
		StakeLevelID = @MaxStakeLevelID + ROW_NUMBER() OVER(ORDER BY s.SiteId)
FROM #temp t
	CROSS APPLY site s WITH(NOLOCK)
WHERE s.site IN ('spondemo','Macaubet','Aoncash','ITCBet','Athena000','9bet','M8bola','Q8bola','BE7','Unobet','Bolanation')

DROP TABLE #temp