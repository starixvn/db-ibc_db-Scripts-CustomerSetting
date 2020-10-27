/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200909
	Task: offer ION for new site/currency ( ION / 76666B  / MMK) RedmineID:#141926
	DB: DBCust/CustDB
*/

USE CustDB
GO

DECLARE @Sporttype INT, @Bettype INT, @SiteID INT , @ExchangeId INT
SELECT @Sporttype = 225, @Bettype = 5601,@SiteID = 547,@ExchangeId = 69  --MMK 

DELETE FROM ProductStatusSiteCurrency 
WHERE SportType=@Sporttype AND BetType  = @Bettype AND (SiteID = @SiteID or Currency = @ExchangeId) --ION

CREATE TABLE #NonOfferedCurency (Currency INT,SiteID INT) 

INSERT INTO #NonOfferedCurency (Currency,SiteID)
SELECT @ExchangeId as exchangeid , SiteID
FROM Site WITH(NOLOCK) 
WHERE siteid NOT IN (@SiteID ) --supported sites 
AND isActive = 1 AND isLicensee = 0 AND isDeposit = 0

INSERT INTO ProductStatusSiteCurrency (SportType, BetType, SiteID, Currency, IsHidden, IsDisabled, HasSynced)
SELECT DISTINCT @Sporttype, @Bettype, SiteID, Currency, 1, 1, 1  
FROM #NonOfferedCurency WITH (NOLOCK)


DROP TABLE #NonOfferedCurency

---------------ProductLaunchedSiteCurrency-------------------------
DELETE FROM ProductLaunchedSiteCurrency  WHERE SportType=@Sporttype AND BetType  = @Bettype AND SiteID = @SiteID AND Currency = @ExchangeId

INSERT INTO ProductLaunchedSiteCurrency (SiteID, Currency, SportType, IsLaunched, IsTest, BetType, LaunchedLevel)
SELECT @SiteID, @ExchangeId as Currency, @Sporttype, 1 as IsLaunched,0 as  IsTest, @Bettype,0 as LaunchedLevel
