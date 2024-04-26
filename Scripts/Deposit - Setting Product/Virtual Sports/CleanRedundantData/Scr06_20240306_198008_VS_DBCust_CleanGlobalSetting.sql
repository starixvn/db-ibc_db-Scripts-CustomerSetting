/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created: Tacy@20240306
	Task: Deposit - Clean VS1, VS2, VS3 - Global setting - [redmine: #198008]
	DB: DBCUST/CUSTDB
*/
/*
	Dep_ProductSetting
	Dep_ProductSettingDetail
	Dep_ProductStatusProfile
	Dep_CustBetLimit_Special
	Dep_ProductBetSetting

	--VS3 (Old)
	VendorGlobalSetting
	Winlimit_ProductGlobalSetting
	WinLimit_ProductSettingDetail
	Winlimit_GameGroupSetting
	Winlimit_ProductSetting
*/
USE CustDB
GO

CREATE TABLE #SportBettype (Sporttype SMALLINT, Bettype SMALLINT)

INSERT INTO #SportBettype(Sporttype, Bettype)
SELECT DISTINCT SportType, BetType
FROM Dep_ProductSettingDetail psd WITH(ROWLOCK)
	INNER JOIN Dep_ProductSetting ps WITh(ROWLOCK) ON psd.ProductSettingID=ps.ProductSettingID
WHERE ps.ProductID in (5,27,49,77) AND SettingStatus=2

--Dep_CustBetLimit_Special
--CNT=637
DELETE t
FROM Dep_CustBetLimit_Special t WITH (ROWLOCK)
	INNER JOIN #SportBettype s ON s.Sporttype=t.SportType

--Dep_ProductBetSetting
--CNT=633
DELETE t
FROM Dep_ProductBetSetting t WITH (ROWLOCK)
	INNER JOIN #SportBettype s ON s.Sporttype=t.SportType

--Dep_ProductSetting
DELETE FROM Dep_ProductSetting WITH (ROWLOCK)
WHERE ProductID IN (5,77,27,49)
AND ProductSettingID NOT BETWEEN 182 AND 185

--Dep_ProductSettingDetail
DELETE t
FROM Dep_ProductSettingDetail t WITH (ROWLOCK)
	INNER JOIN #SportBettype s ON s.Sporttype=t.SportType
								AND s.Bettype=t.BetType

--Dep_ProductStatusProfile
DELETE t
FROM Dep_ProductStatusProfile t  WITH (ROWLOCK)
WHERE Sporttype IN (180,190,178,231)	--VS123, VS3 (old)

-----------------------------------------------------------------------
--For VS3 (old)
--> VendorGlobalSetting
DELETE a
FROM VendorGlobalSetting a WITH(ROWLOCK) 
WHERE a.sporttype=231

-->Winlimit_GameGroupSetting
DELETE a
FROM Winlimit_GameGroupSetting a WITH(ROWLOCK) 
WHERE a.ProductID=49

-->Winlimit_ProductSetting
DELETE a
FROM Winlimit_ProductSetting a WITH(ROWLOCK) 
WHERE a.ProductID=49

-->Winlimit_ProductGlobalSetting
DELETE a
FROM Winlimit_ProductGlobalSetting a WITH(ROWLOCK) 
WHERE a.ProductID=49

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
WHERE a.ProductID=49

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

DROP TABLE #SportBettype
GO