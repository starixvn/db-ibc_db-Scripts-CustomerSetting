/*
	Created: Eden
	Date: 20191029
	Task: INSERT Global setting for Virtual game DEPOSIT  - StakeLevel Real Currency
	DB: DBCust/CustDB
*/
-----------------------------------------------------------------
/*
DELETE  
FROM DEP_StakeLevel WITH(ROWLOCK, UPDLOCK)
WHERE GameTypeID = 4601
	AND ExchangeId <> 20

*/
DECLARE  @list varchar (max) = 'RM, HKK, KHR, PLN,$US, US$, UT, Yen, PTU, CHF, MKK, MMK, TH, PS, SD$, YNG, AUD, RMB, CY, YUN, PTH, HK$, DKK, SEK, NOK,IND, IDR, IN, IDD, DDD,THB, TB, WON, INH, INR, RUB,GBP, EURO, EUR,JPY'
DECLARE @MaxStakeLevelID INT
SELECT @MaxStakeLevelID = MAX(StakeLevelID) FROM DEP_StakeLevel WITH(NOLOCK)

INSERT INTO DEP_StakeLevel(
	 GameTypeID
	,ExchangeId
	,ResourceId
	,GameGroupID
	,StakeLevelID
)
SELECT GameTypeID = 4601
	,ExchangeId = e.exchangeid
	,ResourceId = NULL
	,GameGroupID = gg.GameGroupID --DEP
	,StakeLevelID =  @MaxStakeLevelID + ROW_NUMBER() OVER (ORDER BY e.exchangeID) 
FROM exchange e WITH(NOLOCK) 
	CROSS APPLY (SELECT GameGroupID FROM GameGroup WITH(NOLOCK) WHERE RefSportType = 245 AND IsDeposit = 1) gg
	LEFT JOIN DEP_StakeLevel s WITH(NOLOCK) ON e.exchangeid = s.ExchangeId AND s.GameTypeID = 4601
WHERE e.currency IN ( SELECT LTRIM(val) as Currency FROM  dbo.f_StringSplit (@list ,','))
	AND e.exchangeid <> 20
	AND s.ExchangeId IS NULL

GO