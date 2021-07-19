/*
	Created: 20200515@Elodie
	Task: Insert data into relevant table when inserting new site/currency
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @ToSite INT, @FromSite INT
SELECT @ToSite = 487, @FromSite = 11

---------------GameLaunchPerSite/GameLaunchPerCurrency(OneRNG Jackpot)-------------------------
UPDATE GameLaunchPerSite 
SET IsLaunched = 1
WHERE SiteID = @ToSite

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