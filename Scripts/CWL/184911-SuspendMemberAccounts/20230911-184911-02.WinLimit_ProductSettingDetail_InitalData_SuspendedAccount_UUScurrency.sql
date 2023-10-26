/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230911@Tacy
	Task: WinLimit_ProductSettingDetail - Initial data for new columns - UUS Currency
		 https://nexdev.net/issues/192624 [RedmineID: #192624]
	Database: DBCUST/CustDB

	Revision:
		- 20231025@Tacy: No need to run
*/

USE CustDB
GO

DECLARE @WinlimitLevel_min INT, @WinlimitLevel_max INT

SET @WinlimitLevel_min = 2
SET @WinlimitLevel_max = 100

DECLARE @Products TABLE (ProductId TINYINT)
DECLARE @Groups	TABLE (GroupID TINYINT)

--Products
INSERT INTO @Products (ProductId)
SELECT DISTINCT RealProductId
FROM SportBettypeSettingMatrix sm WITH (NOLOCK)
WHERE ProductID=18

--Groups
INSERT INTO @Groups (GroupID)
SELECT GroupID
FROM Winlimit_Group WITH (NOLOCK)
WHERE GroupName LIKE '%Promotion%'
OR GroupName LIKE '%Jackpot%'

CREATE TABLE #WinLimit_ProductSettingDetail(
	[ProductID] [tinyint] NOT NULL,
	[GroupID] [smallint] NOT NULL,
	[ExchangeID] [int] NOT NULL,
	[SiteID] [int] NOT NULL,
	[LevelID] [tinyint] NOT NULL,
	PRIMARY KEY CLUSTERED 
	(
		[ProductID] ASC,
		[GroupID] ASC,
		[ExchangeID] ASC,
		[SiteID] ASC,
		[LevelID] ASC
	)
)

CREATE TABLE #WinLimit_ProductSettingDetail_tmp(
	[ProductID] [tinyint] NOT NULL,
	[GroupID] [smallint] NOT NULL,
	[ExchangeID] [int] NOT NULL,
	[SiteID] [int] NOT NULL,
	[LevelID] [tinyint] NOT NULL,
	PRIMARY KEY CLUSTERED 
	(
		[ProductID] ASC,
		[GroupID] ASC,
		[ExchangeID] ASC,
		[SiteID] ASC,
		[LevelID] ASC
	)
)

INSERT INTO #WinLimit_ProductSettingDetail (ProductID, GroupID, ExchangeID, SiteID, LevelID)
SELECT psd.ProductID, psd.GroupID, psd.ExchangeID, psd.SiteID, LevelID
FROM WinLimit_ProductSettingDetail psd WITH (NOLOCK)
INNER JOIN exchange e WITH (NOLOCK) ON e.ExchangeId=psd.ExchangeID
INNER JOIN Site s WITH (NOLOCK) ON s.siteid=psd.SiteID
INNER JOIN @Products p ON p.ProductId=psd.ProductID
LEFT JOIN @Groups g ON g.GroupID=psd.GroupID
WHERE LevelID BETWEEN @WinlimitLevel_min AND @WinlimitLevel_max
AND E.OfferSite IN (0,1) AND s.isDeposit=0 AND psd.ExchangeID=20
AND SiteLabel='MBC' AND g.GroupID IS NULL

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #WinLimit_ProductSettingDetail_tmp

	DELETE TOP (2000) T
	OUTPUT deleted.ProductID, deleted.GroupID, deleted.ExchangeID, deleted.SiteID, deleted.LevelID
	INTO #WinLimit_ProductSettingDetail_tmp(ProductID, GroupID, ExchangeID, SiteID, LevelID)
	FROM #WinLimit_ProductSettingDetail T

	IF @@ROWCOUNT=0
		BREAK;

	UPDATE psd
	SET psd.IsSuspendedAccount=1
	FROM WinLimit_ProductSettingDetail psd WITH (NOLOCK)
	INNER JOIN #WinLimit_ProductSettingDetail_tmp t
		ON t.ProductID=psd.ProductID
		AND t.GroupID=psd.GroupID
		AND t.ExchangeID=psd.ExchangeID
		AND t.SiteID=psd.SiteID
		AND t.LevelID=psd.LevelID
END

DROP TABLE #WinLimit_ProductSettingDetail, #WinLimit_ProductSettingDetail_tmp
GO