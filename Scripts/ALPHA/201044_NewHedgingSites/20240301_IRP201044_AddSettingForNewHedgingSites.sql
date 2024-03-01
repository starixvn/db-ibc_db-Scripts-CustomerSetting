/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240301@Johnson
	Task: add settings for Hedging & Phone Betting sites [redmine: #201044]
	DB: DBCUST/CustDB
*/
DECLARE @siteID INT, @FollowedSite INT, @FollowedCurrency INT
DECLARE @tmpSite TABLE (SiteID INT)

INSERT INTO @tmpSite(SiteID)
SELECT SiteID 
FROM Site WITH(NOLOCK)
WHERE site IN ('Hedging','Special')

SELECT @FollowedSite = SiteID 
FROM Site WITH(NOLOCK)
WHERE site = 'BEST-ODDS'

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
	   ,[Currency]
	   ,t.SiteID
	   ,[IsHidden]
	   ,[IsDisabled]
	   ,[HasSynced]
FROM ProductStatusSiteCurrency c (NOLOCK)
	CROSS APPLY @tmpSite t
WHERE c.SiteID = @FollowedSite		   

--Add data for ProductProfileSiteCurrency
INSERT INTO ProductProfileSiteCurrency(SiteID,Currency,ProductSettingID)
SELECT t.SiteID,Currency,ProductSettingID
FROM ProductProfileSiteCurrency c (NOLOCK)
	CROSS APPLY @tmpSite t
WHERE c.SiteID = @FollowedSite		

--Add data for SportNonOfferedSiteCurrency
INSERT INTO [dbo].[SportNonOfferedSiteCurrency]
           ([SportType]
           ,[BetType]
           ,[Currency]
           ,[SiteID]
		   ,RealProductID)
SELECT [SportType]
	   ,[BetType]
	   ,[Currency]
	   ,t.SiteID
	   ,RealProductID
FROM SportNonOfferedSiteCurrency c (NOLOCK)
	CROSS APPLY @tmpSite t
WHERE c.SiteID = @FollowedSite			

--Add data for ProductLaunchedSiteCurrency
INSERT INTO [dbo].[ProductLaunchedSiteCurrency]
           ([SiteID]
           ,[Currency]
           ,[SportType]
           ,[IsLaunched]
           ,[IsTest]
           ,[BetType]
           ,[LaunchedLevel])
SELECT t.SiteID
	   ,[Currency]
	   ,[SportType]
	   ,[IsLaunched]
	   ,[IsTest]
	   ,[BetType]
	   ,[LaunchedLevel]
FROM ProductLaunchedSiteCurrency c (NOLOCK)
	CROSS APPLY @tmpSite t
WHERE c.SiteID = @FollowedSite		


--Add data for GameLaunchPerSite
INSERT INTO [dbo].[GameLaunchPerSite]
           ([SportType]
           ,[BetType]
           ,[SiteID]
           ,[IsLaunched]
           ,[IsTest])
SELECT [SportType]
	   ,[BetType]
	   ,t.SiteID
	   ,[IsLaunched]
	   ,[IsTest]
FROM GameLaunchPerSite c WITH (NOLOCK)
	CROSS APPLY @tmpSite t
WHERE c.SiteID = @FollowedSite		

--Add data for WinLimit_ProductSettingDetail
INSERT INTO dbo.WinLimit_ProductSettingDetail(ProductID, GroupID, ExchangeID, SiteID, LevelID, MaxWinLimit, IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM, IsSuspendedAccount)
SELECT ProductID, GroupID, ExchangeID, t.SiteID, LevelID, MaxWinLimit, IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM, IsSuspendedAccount
FROM WinLimit_ProductSettingDetail c (NOLOCK)
	CROSS APPLY @tmpSite t
WHERE c.SiteID = @FollowedSite		   