/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20201127@Tina
	Task: Insert CanSee for Gold Diamond Gaming YNG [Redmine: #144105] 
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 236, @Bettype = 5701


DELETE FROM ProductLaunchedSiteCurrency WHERE SportType = @Sporttype

INSERT INTO ProductLaunchedSiteCurrency (SportType, BetType, Currency, SiteID, IsLaunched, IsTest)
SELECT @Sporttype AS SportType, @Bettype AS BetType, 72 AS Currency, 1 AS SiteID, 1 AS IsLaunched, 0 AS IsTest

--SELECT * FROM ProductLaunchedSiteCurrency WITH(NOLOCK) WHERE SportType = 236



