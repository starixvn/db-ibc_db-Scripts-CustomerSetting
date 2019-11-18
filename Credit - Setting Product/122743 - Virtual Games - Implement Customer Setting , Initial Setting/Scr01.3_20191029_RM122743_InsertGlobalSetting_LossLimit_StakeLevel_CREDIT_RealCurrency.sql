/*
	Created: Eden
	Date: 20191029
	Task: INSERT Global setting for Virtual game CREDIT ( Loss Limit , StakeLevel Real Currency)
	DB: DBCust/CustDB
*/
/*
DELETE  
FROM LossLimit_GlobalSetting WITH(ROWLOCK, UPDLOCK)
WHERE ProductID = 38
	AND exchangeID <> 20

DELETE  
FROM StakeLevel WITH(ROWLOCK, UPDLOCK)
WHERE GameTypeID = 4601
	  AND exchangeid <> 20


*/
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
	  AND exchangeID <> 20

--> Stake level
GO
DECLARE  @list varchar (max) = 'RM, HKK, KHR, PLN,$US, US$, UT, Yen, PTU, CHF, MKK, MMK, TH, PS, SD$, YNG,AUD,RMB, CY, YUN, PTH, HK$, DKK, SEK, NOK,IND, IDR, IN, IDD, DDD,THB, TB,WON,INH,INR, RUB,GBP, EURO, EUR,JPY'

INSERT INTO StakeLevel(
	 GameTypeID
	,ExchangeId
	,ResourceId
	,GameGroupID
)
SELECT GameTypeID = 4601
	,ExchangeId = e.exchangeid
	,ResourceId = NULL
	,GameGroupID = gg.GameGroupID --Cred
FROM exchange e WITH(NOLOCK) 
	CROSS APPLY (SELECT GameGroupID FROM GameGroup WITH(NOLOCK) WHERE RefSportType = 245 AND IsDeposit = 0) gg
	LEFT JOIN StakeLevel s WITH(NOLOCK) ON e.exchangeid = s.ExchangeId AND s.GameTypeID = 4601
WHERE e.currency IN ( SELECT LTRIM(val) as Currency FROM  dbo.f_StringSplit (@list ,','))
	AND e.exchangeid <> 20
	AND s.ExchangeId IS NULL

GO
