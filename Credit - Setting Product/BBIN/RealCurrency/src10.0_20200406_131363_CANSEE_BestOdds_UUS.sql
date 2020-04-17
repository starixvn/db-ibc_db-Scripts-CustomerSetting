/*
	Created: 20200406@Eden
	Task: Insert CanSee for BBIN [Redmine: #131363] - UUS BestOdds
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 241, @Bettype = 3300

INSERT INTO ProductLaunchedSiteCurrency (SportType, BetType, Currency, SiteID, IsLaunched, IsTest)
SELECT @Sporttype AS SportType, @Bettype AS BetType, 20 AS Currency, 1 AS SiteID, 1 AS IsLaunched, 0 AS IsTest


--SELECT * FROM ProductLaunchedSiteCurrency WHERE SportType = 241



