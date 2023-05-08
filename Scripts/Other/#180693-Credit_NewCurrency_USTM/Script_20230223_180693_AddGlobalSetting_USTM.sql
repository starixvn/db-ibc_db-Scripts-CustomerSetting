/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created:	Eden@20230223
	Task:		Set up Set up New Currency USTM for MBC market - part 2[#180693]
	DB:			DBCust/CustDB
*/

DECLARE @ToCurrency INT, @FromCurrency INT

SELECT	@ToCurrency = 11 ,  -- USTM
		@FromCurrency = 64 -- UT

--------------ProductBetSetting
DELETE ProductBetSetting WITH(ROWLOCK) WHERE Currency = @ToCurrency AND Sporttype NOT IN (43,44)

INSERT INTO dbo.ProductBetSetting (Sporttype, Bettype, Currency, MinBet, IsDep, MaxBet, MaxPerMatch, DefaultMinBet, DefaultMaxBet, DefaultMaxPerMatch)
SELECT Sporttype, Bettype, @ToCurrency, MinBet, IsDep, MaxBet, MaxPerMatch, DefaultMinBet, DefaultMaxBet, DefaultMaxPerMatch
FROM ProductBetSetting WITH (NOLOCK)
WHERE Currency = @FromCurrency 
	AND Sporttype NOT IN (43,44) -- already insert

-----------------LossLimit_GlobalSetting
DELETE LossLimit_GlobalSetting WITH(ROWLOCK) WHERE ExchangeId = @ToCurrency

INSERT INTO LossLimit_GlobalSetting(ProductId, ExchangeId, MinLossLimit, DefaultLossLimit)
SELECT ProductId, @ToCurrency, MinLossLimit, DefaultLossLimit
FROM LossLimit_GlobalSetting WITH (NOLOCK)
WHERE ExchangeId = @FromCurrency

-----------------GameLaunchPerCurrency(OneRNG Jackpot)-------------------------
--DELETE GameLaunchPerCurrency WHERE Currency = @ToCurrency

--INSERT INTO GameLaunchPerCurrency(SportType, BetType, Currency, IsLaunched, IsTest)
--SELECT SportType, BetType, @ToCurrency AS Currency, 1 AS IsLaunched, 0 AS IsTest
--FROM GameLaunchPerCurrency WITH (NOLOCK)
--WHERE Currency = @FromCurrency

--------------WinLimit_ProductSettingDetail
DELETE WinLimit_ProductSettingDetail WITH(ROWLOCK) WHERE ExchangeID = @ToCurrency

INSERT INTO dbo.WinLimit_ProductSettingDetail(ProductID, GroupID, ExchangeID, SiteID, LevelID, MaxWinLimit, IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM)
SELECT ProductID, GroupID, @ToCurrency, SiteID, LevelID, MaxWinLimit, IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM
FROM WinLimit_ProductSettingDetail WITH (NOLOCK)
WHERE ExchangeID = @FromCurrency

---------------MaxPayoutGlobalSetting -- already insert
--DELETE MaxPayoutGlobalSetting WITH(ROWLOCK) WHERE Currency = @ToCurrency

--INSERT INTO MaxPayoutGlobalSetting(SportType, BetType,Currency,SingleMatchParlay,Combo2,Combo35,ComboOver6)
--SELECT 1 AS SportType, 9 AS BetType ,@ToCurrency AS Currency, 27000 AS SingleMatchParlay, 40000 AS Combo2, 135000 AS Combo35, 538000 AS ComboOver6 UNION ALL
--SELECT 99 AS SportType, 9 AS BetType ,@ToCurrency AS Currency, 27000 AS SingleMatchParlay, 40000 AS Combo2, 135000 AS Combo35, 538000 AS ComboOver6

-------------ProductLaunchedSiteCurrency - CANSEE
DELETE ProductLaunchedSiteCurrency WITH(ROWLOCK) WHERE Currency = @ToCurrency

INSERT INTO ProductLaunchedSiteCurrency (SportType, SiteID, Currency, IsLaunched, IsTest,BetType,LaunchedLevel)
SELECT SportType, SiteID, @ToCurrency, 0 AS IsLaunched, 0 AS IsTest,BetType,LaunchedLevel
FROM ProductLaunchedSiteCurrency  WITH (NOLOCK)
WHERE Currency = @FromCurrency

-------------ProductStatusSiteCurrency
DELETE ProductStatusSiteCurrency WITH(ROWLOCK) WHERE Currency = @ToCurrency

INSERT INTO ProductStatusSiteCurrency (SportType,BetType,Currency,SiteID,IsHidden,IsDisabled,HasSynced)
SELECT SportType,BetType,@ToCurrency AS Currency,SiteID, IsHidden,IsDisabled,HasSynced
FROM ProductStatusSiteCurrency  WITH (NOLOCK)
WHERE Currency = @FromCurrency

----------SportNonOfferedSiteCurrency
DELETE SportNonOfferedSiteCurrency WITH(ROWLOCK) WHERE Currency = @ToCurrency

INSERT INTO SportNonOfferedSiteCurrency(SportType,BetType,Currency,SiteID )
SELECT SportType,BetType,@ToCurrency,SiteID 
FROM SportNonOfferedSiteCurrency WITH(NOLOCK) 
WHERE Currency = @FromCurrency


--------------PlayCurrencySetting
DELETE PlayCurrencySetting WITH(ROWLOCK) WHERE MemberCurrency = @ToCurrency

INSERT INTO dbo.PlayCurrencySetting(SiteId,SiteName,SportType,MemberCurrency,PlayCurrency,FromDate,ToDate)
SELECT SiteId,SiteName,SportType,@ToCurrency,PlayCurrency,FromDate,ToDate
FROM PlayCurrencySetting WITH (NOLOCK)
WHERE MemberCurrency = @FromCurrency

---------------------Correct Stake label for some special game--------------
CREATE TABLE #StakeLevelGroupDetail(
	[StakeLevelID] [int],
	[GameTypeID] [int],
	[MinLabel] [nvarchar](50) ,
	[MaxLabel] [nvarchar](50) ,
	[MinStake] [decimal](19, 8) ,
	[MaxStake] [decimal](19, 8) ,
	[ParentTypeID] [int] ,
	[MaxGameStake] [decimal](19, 8) ,
 PRIMARY KEY ([StakeLevelID] ASC,[GameTypeID] ASC)
)

