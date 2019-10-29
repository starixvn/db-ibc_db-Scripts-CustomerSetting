/*
	Created: Eden
	Date: 20191029
	Task: INSERT Global setting for Virtual game
	DB: DBCust/CustDB
*/
--> ProductSettingDetail
INSERT INTO ProductSettingDetail(
	 SettingType
	,SportType
	,BetType
	,IsLive
	,ProductID
	,MaxPT
	,MaxDiscount
	,IsSync
	,IsHidden
	,IsDisabled
	,SettingLevel
	,DisplayOrder
	,SettingStatus
	,IntervalValue
	)
		  SELECT 13, 245, 4601, 0, 38, NULL, NULL,    1,    0,    0, 1, 1, 0, NULL
UNION ALL SELECT 1 , 245, 4601, 0, 38, 90  , NULL, NULL, NULL, NULL, 1, 2, 0, NULL
UNION ALL SELECT 6 , 245, 4601, 0, 38, NULL, NULL, NULL, NULL, NULL, 1, 3, 0, NULL
UNION ALL SELECT 8 , 245, 4601, 0, 38, NULL, NULL, NULL, NULL, NULL, 2, 4, 0, NULL

--> ProductStatusProfile
INSERT INTO ProductStatusProfile(Sporttype,Bettype,bitmapOrder)
SELECT 245,4601,20

--> LossLimit_GlobalSetting
INSERT INTO LossLimit_GlobalSetting 
(
	 ProductId
	,ExchangeId
	,MinLossLimit
	,DefaultLossLimit
)
SELECT 38
	,ExchangeId
	,MinLossLimit
	,DefaultLossLimit
FROM LossLimit_GlobalSetting WITH(NOLOCK) 
WHERE ProductId = 22
	  AND exchangeID = 20

--> Stake level
INSERT INTO GameGroup(GameGroupID,RefSportType,RefBetType,GroupName,IsDeposit)
		  SELECT 13, 245, 4601, 'Level 1', 0
UNION ALL SELECT 14, 245, 4601, 'Level 1', 1

INSERT INTO StakeLevel(
	 GameTypeID
	,ExchangeId
	,ResourceId
	,GameGroupID
)
SELECT GameTypeID = 4601
	,ExchangeId = 20
	,ResourceId = NULL
	,GameGroupID = 13 --Credit

INSERT INTO DEP_StakeLevel(
	 StakeLevelID
	,GameTypeID
	,ExchangeId
	,ResourceId
	,GameGroupID
)
SELECT StakeLevelID = MAX(StakeLevelID) + 1
	,GameTypeID = 4601
	,ExchangeId = 20
	,ResourceId = NULL
	,GameGroupID = 14 --DEPOSIT
FROM DEP_StakeLevel WITH(NOLOCK)

