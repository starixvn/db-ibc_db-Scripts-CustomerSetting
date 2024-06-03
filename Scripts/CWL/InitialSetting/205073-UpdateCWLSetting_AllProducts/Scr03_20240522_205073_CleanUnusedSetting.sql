/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator: 20240522@Tacy
	Task: CWL - Clean unused setting [Redmine: #205073]
	Database:	DBCUST.CustDB
*/

USE CustDB
GO

--Update GroupName:
UPDATE Winlimit_Group WITH (ROWLOCK, UPDLOCK)
SET GroupName='MG-RNG Promotion Prize'
WHERE GroupID=57
GO

/*
	Winlimit_Group
	Winlimit_ProductSetting
	Winlimit_GameGroupSetting
	Winlimit_ProductGlobalSetting
	WinLimit_ProductSettingDetail
	WinLimit_CustGameSetting
	WinLimit_CustGameMonitoring
	WinLimit_CustGameStatus
	WinLimit_CustSetting

*/
--Get unused product setting
CREATE TABLE #tmpProduct (ProductID INT, GroupID INT, GroupName VARCHAR(200), BetTypeID SMALLINT)

INSERT INTO #tmpProduct(ProductID, GroupID, GroupName, BetTypeID)
/*
SELECT gg.ProductID, g.GroupID, g.GroupName, gg.BetTypeID
FROM Winlimit_Group g WITH (NOLOCK)
CROSS APPLY (SELECT TOP 1 gg.ProductID, gg.BetTypeID
			 FROM Winlimit_GameGroupSetting gg WITH (NOLOCK)
			 WHERE gg.GroupID=g.GroupID) gg
WHERE ProductID IN (13,17,30,33,43)		--unused setting
	OR (ProductID=6 AND GroupName LIKE '%Jackpot%')
*/
SELECT 13, 6, 'Microgaming - Live Casino', 2001
UNION ALL
SELECT 17, 7, 'Microgaming - RNG Casino', 2008
UNION ALL
SELECT 30, 15, 'Bullfighting', 1004
UNION ALL
SELECT 6, 17, 'Saba Casino - Minor Jackpot', 2179
UNION ALL
SELECT 6, 18, 'Saba Casino - Mega Jackpot', 2199
UNION ALL
SELECT 33, 19, 'Poker Games', 1401
UNION ALL
SELECT 43, 27, 'Togel 4D', 5001


-------------------------------------------------------------
------------------------Clean setting------------------------
--> Winlimit_Group
DELETE a
FROM Winlimit_Group a WITH (ROWLOCK)
INNER JOIN #tmpProduct t ON a.GroupID=t.GroupID

--> Winlimit_GameGroupSetting
DELETE a
FROM Winlimit_GameGroupSetting a WITH (ROWLOCK)
INNER JOIN #tmpProduct t ON a.GroupID=t.GroupID

--> Winlimit_ProductGlobalSetting
DELETE a
FROM Winlimit_ProductGlobalSetting a WITH (ROWLOCK)
INNER JOIN #tmpProduct t ON a.GroupID=t.GroupID

--> Winlimit_ProductSetting
DELETE a
FROM Winlimit_ProductSetting a WITH (ROWLOCK)
INNER JOIN #tmpProduct t ON a.ProductID=t.ProductID
WHERE a.ProductID<>6

--> WinLimit_CustGameSetting
DELETE a
FROM WinLimit_CustGameSetting a WITH (ROWLOCK)
INNER JOIN #tmpProduct t ON a.GroupID=t.GroupID

--> WinLimit_CustGameMonitoring
DELETE a
FROM WinLimit_CustGameMonitoring a WITH (ROWLOCK)
INNER JOIN #tmpProduct t ON a.GroupID=t.GroupID

--> WinLimit_CustGameStatus
DELETE a
FROM WinLimit_CustGameStatus a WITH (ROWLOCK)
INNER JOIN #tmpProduct t ON a.ProductID=t.ProductID
WHERE t.ProductID<>6

DELETE a	-- Saba Casino %Jackpot%
FROM WinLimit_CustGameStatus a WITH (ROWLOCK)
INNER JOIN #tmpProduct t ON a.ProductID=t.ProductID
						AND a.BettypeID=t.BetTypeID
WHERE t.ProductID=6

--> WinLimit_CustSetting
DELETE a
FROM WinLimit_CustSetting a WITH (ROWLOCK)
INNER JOIN #tmpProduct t ON a.ProductID=t.ProductID
WHERE t.ProductID<>6

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

WHILE (1=1)
BEGIN
	INSERT INTO #WinLimit_ProductSettingDetail ([ProductID], [GroupID], [ExchangeID], [SiteID], [LevelID])
	SELECT TOP (100000)
			a.[ProductID], a.[GroupID], [ExchangeID], [SiteID], [LevelID]
	FROM WinLimit_ProductSettingDetail a WITH(NOLOCK) 
	INNER JOIN #tmpProduct t ON a.GroupID=t.GroupID
							AND a.ProductID=t.ProductID

	IF @@ROWCOUNT=0
		BREAK;

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
END

DROP TABLE #WinLimit_ProductSettingDetail, #WinLimit_ProductSettingDetail_Batch, #tmpProduct
GO