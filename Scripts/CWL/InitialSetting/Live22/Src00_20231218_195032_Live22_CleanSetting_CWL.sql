/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator: 20231218@Tacy
	Task: CWL - Clean data - Live22 [Redmine: #195092]
	Database:	DBCUST.CustDB
*/
USE CustDB
GO

DELETE FROM Winlimit_Group WITH (ROWLOCK)
WHERE GroupID IN (64,65)

DELETE FROM Winlimit_GameGroupSetting WITH (ROWLOCK)
WHERE GroupID IN (64,65)

DELETE FROM Winlimit_ProductGlobalSetting WITH (ROWLOCK)
WHERE GroupID IN (64,65)

DELETE FROM Winlimit_productsetting WITH (ROWLOCK)
WHERE ProductID =79

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
FROM WinLimit_ProductSettingDetail a WITH(NOLOCK) 
WHERE ProductID=79

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

DROP TABLE #WinLimit_ProductSettingDetail, #WinLimit_ProductSettingDetail_Batch