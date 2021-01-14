/*
	Created: 20201110@Tina
	Task: Insert CanSee for Big Gaming YNG [Redmine: #142458] 
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 239, @Bettype = 3501


DELETE FROM ProductLaunchedSiteCurrency WHERE SportType = @Sporttype

INSERT INTO ProductLaunchedSiteCurrency (SportType, BetType, Currency, SiteID, IsLaunched, IsTest)
SELECT @Sporttype AS SportType, @Bettype AS BetType, 72 AS Currency, 1 AS SiteID, 1 AS IsLaunched, 0 AS IsTest

--SELECT * FROM ProductLaunchedSiteCurrency WITH(NOLOCK) WHERE SportType = 239