INSERT INTO #StakeLevelGroupDetail(
	 StakeLevelID
	,GameTypeID
	,MinLabel
	,MaxLabel
	,MinStake
	,MaxStake
	,ParentTypeID
	,MaxGameStake
)
SELECT StakeLevelID = CASE  WHEN StakeLevelID = 2333 THEN 2456 
							WHEN StakeLevelID = 2334 THEN 2457
							END
	,GameTypeID
	,MinLabel
	,MaxLabel
	,MinStake
	,MaxStake
	,ParentTypeID
	,MaxGameStake
FROM StakeLevelGroupDetail ds WITH (NOLOCK)
WHERE ds.StakeLevelID IN (2333,2334) --(2456,2457)
	AND ds.GameTypeID BETWEEN 2101 and 2299

UPDATE st
SET st.MaxLabel = t.MaxLabel,
	st.MinLabel = t.MinLabel
FROM #StakeLevelGroupDetail t
	INNER JOIN StakeLevelGroupDetail st WITH(ROWLOCK,UPDLOCK)
		ON t.StakeLevelID = st.StakeLevelID
		AND t.GameTypeID = st.GameTypeID
		AND (t.MaxLabel <> st.MaxLabel OR t.MinLabel <> st.MinLabel)

DROP TABLE #StakeLevelGroupDetail


/*
SELECT * FROM ProductBetSetting (NOLOCK) WHERE currency = 11
SELECT * FROM LossLimit_GlobalSetting (NOLOCK) WHERE ExchangeId = 11
SELECT * FROM WinLimit_ProductSettingDetail (NOLOCK) WHERE ExchangeID = 11
SELECT * FROM ProductStatusSiteCurrency (NOLOCK) WHERE currency = 11
SELECT * FROM ProductLaunchedSiteCurrency (NOLOCK) WHERE currency = 11
SELECT * FROM SportNonOfferedSiteCurrency (NOLOCK) WHERE currency = 11
SELECT * FROM PlayCurrencySetting (NOLOCK) WHERE MemberCurrency = 11
*/