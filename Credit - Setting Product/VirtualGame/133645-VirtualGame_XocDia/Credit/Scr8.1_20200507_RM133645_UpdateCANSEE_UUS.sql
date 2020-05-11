/*
	Created: Eden
	Date: 20200507
	Task: Insert CanSee for Virtual games UUS - Best-Odds - XocDia
	DB: DBCust/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype SMALLINT 
SELECT @Sporttype = 245, @Bettype = 4602

DELETE FROM ProductLaunchedSiteCurrency WHERE SportType = @Sporttype AND BetType = @Bettype

INSERT INTO ProductLaunchedSiteCurrency (SportType, BetType, Currency, SiteID, IsLaunched, IsTest, LaunchedLevel)
SELECT @Sporttype AS SportType, @Bettype AS BetType, 20 AS Currency, 1 AS SiteID, 1 AS IsLaunched, 0 AS IsTest, 1 AS LaunchedLevel

