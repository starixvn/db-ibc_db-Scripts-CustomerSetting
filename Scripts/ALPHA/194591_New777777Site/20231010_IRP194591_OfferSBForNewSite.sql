/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231010@Johnson
	Task: Add setting for new site 777777, currency PC
	DB: DBCUST/CustDB
*/
/*
DELETE Age_DomainList WHERE SiteLabel = '777'

--Add data for Age_DomainList
INSERT INTO [dbo].[Age_DomainList]
           ([SiteLabel]
           ,[Domain]
           ,[Alias])
SELECT '777', 'www.tara88ag.com', NULL
UNION SELECT '777', 'www.tp88ag.com', NULL
UNION SELECT '777', 'www.tplay88ag.com', NULL
*/

DECLARE @siteID INT, @FollowedSite INT, @Currency INT, @FollowedCurrency INT

SELECT @siteID = SiteID 
FROM Site WITH(NOLOCK)
WHERE site = '777777'

SELECT @Currency = ExchangeId--PC
FROM exchange WITH(NOLOCK)
WHERE currency = 'PC'

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
SELECT 1 as SportType, 9 as BetType, @Currency, 1000000 [SingleMatchParlay], 1500000 [Combo2],6000000 [Combo35],25000000 [ComboOver6],0 [SettingStatus]	
UNION SELECT 99 , 9, @Currency, 1000000, 1500000, 6000000, 25000000, 0

/*
--Add default setting for ProductBetSetting for SB2
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
WHERE currency = 20 
	AND sporttype IN (43,44)
	
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