/*
	Created: Eden
	Date: 20191029
	Task: INSERT Global setting for Virtual game DEPOSIT
	DB: DBCust/CustDB
*/
--> Dep_ProductStatusProfile
INSERT INTO Dep_ProductStatusProfile(Sporttype,Bettype,bitmapOrder)
SELECT 245,4601,11

GO
DECLARE @MaxProductSettingID INT
SELECT @MaxProductSettingID = MAX(ProductSettingID) FROM Dep_ProductSetting WITH(NOLOCK)
SELECT @MaxProductSettingID

-->Dep_ProductSetting
INSERT INTO Dep_ProductSetting (
	 ProductSettingID
	,ProductID
	,SettingType
	,TemplateID
	,DisplayOrder
	,SettingLevel
	)
	  SELECT @MaxProductSettingID + 1 , 38, 4, 0, 1, 1 --Product Status
UNION SELECT @MaxProductSettingID + 2 , 38, 1, 0, 2, 1 --PT
UNION SELECT @MaxProductSettingID + 3 , 38, 8, 0, 3, 2 --BetLimit

-->Dep_ProductSettingDetail
INSERT INTO Dep_ProductSettingDetail(
	 ProductSettingID
	,SportType
	,BetType
	,IsLive
	,MaxDefaultValue
	,SettingStatus
	,MinDefaultValue
	,IsApplyBA
	)
	  SELECT @MaxProductSettingID + 1 , 245, 4601, 0, 0, 1, NULL, 0
UNION SELECT @MaxProductSettingID + 2 , 245, 4601, 0, 0, 1, NULL, 0
UNION SELECT @MaxProductSettingID + 3 , 245, 4601, 0, 0, 1, NULL, 0

--> Stake level
GO
DECLARE @maxID INT
SELECT @maxID = MAX(GameGroupID) FROM GameGroup WITH(NOLOCK)
INSERT INTO GameGroup(GameGroupID,RefSportType,RefBetType,GroupName,IsDeposit)
SELECT @maxID + 1, 245, 4601, 'Level 1', 1

DECLARE  @list varchar (max) = 'RM, HKK, KHR, PLN,$US, US$, UT, Yen, PTU, CHF, MKK, MMK, TH, PS, SD$, UUS, YNG,AUD,RMB, CY, YUN, PTH, HK$, DKK, SEK, NOK,IND, IDR, IN, IDD, DDD,THB, TB,WON,INH,INR, RUB,GBP, EURO, EUR,JPY'

INSERT INTO DEP_StakeLevel(
	 GameTypeID
	,ExchangeId
	,ResourceId
	,GameGroupID
)
SELECT GameTypeID = 4601
	,ExchangeId = e.exchangeid
	,ResourceId = NULL
	,GameGroupID = @maxID + 1 --DEP
FROM exchange e WITH(NOLOCK) 
	LEFT JOIN DEP_StakeLevel s WITH(NOLOCK) ON e.exchangeid = s.ExchangeId AND s.GameTypeID = 4601
WHERE e.currency IN ( SELECT LTRIM(val) as Currency FROM  dbo.f_StringSplit (@list ,','))
	AND s.ExchangeId IS NULL

GO