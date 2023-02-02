/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221221@Tacy
	Task: Delete data for 789y's global setting 
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

-- GameLaunchPerSite
DELETE GameLaunchPerSite WITH (ROWLOCK)
WHERE SiteID=3

-- PlayCurrencySetting
DELETE PlayCurrencySetting WITH (ROWLOCK)
WHERE SiteID=3

-- VRSettingRuleDetail
DELETE VRSettingRuleDetail WITH (ROWLOCK)
WHERE SiteID=3

-- ProductLaunchedSiteCurrency
DELETE ProductLaunchedSiteCurrency WITH (ROWLOCK)
WHERE siteid=3

-- ProductStatusSiteCurrency
DELETE ProductStatusSiteCurrency WITH (ROWLOCK)
WHERE siteid=3

-- SportNonOfferedSiteCurrency
DELETE SportNonOfferedSiteCurrency WITH (ROWLOCK)
WHERE siteid=3

-- WinLimit_ProductSettingDetail
INSERT INTO #WinLimit_ProductSettingDetail ([ProductID], [GroupID], [ExchangeID], [SiteID], [LevelID])
SELECT [ProductID], [GroupID], [ExchangeID], [SiteID], [LevelID]
FROM WinLimit_ProductSettingDetail WITH (ROWLOCK)
WHERE siteid=3

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #WinLimit_ProductSettingDetail_Batch

	UPDATE TOP (5000) T
	SET IsFinshed=1
	OUTPUT inserted.ProductID, inserted.GroupID, inserted.ExchangeID, inserted.SiteID, inserted.LevelID
		INTO #WinLimit_ProductSettingDetail_Batch(ProductID, GroupID, ExchangeID, SiteID, LevelID)
	FROM #WinLimit_ProductSettingDetail T
	WHERE IsFinshed=0

	IF @@ROWCOUNT=0
		BREAK;

	DELETE wl
	FROM WinLimit_ProductSettingDetail wl WITH (ROWLOCK)
	INNER JOIN #WinLimit_ProductSettingDetail_Batch t
		ON t.ProductID=wl.ProductID
		AND t.GroupID=wl.GroupID
		AND t.ExchangeID=wl.ExchangeID
		AND t.SiteID=wl.SiteID
		AND t.LevelID=wl.SiteID
END