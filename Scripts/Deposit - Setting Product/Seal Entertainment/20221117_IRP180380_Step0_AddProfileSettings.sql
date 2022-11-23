/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20221117
	Created: Johnson 
	Task: Seal Entertainment - Incorporate to Licensee Sites [redmine : #180380]
	DB: DBCUST/CUSTDB
*/

DELETE Dep_ProductStatusProfile WITH(ROWLOCK) WHERE SportType = 156
DELETE Dep_ProductSetting WITH(ROWLOCK) WHERE ProductSettingID IN (156,157,158)
DELETE Dep_ProductSettingDetail WITH(ROWLOCK) WHERE ProductSettingID IN (156,157,158)
DELETE GameGroup WITH(ROWLOCK) WHERE GameGroupID = 42
DELETE Dep_StakeLevel WITH(ROWLOCK) WHERE GameTypeID = 8900
DELETE Dep_StakeLevelGroupDetail WITH(ROWLOCK) WHERE GameTypeID = 8900
GO

INSERT INTO Dep_ProductStatusProfile(SportType,Bettype,BitmapOrder)
SELECT 156,8900,35

INSERT INTO [dbo].[Dep_ProductSetting]
           ([ProductSettingID]
           ,[ProductID]
           ,[SettingType]
           ,[TemplateID]
           ,[DisplayOrder]
           ,[SettingLevel])
SELECT 156, 72, 4, 0, 1, 1
UNION SELECT 157, 72, 1, 0, 2, 1
UNION SELECT 158, 72, 8, 0, 3, 2
GO

INSERT INTO [dbo].[Dep_ProductSettingDetail]
           ([ProductSettingID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[MaxDefaultValue]
           ,[SettingStatus]
           ,[MinDefaultValue]
           ,[IsApplyBA])
SELECT 156, 156, 8900, 0, 0, 1, NULL, 0
UNION SELECT 157, 156, 8900, 0, 0, 1, NULL, 0
UNION SELECT 158, 156, 8900, 0, 0, 1, NULL, 0
GO

INSERT INTO [dbo].[GameGroup]
           ([GameGroupID]
           ,[RefSportType]
           ,[RefBetType]
           ,[GroupName]
           ,[IsDeposit])
SELECT 42, 156, 8900, 'Level 1', 1
GO

SELECT 	97	exchangeid,	2	minbet,	5000	maxbet,	'2'	minlabel,	'5,000'	maxlabel--	BDT
INTO #tmpSetting
UNION SELECT 	46	,	0.2	,	100	,	'0.2'	,	'100'	--	BND
UNION SELECT 	82	,	0.2	,	200	,	'0.2'	,	'200'	--	BRL
UNION SELECT 	6	,	0.2	,	50	,	'0.2'	,	'50'	--	EURO
UNION SELECT 	12	,	0.2	,	50	,	'0.2'	,	'50'	--	GBP
UNION SELECT 	15	,	0.2	,	1000	,	'0.2'	,	'1,000'	--	IN
UNION SELECT 	51	,	1	,	1000	,	'1'	,	'1,000'	--	INH
UNION SELECT 	61	,	2	,	5000	,	'2'	,	'5,000'	--	INR
UNION SELECT 	32	,	2	,	10000	,	'2'	,	'10,000'	--	JPY
UNION SELECT 	70	,	0.2	,	100	,	'0.2'	,	'100'	--	MKK
UNION SELECT 	49	,	0.2	,	1000	,	'0.2'	,	'1,000'	--	MXN
UNION SELECT 	123	,	2	,	5000	,	'2'	,	'5,000'	--	NPR
UNION SELECT 	121	,	2	,	5000	,	'2'	,	'5,000'	--	PKR
UNION SELECT 	2	,	0.2	,	200	,	'0.2'	,	'200'	--	RM
UNION SELECT 	13	,	0.2	,	200	,	'0.2'	,	'200'	--	RMB
UNION SELECT 	4	,	0.2	,	2000	,	'0.2'	,	'2,000'	--	TB
UNION SELECT 	3	,	0.2	,	100	,	'0.2'	,	'100'	--	US$
UNION SELECT 	96	,	0.2	,	100	,	'0.2'	,	'100'	--	USDT
UNION SELECT 	20	,	0.2	,	100	,	'0.2'	,	'100'	--	UUS
UNION SELECT 	45	,	20	,	100000	,	'20'	,	'100,000'	--	Won

DECLARE @maxStakeLevelID INT 

SELECT @maxStakeLevelID = MAX(StakeLevelID)
FROM Dep_StakeLevel WITH(NOLOCK)

INSERT INTO [dbo].[Dep_StakeLevel]
           ([StakeLevelID]
           ,[GameTypeID]
           ,[GameGroupID]
           ,[MinLabel]
           ,[MaxLabel]
           ,[MinStake]
           ,[MaxStake]
           ,[ExchangeID]
           ,[ResourceId]
           ,[SiteID])
SELECT @maxStakeLevelID + ROW_NUMBER() OVER (ORDER BY exchangeid ASC),
	8900, 42, NULL, NULL, NULL, NULL, exchangeid, NULL, NULL
FROM #tmpSetting		   

INSERT INTO [dbo].[Dep_StakeLevelGroupDetail]
           ([StakeLevelID]
           ,[GameTypeID]
           ,[MinLabel]
           ,[MaxLabel]
           ,[MinStake]
           ,[MaxStake]
           ,[ParentTypeID]
           ,[MaxGameStake])
SELECT s.StakeLevelID, 8900, t.MinLabel, t.MaxLabel, t.MinBet, t.MaxBet, NULL, NULL
FROM Dep_StakeLevel s WITH(NOLOCK)
	INNER JOIN #tmpSetting t ON s.GameTypeID = 8900 AND s.ExchangeID = t.exchangeid