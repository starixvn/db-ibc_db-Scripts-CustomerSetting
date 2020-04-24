/*
	Created: 20200421@Elodie
	Task: Insert CanSee for GTCasino UUS [Redmine: #130689] 
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 242, @Bettype = 3201


DELETE FROM ProductLaunchedSiteCurrency WHERE SportType = @Sporttype

--20
INSERT INTO ProductLaunchedSiteCurrency (SportType, BetType, Currency, SiteID, IsLaunched, IsTest)
SELECT @Sporttype AS SportType, @Bettype AS BetType, 20 AS Currency, 0 AS SiteID, 1 AS IsLaunched, 1 AS IsTest  

--SELECT * FROM ProductLaunchedSiteCurrency WITH(NOLOCK) WHERE SportType = 242



