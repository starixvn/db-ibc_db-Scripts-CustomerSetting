/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221221@Tacy
	Task: Add data for 4 new sites (yUT, y789, y889, yOther) 
		 https://nexdev.net/issues/181596 [RedmineID: #181596]
	Database: DBCUST/CustDB
*/
/*
	- GameLaunchPerSite
	- PlayCurrencySetting
	- VRSettingRuleDetail
	
	- ProductLaunchedSiteCurrency
	- ProductStatusSiteCurrency
	- SportNonOfferedSiteCurrency
	- WinLimit_ProductSettingDetail
*/
USE CustDB
GO

CREATE TABLE #WinLimit_ProductSettingDetail (
		ProductID	TINYINT NOT NULL,
		GroupID		SMALLINT NOT NULL,
		ExchangeID	INT NOT NULL,
		SiteID		INT NOT NULL,
		LevelID		TINYINT NOT NULL,
		IsFinshed	BIT DEFAULT 0,
		PRIMARY KEY CLUSTERED (	ProductID	ASC,
								GroupID		ASC,
								ExchangeID	ASC,
								SiteID		ASC,
								LevelID		ASC)
)

CREATE TABLE #WinLimit_ProductSettingDetail_Batch (
		ProductID	TINYINT NOT NULL,
		GroupID		SMALLINT NOT NULL,
		ExchangeID	INT NOT NULL,
		SiteID		INT NOT NULL,
		LevelID		TINYINT NOT NULL,
		PRIMARY KEY CLUSTERED (	ProductID	ASC,
								GroupID		ASC,
								ExchangeID	ASC,
								SiteID		ASC,
								LevelID		ASC)
)

DECLARE @tbSite TABLE (SiteID INT, site NVARCHAR(50))

INSERT INTO @tbSite (SiteID, site)
SELECT siteid, site
FROM Site WITH (NOLOCK)
WHERE site IN ('yUT','y789','y889','yOther')

-- GameLaunchPerSite
INSERT INTO GameLaunchPerSite ([SportType], [BetType], [SiteID], [IsLaunched], [IsTest])
SELECT [SportType], [BetType], s.SiteID, [IsLaunched], [IsTest]
FROM GameLaunchPerSite p WITH (NOLOCK)
CROSS APPLY (SELECT SiteID FROM @tbSite) s
WHERE p.siteid=3

-- PlayCurrencySetting
INSERT INTO PlayCurrencySetting ([SiteId], [SiteName], [SportType], [MemberCurrency], [PlayCurrency], [FromDate], [ToDate])
SELECT s.SiteID, s.site, [SportType], [MemberCurrency], [PlayCurrency], [FromDate], [ToDate]
FROM PlayCurrencySetting p WITH (NOLOCK)
CROSS APPLY (SELECT SiteID,site FROM @tbSite) s
WHERE p.siteid=3

-- VRSettingRuleDetail
INSERT INTO VRSettingRuleDetail ([RuleID], [Sporttype], [Bettype], [SiteID], [CustomerClass], [DateOfWeek], [LeagueGroupID], [LeagueID])
SELECT [RuleID], [Sporttype], [Bettype], s.SiteID, [CustomerClass], [DateOfWeek], [LeagueGroupID], [LeagueID]
FROM VRSettingRuleDetail p WITH (NOLOCK)
CROSS APPLY (SELECT SiteID FROM @tbSite) s
WHERE p.siteid=3

-- ProductLaunchedSiteCurrency
INSERT INTO ProductLaunchedSiteCurrency ([SiteID], [Currency], [SportType], [IsLaunched], [IsTest], [BetType], [LaunchedLevel])
SELECT S.SiteID, [Currency], [SportType], [IsLaunched], [IsTest], [BetType], [LaunchedLevel]
FROM ProductLaunchedSiteCurrency p WITH (NOLOCK)
CROSS APPLY (SELECT SiteID FROM @tbSite) s
WHERE p.siteid=3

-- ProductStatusSiteCurrency
INSERT INTO ProductStatusSiteCurrency ([SportType], [BetType], [Currency], [SiteID], [IsHidden], [IsDisabled], [HasSynced])
SELECT [SportType], [BetType], [Currency], s.SiteID, [IsHidden], [IsDisabled], [HasSynced]
FROM ProductStatusSiteCurrency p WITH (NOLOCK)
CROSS APPLY (SELECT SiteID FROM @tbSite) s
WHERE p.siteid=3

-- SportNonOfferedSiteCurrency
INSERT INTO SportNonOfferedSiteCurrency ([SportType], [BetType], [Currency], [SiteID])
SELECT [SportType], [BetType], [Currency], s.SiteID
FROM SportNonOfferedSiteCurrency p WITH (NOLOCK)
CROSS APPLY (SELECT SiteID FROM @tbSite) s
WHERE p.siteid=3

-- WinLimit_ProductSettingDetail
INSERT INTO #WinLimit_ProductSettingDetail ([ProductID], [GroupID], [ExchangeID], [SiteID], [LevelID])
SELECT [ProductID], [GroupID], [ExchangeID], [SiteID], [LevelID]
FROM WinLimit_ProductSettingDetail WITH (NOLOCK)
WHERE siteid=3

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #WinLimit_ProductSettingDetail_Batch

	UPDATE TOP (1000) T
	SET IsFinshed=1
	OUTPUT inserted.ProductID, inserted.GroupID, inserted.ExchangeID, inserted.SiteID, inserted.LevelID
		INTO #WinLimit_ProductSettingDetail_Batch(ProductID, GroupID, ExchangeID, SiteID, LevelID)
	FROM #WinLimit_ProductSettingDetail T
	WHERE IsFinshed=0

	IF @@ROWCOUNT=0
		BREAK;

	INSERT INTO WinLimit_ProductSettingDetail ([ProductID], [GroupID], [ExchangeID], [SiteID], [LevelID], [MaxWinLimit], [IsBlockedPlaceBet], [IsBlockedTransfer], [MaxWinLimit_RM])
	SELECT wl.[ProductID], wl.[GroupID], wl.[ExchangeID], s.SiteID, wl.[LevelID], [MaxWinLimit], [IsBlockedPlaceBet], [IsBlockedTransfer], [MaxWinLimit_RM]
	FROM WinLimit_ProductSettingDetail wl WITH (NOLOCK)
	CROSS APPLY (SELECT SiteID FROM @tbSite) s
	INNER JOIN #WinLimit_ProductSettingDetail_Batch t
		ON t.ProductID=wl.ProductID
		AND t.GroupID=wl.GroupID
		AND t.ExchangeID=wl.ExchangeID
		AND t.SiteID=wl.SiteID
		AND t.LevelID=wl.SiteID
END