/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20221129
	Task: Credit - Delete global settings for GDG, Fishing World, GD, Colosus Bet
		https://nexdev.net/issues/174511
		https://nexdev.net/issues/179132

	DB: DBCust/CustDB
*/ 
/*
	LossLimit_GlobalSetting
	VendorGlobalSetting

	ProductGlobalSetting
	ProductStatusSiteCurrency
	ProductLaunchedSiteCurrency
	ProductSettingDetail
	ProductSettingDetail_UAT
	ProductStatusProfile
	ProductSettingSystemDisplay
	
	Winlimit_ProductGlobalSetting
	WinLimit_ProductSettingDetail
	WinLimit_CustGameSetting
	WinLimit_CustGameMonitoring
	WinLimit_CustGameStatus
	Winlimit_GameGroupSetting
	Winlimit_ProductSetting
	WinLimit_CustSetting

	Stakelevel
*/

------------------------------CREDIT----------------------------------------------------------------
CREATE TABLE #SportTypeList (Sporttype SMALLINT, Bettype SMALLINT,ProductID tinyint)

INSERT INTO #SportTypeList(Sporttype, Bettype, ProductID)
SELECT 219, 1011, 24 --Fishing World
UNION ALL 
SELECT 236, 5701, 59 -- GDG
UNION ALL 
SELECT 255, 1701, 12 -- GD
UNION ALL 
SELECT 255, 1702, 12 -- GD
UNION ALL 
SELECT 255, 1703, 12 -- GD
UNION ALL 
SELECT 255, 1704, 12 -- GD
UNION ALL 
SELECT 255, 1705, 12 -- GD
UNION ALL 
SELECT 255, 1706, 12 -- GD
UNION ALL 
SELECT 204, NULL, 15 -- CB

