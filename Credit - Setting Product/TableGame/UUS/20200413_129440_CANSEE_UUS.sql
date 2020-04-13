/*
	Created: 20200413@Elodie
	Task: Insert CanSee for TableGame UUS [Redmine: #129440] 
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 222, @Bettype = 4901


DELETE FROM ProductLaunchedSiteCurrency WHERE SportType = @Sporttype

INSERT INTO ProductLaunchedSiteCurrency (SportType, BetType, Currency, SiteID, IsLaunched, IsTest)
SELECT @Sporttype AS SportType, @Bettype AS BetType, 20 AS Currency, 1 AS SiteID, 1 AS IsLaunched, 0 AS IsTest

--SELECT * FROM ProductLaunchedSiteCurrency WITH(NOLOCK) WHERE SportType = 241



