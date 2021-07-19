/*
	Created: 20180515@Elodie
	Task: Insert data into relevant table when inserting new site/currency
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype INT, @Bettype INT, @site INT, @ToCurrency INT, @IsTest BIT, @FromCurrency INT, @FromStakeLevelID INT, @ToStakeLevelID INT, @ResourceId INT, @GameTypeID INT, @Type TINYINT, @GameGroupID INT
CREATE TABLE #TempReference (GameTypeID INT, ResourceId INT, GameGroupID INT, Type TINYINT, IsFinish BIT DEFAULT (0)) --Type = 1: Use GameGroupID, = 2: Use ResourceID

SELECT @site = 294, @ToCurrency = 78, @FromCurrency = 6

--------------ProductBetSetting(Virtual Sport, BetRadar, Keno, Bullfighting)-----------------
INSERT INTO dbo.ProductBetSetting (Sporttype, Bettype, Currency, MinBet, IsDep, MaxBet, MaxPerMatch, DefaultMinBet, DefaultMaxBet, DefaultMaxPerMatch)
SELECT Sporttype, Bettype, @ToCurrency, MinBet, IsDep, MaxBet, MaxPerMatch, DefaultMinBet, DefaultMaxBet, DefaultMaxPerMatch
FROM ProductBetSetting WITH (NOLOCK)
WHERE Currency = @FromCurrency AND Sporttype NOT BETWEEN 213 AND 218 AND Sporttype <> 206 --Cockfighting

----------------StakeLevel(GoldDeluxe, Macau, AllBet)-----------------
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
UNION ALL SELECT 4101, NULL, 7, 1
--Allbet
UNION ALL SELECT 2401, 241, NULL, 2
UNION ALL SELECT 2401, 2, NULL, 2
UNION ALL SELECT 2401, 244, NULL, 2
UNION ALL SELECT 2401, 188, NULL, 2
UNION ALL SELECT 2402, 154, NULL, 2

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


--------------PlayCurrencySetting(AllBet)-----------------
INSERT INTO dbo.PlayCurrencySetting(SiteId, SiteName, SportType, MemberCurrency, PlayCurrency, FromDate, ToDate)
SELECT @site,'EU88',211,@ToCurrency,5,GETDATE(),'2050-01-01'

--------------WinLimit_ProductSettingDetail-----------------
--(All product apply CWL: Allbet,Bullfighting,Fishing World,Gold Deluxe,Keno,Lottery,Lucky 3,Macau Games,Number Game,Pragmatic,RNG Casino,Virtual Sports,Virtual Sports 2)
DELETE WinLimit_ProductSettingDetail WHERE ExchangeID IN (78,72,20) AND SiteID = @site

INSERT INTO dbo.WinLimit_ProductSettingDetail(ProductID, GroupID, ExchangeID, SiteID, LevelID, MaxWinLimit, IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM)
SELECT ProductID, GroupID, @ToCurrency, @site, LevelID, MaxWinLimit, IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM
FROM WinLimit_ProductSettingDetail WITH (NOLOCK)
WHERE ExchangeID = @FromCurrency AND SiteID = 1

INSERT INTO dbo.WinLimit_ProductSettingDetail(ProductID, GroupID, ExchangeID, SiteID, LevelID, MaxWinLimit, IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM)
SELECT ProductID, GroupID, ExchangeID, @site, LevelID, MaxWinLimit, IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM
FROM WinLimit_ProductSettingDetail WITH (NOLOCK)
WHERE ExchangeID = 20 AND SiteID = 1

INSERT INTO dbo.WinLimit_ProductSettingDetail(ProductID, GroupID, ExchangeID, SiteID, LevelID, MaxWinLimit, IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM)
SELECT ProductID, GroupID, ExchangeID, @site, LevelID, MaxWinLimit, IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM
FROM WinLimit_ProductSettingDetail WITH (NOLOCK)
WHERE ExchangeID = 72 AND SiteID = 1

UPDATE PSD
SET MaxWinLimit = CASE WHEN psd.ExchangeID = 20 THEN MaxWinLimit_RM ELSE ROUND(MaxWinLimit_RM / e.actualrate,2) END
FROM WinLimit_ProductSettingDetail PSD WITH(ROWLOCK, UPDLOCK)          
	INNER JOIN Exchange e WITH (NOLOCK)  ON e.ExchangeId = psd.ExchangeID
WHERE PSD.MaxWinLimit_RM IS NOT NULL 
		AND PSD.ExchangeID IN (78,72,20)
		AND PSD.SiteID = @Site

---------------GameLaunchPerSite/GameLaunchPerCurrency(OneRNG Jackpot)-------------------------
INSERT INTO GameLaunchPerSite(SportType, BetType, SiteID, IsLaunched, IsTest)
SELECT 208, 2179, @Site, 1, 0

INSERT INTO GameLaunchPerCurrency(SportType, BetType, Currency, IsLaunched, IsTest)
SELECT 208, 2179, @ToCurrency, 1, 0

-----------------LossLimit_GlobalSetting(Virtual Sports,RNG Casino,Allbet,Macau Games,Fishing World,Lottery,Bullfighting)-------------------------
INSERT INTO LossLimit_GlobalSetting(ProductId, ExchangeId, MinLossLimit, DefaultLossLimit)
SELECT ProductId, @ToCurrency, MinLossLimit, DefaultLossLimit
FROM LossLimit_GlobalSetting WITH (NOLOCK)
WHERE ExchangeId = @FromCurrency