--> LossLimit_GlobalSetting
DELETE a
FROM LossLimit_GlobalSetting a WITH(ROWLOCK) 
CROSS APPLY (SELECT TOP 1 t.ProductID FROM #SportTypeList t WHERE a.ProductID=t.ProductID) t

--> Winning Share Commission
DELETE a
FROM VendorGlobalSetting  a WITH(ROWLOCK) 
CROSS APPLY (SELECT TOP 1 t.ProductID FROM #SportTypeList t WHERE a.sporttype=t.Sporttype) t

--> ProductGlobalSetting
DELETE a
FROM ProductGlobalSetting  a WITH(ROWLOCK) 
CROSS APPLY (SELECT TOP 1 t.ProductID FROM #SportTypeList t WHERE a.sporttype=t.Sporttype) t

--> ProductStatusSiteCurrency
DELETE a
FROM ProductStatusSiteCurrency a WITH(ROWLOCK)
CROSS APPLY (SELECT TOP 1 t.ProductID FROM #SportTypeList t WHERE a.sporttype=t.Sporttype) t

--> ProductLaunchedSiteCurrency
DELETE a
FROM dbo.ProductLaunchedSiteCurrency a WITH(ROWLOCK)
CROSS APPLY (SELECT TOP 1 t.ProductID FROM #SportTypeList t WHERE a.sporttype=t.Sporttype) t

--> ProductSettingDetail
DELETE a
FROM dbo.ProductSettingDetail a WITH(ROWLOCK)
CROSS APPLY (SELECT TOP 1 t.ProductID FROM #SportTypeList t WHERE a.sporttype=t.Sporttype) t

DELETE a
FROM dbo.ProductSettingDetail_UAT a WITH(ROWLOCK)
CROSS APPLY (SELECT TOP 1 t.ProductID FROM #SportTypeList t WHERE a.sporttype=t.Sporttype) t

-->ProductStatusProfile
DELETE a
FROM ProductStatusProfile  a WITH(ROWLOCK) 
CROSS APPLY (SELECT TOP 1 t.ProductID FROM #SportTypeList t WHERE a.sporttype=t.Sporttype) t

-->ProductSettingSystemDisplay
DELETE a
FROM ProductSettingSystemDisplay a WITH(ROWLOCK) 
CROSS APPLY (SELECT TOP 1 t.ProductID FROM #SportTypeList t WHERE a.ProductID=t.ProductID) t

--> Winlimit_ProductGlobalSetting
DELETE a
FROM Winlimit_ProductGlobalSetting  a WITH(ROWLOCK) 
CROSS APPLY (SELECT TOP 1 t.ProductID FROM #SportTypeList t WHERE a.ProductID=t.ProductID) t

-->WinLimit_CustGameSetting
DELETE a
FROM WinLimit_CustGameSetting a WITH(ROWLOCK) 
CROSS APPLY (SELECT TOP 1 t.ProductID FROM #SportTypeList t WHERE a.ProductID=t.ProductID) t

-->WinLimit_CustGameMonitoring
DELETE a
FROM WinLimit_CustGameMonitoring a WITH(ROWLOCK) 
CROSS APPLY (SELECT TOP 1 t.ProductID FROM #SportTypeList t WHERE a.ProductID=t.ProductID) t

-->WinLimit_CustGameStatus
DELETE a
FROM WinLimit_CustGameStatus a WITH(ROWLOCK) 
CROSS APPLY (SELECT TOP 1 t.ProductID FROM #SportTypeList t WHERE a.ProductID=t.ProductID) t

-->Winlimit_GameGroupSetting
DELETE a
FROM Winlimit_GameGroupSetting a WITH(ROWLOCK) 
CROSS APPLY (SELECT TOP 1 t.ProductID FROM #SportTypeList t WHERE a.ProductID=t.ProductID) t

-->Winlimit_ProductSetting
DELETE a
FROM Winlimit_ProductSetting a WITH(ROWLOCK) 
CROSS APPLY (SELECT TOP 1 t.ProductID FROM #SportTypeList t WHERE a.ProductID=t.ProductID) t

-->WinLimit_CustSetting
DELETE a
FROM WinLimit_CustSetting a WITH(ROWLOCK) 
CROSS APPLY (SELECT TOP 1 t.ProductID FROM #SportTypeList t WHERE a.ProductID=t.ProductID) t

-->Stakelevel
DELETE a
FROM Stakelevel a WITH(ROWLOCK) 
INNER JOIN #SportTypeList t ON a.GameTypeID = t.Bettype

-->WinLimit_ProductSettingDetail
CREATE TABLE #WinLimit_ProductSettingDetail (
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

INSERT INTO #WinLimit_ProductSettingDetail ([ProductID], [GroupID], [ExchangeID], [SiteID], [LevelID])
SELECT [ProductID], [GroupID], [ExchangeID], [SiteID], [LevelID]
FROM WinLimit_ProductSettingDetail a WITH(ROWLOCK) 
CROSS APPLY (SELECT TOP 1 1 as val FROM #SportTypeList t WHERE a.ProductID=t.ProductID) t

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #WinLimit_ProductSettingDetail_Batch

	DELETE TOP (3000) T
	OUTPUT deleted.ProductID, deleted.GroupID, deleted.ExchangeID, deleted.SiteID, deleted.LevelID
		INTO #WinLimit_ProductSettingDetail_Batch(ProductID, GroupID, ExchangeID, SiteID, LevelID)
	FROM #WinLimit_ProductSettingDetail T

	IF @@ROWCOUNT=0
		BREAK;

	DELETE wl
	FROM WinLimit_ProductSettingDetail wl WITH (ROWLOCK)
	INNER JOIN #WinLimit_ProductSettingDetail_Batch t
		ON t.ProductID=wl.ProductID
		AND t.GroupID=wl.GroupID
		AND t.ExchangeID=wl.ExchangeID
		AND t.SiteID=wl.SiteID
		AND t.LevelID=wl.LevelID

	WAITFOR DELAY '00:00:0.200'
END
GO