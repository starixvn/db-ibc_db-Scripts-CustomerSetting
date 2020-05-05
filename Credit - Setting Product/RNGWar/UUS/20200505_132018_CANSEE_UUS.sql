/*
	Created: Tiara
	Date: 20200505
	Task: CAN SEE for RNG War UUS [Redmine: 132018]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 224, @Bettype = 5500


DELETE FROM ProductLaunchedSiteCurrency WHERE SportType = @Sporttype

INSERT INTO ProductLaunchedSiteCurrency (SportType, BetType, Currency, SiteID, IsLaunched, IsTest)
SELECT @Sporttype AS SportType, @Bettype AS BetType, 20 AS Currency, 1 AS SiteID, 1 AS IsLaunched, 0 AS IsTest

--SELECT * FROM ProductLaunchedSiteCurrency WITH(NOLOCK) WHERE SportType = 224



