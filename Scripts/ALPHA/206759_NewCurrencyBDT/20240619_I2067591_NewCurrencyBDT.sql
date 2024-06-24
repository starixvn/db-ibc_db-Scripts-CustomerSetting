/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240619@Elodie
	Task: Add setting for new currency BDT (Sportsbook, Keno, Lottery, Table Game, Sports Lottery)
	DB: DBCUST/CustDB
*/

DECLARE @Currency INT, @FollowedCurrency INT = 2

SELECT @Currency = ExchangeId--PC
FROM exchange WITH(NOLOCK)
WHERE currency = 'BDT'

--Add data for MaxPayoutGlobalSetting 
INSERT INTO [dbo].[MaxPayoutGlobalSetting]
           ([SportType]
           ,[BetType]
           ,[Currency]
           ,[SingleMatchParlay]
           ,[Combo2]
           ,[Combo35]
           ,[ComboOver6]
           ,[SettingStatus])
SELECT 1 as SportType, 9 as BetType, @Currency, 4070 [SingleMatchParlay], 6105 [Combo2],20350 [Combo35],81400 [ComboOver6],0 [SettingStatus]	
UNION SELECT 99 , 9, @Currency, 4070, 6105, 20350, 81400, 0

--Add default setting for ProductBetSetting
INSERT INTO [dbo].[ProductBetSetting]
           ([Sporttype]
           ,[Bettype]
           ,[Currency]
           ,[MinBet]
           ,[IsDep]
           ,[MaxBet]
           ,[MaxPerMatch]
           ,[DefaultMinBet]
           ,[DefaultMaxBet]
           ,[DefaultMaxPerMatch])
SELECT [Sporttype]
	   ,[Bettype]
	   ,@Currency
	   ,[MinBet]
	   ,[IsDep]
	   ,[MaxBet]
	   ,[MaxPerMatch]
	   ,[DefaultMinBet]
	   ,[DefaultMaxBet]
	   ,[DefaultMaxPerMatch]
FROM ProductBetSetting WITH(NOLOCK)
WHERE currency = 2
	
--Add data for LossLimit_GlobalSetting
INSERT INTO [dbo].[LossLimit_GlobalSetting]
           ([ProductId]
           ,[ExchangeId]
           ,[MinLossLimit]
           ,[DefaultLossLimit])
SELECT 44, @Currency, 5000, 1000000 --RNG Lottery

SELECT s.ProductName, p.*
FROM WinLimit_ProductSettingDetail p WITH(NOLOCK)
	INNER JOIN products s (NOLOCK) ON s.Productid = p.ProductID
WHERe ExchangeID = 2 and p.productid IN (8,28,40,63)
ORDER BY p.ProductID
/*

	
--Add data for ProductStatusSiteCurrency
INSERT INTO [dbo].[ProductStatusSiteCurrency]
           ([SportType]
           ,[BetType]
           ,[Currency]
           ,[SiteID]
           ,[IsHidden]
           ,[IsDisabled]
           ,[HasSynced])
SELECT DISTINCT [SportType]
	   ,[BetType]
	   ,0 Currency
	   ,@siteID
	   ,1 [IsHidden]
	   ,1 [IsDisabled]
	   ,1 [HasSynced]
FROM ProductStatusSiteCurrency WITH(NOLOCK)
	
--Add data for ProductLaunchedSiteCurrency
INSERT INTO [dbo].[ProductLaunchedSiteCurrency]
           ([SiteID]
           ,[Currency]
           ,[SportType]
           ,[IsLaunched]
           ,[IsTest]
           ,[BetType]
           ,[LaunchedLevel])
SELECT DISTINCT @SiteID,
	0 Currency,
	SportType,
	0 IsLaunched,
	0 IsTest,
	BetType,
	LaunchedLevel
FROM ProductLaunchedSiteCurrency WITH(NOLOCK)	
*/