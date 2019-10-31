/*
	Created: Eden
	Date: 20191029
	Task: INSERT Global setting for Virtual game CREDIT
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
		  SELECT 13, 245, 4601, 0, 38, NULL, NULL,    1,    0,    0, 1, 1, 1, NULL --Product Status
UNION ALL SELECT 1 , 245, 4601, 0, 38, 90  , NULL, NULL, NULL, NULL, 1, 2, 1, NULL --PT
UNION ALL SELECT 6 , 245, 4601, 0, 38, NULL, NULL, NULL, NULL, NULL, 1, 3, 1, NULL --SMA Win/Loss Limit
UNION ALL SELECT 8 , 245, 4601, 0, 38, NULL, NULL, NULL, NULL, NULL, 2, 4, 1, NULL --Bet Setting

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
	  --AND exchangeID = 20

--> Stake level
INSERT INTO GameGroup(GameGroupID,RefSportType,RefBetType,GroupName,IsDeposit)
SELECT 13, 245, 4601, 'Level 1', 0

DECLARE  @list varchar (max) = 'RM, HKK, KHR, PLN,$US, US$, UT, Yen, PTU, CHF, MKK, MMK, TH, PS, SD$, UUS, YNG,AUD,RMB, CY, YUN, PTH, HK$, DKK, SEK, NOK,IND, IDR, IN, IDD, DDD,THB, TB,WON,INH,INR, RUB,GBP, EURO, EUR,JPY'

INSERT INTO StakeLevel(
	 GameTypeID
	,ExchangeId
	,ResourceId
	,GameGroupID
)
SELECT GameTypeID = 4601
	,ExchangeId = e.exchangeid
	,ResourceId = NULL
	,GameGroupID = 13 --Cred
FROM exchange e WITH(NOLOCK) 
	LEFT JOIN StakeLevel s WITH(NOLOCK) ON e.exchangeid = s.ExchangeId AND s.GameTypeID = 4601
WHERE e.currency IN ( SELECT LTRIM(val) as Currency FROM  dbo.f_StringSplit (@list ,','))
	AND s.ExchangeId IS NULL

GO
