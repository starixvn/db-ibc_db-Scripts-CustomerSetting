/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created:	Winfred
	Date:		20211220
	Task:		Set up New Currency INR1 for India market RedmineID:#166295
	DB:			DBCust/CustDB
*/

DECLARE @ToCurrency INT, @FromCurrency INT, @ToStakeLevelID INT, @ResourceId INT, @GameTypeID INT, @Type TINYINT, @GameGroupID INT ,@FromStakeLevelID INT

SELECT	@ToCurrency = 10 ,  -- INR1
		@FromCurrency = 43 -- THB
CREATE TABLE #TempReference (GameTypeID INT, ResourceId INT, GameGroupID INT, Type TINYINT, IsFinish BIT DEFAULT (0)) --Type = 1: Use GameGroupID, = 2: Use ResourceID
--------------ProductBetSetting
DELETE ProductBetSetting WHERE Currency = @ToCurrency

INSERT INTO dbo.ProductBetSetting (Sporttype, Bettype, Currency, MinBet, IsDep, MaxBet, MaxPerMatch, DefaultMinBet, DefaultMaxBet, DefaultMaxPerMatch)
SELECT Sporttype, Bettype, @ToCurrency, MinBet, IsDep, MaxBet, MaxPerMatch, DefaultMinBet, DefaultMaxBet, DefaultMaxPerMatch
FROM ProductBetSetting WITH (NOLOCK)
WHERE Currency = @FromCurrency AND Sporttype NOT BETWEEN 213 AND 218
----------------StakeLevel -- All product
DELETE sld 
FROM StakeLevelGroupDetail sld WITH(ROWLOCK)
INNER JOIN StakeLevel sl WITH (NOLOCK) ON sld.StakeLevelID = sl.StakeLevelID
WHERE sl.ExchangeId = @ToCurrency
DELETE StakeLevel WHERE ExchangeId = @ToCurrency

INSERT INTO dbo.StakeLevel (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ExchangeId, ResourceId, GameGroupID)
SELECT GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, @ToCurrency, ResourceId, GameGroupID
FROM stakeLevel WITH (NOLOCK)
WHERE exchangeid = @FromCurrency 

----------------StakeLevelGroupDetail(Macau, AllBet)-----------------
INSERT INTO #TempReference (GameTypeID, ResourceId, GameGroupID, Type)
--Macau
SELECT 4001, NULL, 1, 1
UNION ALL SELECT 4001, NULL, 2, 1
UNION ALL SELECT 4101, NULL, 6, 1
UNION ALL SELECT 1901, NULL, 9   ,  1 
UNION ALL SELECT 4301, NULL, 12  ,  1 
UNION ALL SELECT 1611, NULL, 13  ,  1 
UNION ALL SELECT 6001, NULL, 15  ,  1 
UNION ALL SELECT 6401, NULL, 17  ,  1 
UNION ALL SELECT 5401, NULL, 19  ,  1 
UNION ALL SELECT 7001, NULL, 21  ,  1 
UNION ALL SELECT 7301, NULL, 23  ,  1 
UNION ALL SELECT 3801, NULL, 25  ,  1 
UNION ALL SELECT 7701, NULL, 27  ,  1 
UNION ALL SELECT 7801, NULL, 29  ,  1 
UNION ALL SELECT 5500, NULL, 32  ,  1 
--Allbet
UNION ALL SELECT 2401, 152, NULL, 2
UNION ALL SELECT 2401, 3, NULL, 2
UNION ALL SELECT 2401, 30, NULL, 2
UNION ALL SELECT 2401, 44, NULL, 2

