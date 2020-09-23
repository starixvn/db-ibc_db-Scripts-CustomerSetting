/*
	Created: 20200923@Elodie
	Task: Insert data into relevant table when inserting new site/currency
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @ToSite INT, @FromSite INT
SELECT @ToSite = 547, @FromSite = 1

---------------GameLaunchPerSite/GameLaunchPerCurrency(OneRNG Jackpot)-------------------------
INSERT INTO GameLaunchPerSite (SportType, BetType, SiteID, IsLaunched, IsTest)
SELECT SportType, BetType, @ToSite, IsLaunched, IsTest
FROM GameLaunchPerSite WITH (NOLOCK)
WHERE SiteID = @FromSite

---------------ProductStatusSiteCurrency-------------------------
INSERT INTO ProductStatusSiteCurrency (SportType, BetType, Currency, SiteID, IsHidden, IsDisabled, HasSynced)
SELECT SportType, BetType, Currency, @ToSite, IsHidden, IsDisabled, HasSynced
FROM ProductStatusSiteCurrency WITH (NOLOCK)
WHERE SiteID = @FromSite

---------------ProductLaunchedSiteCurrency-------------------------
INSERT INTO ProductLaunchedSiteCurrency (SiteID, Currency, SportType, IsLaunched, IsTest, BetType, LaunchedLevel)
SELECT @ToSite, Currency, SportType, IsLaunched, IsTest, BetType, LaunchedLevel
FROM ProductLaunchedSiteCurrency cs WITH (NOLOCK)
WHERE SiteID = @FromSite
	AND NOT EXISTS (SELECT 1 FROM ProductLaunchedSiteCurrency cs1 WHERE cs1.SportType = cs.SportType AND cs1.BetType = cs.BetType AND cs1.SiteID = @ToSite AND cs1.Currency = 0)

--------------WinLimit_ProductSettingDetail-----------------
INSERT INTO dbo.WinLimit_ProductSettingDetail(ProductID, GroupID, ExchangeID, SiteID, LevelID, MaxWinLimit, IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM)
SELECT ProductID, GroupID, ExchangeID, @ToSite, LevelID, MaxWinLimit, IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM
FROM WinLimit_ProductSettingDetail WITH (NOLOCK)
WHERE siteId = @FromSite AND ExchangeID = 69
