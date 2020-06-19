/*
	Created: 20200619@Elodie
	Task: Initial Betsetting [redmine:#136096]
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO

DECLARE @CurrencyFrom INT = 22, @CurrencyTo INT = 95

INSERT INTO ProductBetSetting(Sporttype, Bettype, Currency, MinBet, IsDep, MaxBet, MaxPerMatch, DefaultMinBet, DefaultMaxBet, DefaultMaxPerMatch)
SELECT Sporttype, Bettype, @CurrencyTo, MinBet, IsDep, MaxBet, MaxPerMatch, DefaultMinBet, DefaultMaxBet, DefaultMaxPerMatch
FROM ProductBetSetting WITH (NOLOCK)
WHERE Currency = @CurrencyFrom

INSERT INTO StakeLevel(GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ExchangeId, ResourceId, GameGroupID)
SELECT GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, @CurrencyTo, NULL, GameGroupID
FROM StakeLevel WITH (NOLOCK)
WHERE ExchangeId = 3 AND GameTypeID <> 1611

INSERT INTO StakeLevelGroupDetail(StakeLevelID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ParentTypeID)
SELECT st.StakeLevelID, sd.GameTypeID, sd.MinLabel, sd.MaxLabel, sd.MinStake, sd.MaxStake, ParentTypeID
FROM StakeLevelGroupDetail sd WITH (NOLOCK)
	INNER JOIN StakeLevel sf WITH (NOLOCK) ON sf.StakeLevelID = sd.StakeLevelID
	INNER JOIN StakeLevel st WITH (NOLOCK) ON sf.GameTypeID = st.GameTypeID
WHERE sf.ExchangeId = 3 AND st.exchangeid = @CurrencyTo
	AND sf.GameTypeID <> 1611

INSERT INTO LossLimit_GlobalSetting(ProductId, ExchangeId, MinLossLimit, DefaultLossLimit)
SELECT ProductId, @CurrencyTo, MinLossLimit, DefaultLossLimit
FROM LossLimit_GlobalSetting WITH (NOLOCK)
WHERE ExchangeId = @CurrencyFrom

INSERT INTO WinLimit_ProductSettingDetail(ProductID, GroupID, ExchangeID, SiteID, LevelID, MaxWinLimit, IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM)
SELECT ProductID, GroupID, @CurrencyTo, SiteID, LevelID, MaxWinLimit, IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM
FROM WinLimit_ProductSettingDetail WITH (NOLOCK)
WHERE ExchangeId = @CurrencyFrom

INSERT INTO GameLaunchPerCurrency(SportType, BetType, Currency, IsLaunched, IsTest)
SELECT SportType, BetType, @CurrencyTo, IsLaunched, IsTest
FROM GameLaunchPerCurrency WITH (NOLOCK)
WHERE Currency = @CurrencyFrom

INSERT INTO ProductLaunchedSiteCurrency(SiteID, Currency, SportType, IsLaunched, IsTest, BetType, LaunchedLevel)
SELECT SiteID, Currency, SportType, IsLaunched, IsTest, BetType, LaunchedLevel 
FROM ProductLaunchedSiteCurrency p WITH (NOLOCK)
WHERE siteid = 487
	AND currency IN (22)
	AND sporttype <> 200

--INSERT INTO PlayCurrencySetting(SiteId, SiteName, SportType, MemberCurrency, PlayCurrency, FromDate, ToDate)
--SELECT 487, 'IBCIndo', 211, @CurrencyTo, 5, GETDATE(), '2050-01-01'

