/*
	Created: Winnie
	Date: 20181226
	Task: VS Betradar 3 - Virtual Soccer Asian Cup - Rollback [RedmineID: #104809]
	DB: DBCust/CustDB
*/
USE [CustDB]
GO

CREATE TABLE #temp(SiteID INT,Currency INT,SportType SMALLINT)

INSERT INTO #temp(SiteID ,Currency ,SportType )
SELECT [SiteID], 0, 194
FROM Site WITH(NOLOCK)
where isLicensee = 0 and isDeposit = 0
and isActive = 1


UPDATE p
	SET p.Currency=20
FROM ProductLaunchedSiteCurrency p WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #temp t ON p.SiteID=t.SiteID AND p.sporttype=t.SportType 
