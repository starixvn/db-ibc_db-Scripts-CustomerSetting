/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231026@Johnson
	Task: add settings for new site 7a5555 [redmine: #195550]
	DB: DBCUST/CustDB
*/
DECLARE @siteID INT, @FollowedSite INT, @FollowedCurrency INT

SELECT @siteID = SiteID 
FROM Site WITH(NOLOCK)
WHERE site = '7a5555'

SELECT @FollowedSite = SiteID 
FROM Site WITH(NOLOCK)
WHERE site = '755555'

SELECT @FollowedCurrency = ExchangeId
FROM exchange WITH(NOLOCK)
WHERE currency = 'THB'

--Add data for ProductStatusSiteCurrency
INSERT INTO [dbo].[ProductStatusSiteCurrency]
           ([SportType]
           ,[BetType]
           ,[Currency]
           ,[SiteID]
           ,[IsHidden]
           ,[IsDisabled]
           ,[HasSynced])
SELECT 171, 3801, 0, @siteID, 0, 0, 1--VGaming
	
INSERT INTO ProductProfileSiteCurrency(SiteID,Currency,ProductSettingID)
SELECT @SiteID,0,9 --VGaming 	

--Dont offer these sports: ION,BBIN,PG Soft
INSERT INTO [dbo].[SportNonOfferedSiteCurrency]
           ([SportType]
           ,[BetType]
           ,[Currency]
           ,[SiteID])
SELECT 225, 5601, 0, @siteID
UNION SELECT 241, 3300, 0, @siteID
UNION SELECT 232, 6001, 0, @siteID
UNION SELECT 242, 3201, 0, @siteID

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
	CASE WHEN SportType IN (225,241,232,200) OR IsLaunched = 0 THEN 0 ELSE 1 END IsLaunched,
	CASE WHEN SportType = 200 THEN 1 ELSE 0 END IsTest,
	BetType,
	LaunchedLevel
FROM ProductLaunchedSiteCurrency WITH(NOLOCK)
WHERE SiteID = @FollowedSite
	AND currency IN (0,@FollowedCurrency)
	
--Add data for GameLaunchPerSite
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

