/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230929@Johnson
	Task: Add setting for new site 777777, currency PC
	DB: DBCUST/CustDB
*/

DECLARE @siteID INT, @FollowedSite INT, @Currency INT, @FollowedCurrency INT

SELECT @siteID = SiteID 
FROM Site WITH(NOLOCK)
WHERE site = '777777'

SELECT @FollowedSite = SiteID 
FROM Site WITH(NOLOCK)
WHERE site = '733333'

SELECT @Currency = ExchangeId--PC
FROM exchange WITH(NOLOCK)
WHERE currency = 'PC'

SELECT @FollowedCurrency = ExchangeId
FROM exchange WITH(NOLOCK)
WHERE currency = 'RM'

--Add data for Age_DomainList
INSERT INTO [dbo].[Age_DomainList]
           ([SiteLabel]
           ,[Domain]
           ,[Alias])
SELECT '777', 'Tara88ag.com', NULL
UNION SELECT '777', 'tp88ag.com', NULL
UNION SELECT '777', 'tplay88ag.com', NULL
		   
--Add data for ProductStatusSiteCurrency
INSERT INTO [dbo].[ProductStatusSiteCurrency]
           ([SportType]
           ,[BetType]
           ,[Currency]
           ,[SiteID]
           ,[IsHidden]
           ,[IsDisabled]
           ,[HasSynced])
SELECT [SportType]
	   ,[BetType]
	   ,@Currency
	   ,@siteID
	   ,[IsHidden]
	   ,[IsDisabled]
	   ,[HasSynced]
FROM ProductStatusSiteCurrency WITH(NOLOCK)
WHERE SiteID= @FollowedSite AND Currency = @FollowedCurrency

--Add data for ProductBetSetting
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
WHERE currency = @FollowedCurrency

--Add data for LossLimit_GlobalSetting
INSERT INTO [dbo].[LossLimit_GlobalSetting]
           ([ProductId]
           ,[ExchangeId]
           ,[MinLossLimit]
           ,[DefaultLossLimit])
SELECT [ProductId]
	   ,@Currency
	   ,[MinLossLimit]
	   ,[DefaultLossLimit]
FROM LossLimit_GlobalSetting WITH(NOLOCK)
WHERE ExchangeId = @FollowedCurrency

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


--Add data for ProductProfileSiteCurrency
INSERT INTO [dbo].[ProductProfileSiteCurrency]
           ([SiteID]
           ,[Currency]
           ,[ProductSettingID])
SELECT @siteID
	   ,0 as Currency
	   ,[ProductSettingID]
FROM ProductProfileSiteCurrency	WITH(NOLOCK)
WHERE siteID = @FollowedSite	

--Add data for SportNonOfferedSiteCurrency
INSERT INTO [dbo].[SportNonOfferedSiteCurrency]
           ([SportType]
           ,[BetType]
           ,[Currency]
           ,[SiteID])
SELECT [SportType]
	   ,[BetType]
	   ,@Currency
	   ,@siteID
FROM SportNonOfferedSiteCurrency WITH(NOLOCK)
WHERE Currency = @FollowedCurrency
	   AND SiteID = @FollowedSite

--Add data for GameLaunchPerSite/GameLaunchPerCurrency
INSERT INTO [dbo].[GameLaunchPerSite]
           ([SportType]
           ,[BetType]
           ,[SiteID]
           ,[IsLaunched]
           ,[IsTest])
SELECT [SportType]
	   ,[BetType]
	   ,@SiteID
	   ,[IsLaunched]
	   ,[IsTest]
FROM GameLaunchPerSite WITH (NOLOCK)
WHERE SiteID = @FollowedSite

INSERT INTO [dbo].[GameLaunchPerCurrency]
           ([SportType]
           ,[BetType]
           ,[Currency]
           ,[IsLaunched]
           ,[IsTest])
SELECT [SportType]
	   ,[BetType]
	   ,@Currency
	   ,[IsLaunched]
	   ,[IsTest]
FROM GameLaunchPerCurrency WITH(NOLOCK)
WHERE Currency = @FollowedCurrency		   

INSERT INTO dbo.WinLimit_ProductSettingDetail(ProductID, GroupID, ExchangeID, SiteID, LevelID, MaxWinLimit, IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM)
SELECT ProductID, GroupID, @Currency, @siteID, LevelID, MaxWinLimit, IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM
FROM WinLimit_ProductSettingDetail WITH (NOLOCK)
WHERE ExchangeID = @FollowedCurrency AND SiteID = @FollowedSite

INSERT INTO dbo.WinLimit_ProductSettingDetail(ProductID, GroupID, ExchangeID, SiteID, LevelID, MaxWinLimit, IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM)
SELECT ProductID, GroupID, ExchangeID, @siteID, LevelID, MaxWinLimit, IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM
FROM WinLimit_ProductSettingDetail WITH (NOLOCK)
WHERE ExchangeID IN(20,72) AND SiteID = @FollowedSite

UPDATE PSD
SET MaxWinLimit = CASE WHEN psd.ExchangeID = 20 THEN MaxWinLimit_RM ELSE ROUND(MaxWinLimit_RM / e.actualrate,2) END
FROM WinLimit_ProductSettingDetail PSD WITH(ROWLOCK, UPDLOCK)          
	INNER JOIN Exchange e WITH (NOLOCK)  ON e.ExchangeId = psd.ExchangeID
WHERE PSD.MaxWinLimit_RM IS NOT NULL 
		AND PSD.ExchangeID IN (@Currency,20,72)
		AND PSD.SiteID = @siteID   