WHILE (1=1)
BEGIN
    UPDATE TOP (1) #TempReference
	SET IsFinish = 1,
		@GameTypeID = GameTypeID,
		@ResourceId = ResourceId,
		@GameGroupID = GameGroupID,
		@Type = Type
	FROM #TempReference 
	WHERE IsFinish = 0

	IF @@ROWCOUNT = 0 BREAK

	IF @Type = 1
	BEGIN
		SELECT @FromStakeLevelID = StakeLevelID
		FROM dbo.StakeLevel WITH (NOLOCK)
		WHERE exchangeid = @FromCurrency 
			AND GameTypeID = @GameTypeID AND GameGroupID = @GameGroupID

		SELECT @ToStakeLevelID = StakeLevelID
		FROM dbo.StakeLevel WITH (NOLOCK)
		WHERE exchangeid = @ToCurrency 
			AND GameTypeID = @GameTypeID AND GameGroupID = @GameGroupID
	END
	ELSE
	BEGIN
		SELECT @FromStakeLevelID = StakeLevelID
		FROM dbo.StakeLevel WITH (NOLOCK)
		WHERE exchangeid = @FromCurrency 
			AND GameTypeID = @GameTypeID AND ResourceId = @ResourceId

		SELECT @ToStakeLevelID = StakeLevelID
		FROM dbo.StakeLevel WITH (NOLOCK)
		WHERE exchangeid = @ToCurrency 
			AND GameTypeID = @GameTypeID AND ResourceId = @ResourceId
	END

	INSERT INTO dbo.StakeLevelGroupDetail (StakeLevelID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ParentTypeID)
	SELECT @ToStakeLevelID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ParentTypeID
	FROM dbo.StakeLevelGroupDetail WITH (NOLOCK)
	WHERE StakeLevelID = @FromStakeLevelID
END
-----------------LossLimit_GlobalSetting
DELETE LossLimit_GlobalSetting WHERE ExchangeId = @ToCurrency

INSERT INTO LossLimit_GlobalSetting(ProductId, ExchangeId, MinLossLimit, DefaultLossLimit)
SELECT ProductId, @ToCurrency, MinLossLimit, DefaultLossLimit
FROM LossLimit_GlobalSetting WITH (NOLOCK)
WHERE ExchangeId = @FromCurrency

---------------GameLaunchPerCurrency(OneRNG Jackpot)-------------------------
DELETE GameLaunchPerCurrency WHERE Currency = @ToCurrency

INSERT INTO GameLaunchPerCurrency(SportType, BetType, Currency, IsLaunched, IsTest)
SELECT SportType, BetType, @ToCurrency AS Currency, 1 AS IsLaunched, 0 AS IsTest
FROM GameLaunchPerCurrency WITH (NOLOCK)
WHERE Currency = @FromCurrency

--------------WinLimit_ProductSettingDetail
DELETE WinLimit_ProductSettingDetail WHERE ExchangeID = @ToCurrency

INSERT INTO dbo.WinLimit_ProductSettingDetail(ProductID, GroupID, ExchangeID, SiteID, LevelID, MaxWinLimit, IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM)
SELECT ProductID, GroupID, @ToCurrency, SiteID, LevelID, MaxWinLimit, IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM
FROM WinLimit_ProductSettingDetail WITH (NOLOCK)
WHERE SiteID = 1 AND ExchangeID = 61 --INR/ BEST-ODDS

-------------MaxPayoutGlobalSetting
DELETE MaxPayoutGlobalSetting WHERE Currency = @ToCurrency

INSERT INTO MaxPayoutGlobalSetting(SportType, BetType,Currency,SingleMatchParlay,Combo2,Combo35,ComboOver6)
SELECT 1 AS SportType, 9 AS BetType ,@ToCurrency AS Currency, 1894000 AS SingleMatchParlay, 2841000 AS Combo2, 9470000 AS Combo35, 37879000 AS ComboOver6 UNION ALL
SELECT 99 AS SportType, 9 AS BetType ,@ToCurrency AS Currency, 1894000 AS SingleMatchParlay, 2841000 AS Combo2, 9470000 AS Combo35, 37879000 AS ComboOver6

-------------ProductLaunchedSiteCurrency
DELETE ProductLaunchedSiteCurrency WHERE Currency = @ToCurrency

INSERT INTO ProductLaunchedSiteCurrency (SportType, SiteID, Currency, IsLaunched, IsTest)
SELECT SportType, SiteID, @ToCurrency, 0 AS IsLaunched, 0 AS IsTest
FROM ProductLaunchedSiteCurrency
WHERE Currency = @FromCurrency

-------------ProductStatusSiteCurrency
DELETE ProductStatusSiteCurrency WHERE Currency = @ToCurrency

INSERT INTO ProductStatusSiteCurrency (SportType,BetType,Currency,SiteID,IsHidden,IsDisabled,HasSynced)
SELECT SportType,BetType,@ToCurrency AS Currency,SiteID,1 AS IsHidden,IsDisabled,HasSynced
FROM ProductStatusSiteCurrency
WHERE Currency = @FromCurrency


DROP TABLE #TempReference