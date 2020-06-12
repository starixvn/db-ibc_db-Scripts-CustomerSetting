/*
	Created: Elodie
	Date: 20200612
	Task: CAN SEE for SA Gaming UUS [Redmine: 128058]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 244, @Bettype = 3001


DELETE FROM ProductLaunchedSiteCurrency WHERE SportType = @Sporttype

INSERT INTO ProductLaunchedSiteCurrency (SportType, BetType, Currency, SiteID, IsLaunched, IsTest)
SELECT @Sporttype AS SportType, @Bettype AS BetType, 20 AS Currency, 0 AS SiteID, 1 AS IsLaunched, 0 AS IsTest
UNION ALL
SELECT @Sporttype AS SportType, @Bettype AS BetType, 72 AS Currency, 0 AS SiteID, 1 AS IsLaunched, 0 AS IsTest

--SELECT * FROM ProductLaunchedSiteCurrency WITH(NOLOCK) WHERE SportType = 244



