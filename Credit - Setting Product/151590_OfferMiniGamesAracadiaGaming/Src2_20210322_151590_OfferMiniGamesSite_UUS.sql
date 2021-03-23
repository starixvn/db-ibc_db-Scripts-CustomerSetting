/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210322
	Task: Offer EXISTS currency Mini Games for other Credit sites  - UUS RedmineID:#151590
	DB: DBCust/CustDB
*/

USE CustDB
GO
--==============================================================================
CREATE TABLE #Sport_Temp (SportType SMALLINT,BetType INT)

INSERT INTO #Sport_Temp (SportType,BetType)
SELECT 165 as SportType,1902 as BetType --BigSmall 
UNION ALL
SELECT 165 as SportType,1903 as BetType --OddEven
UNION ALL
SELECT 165 as SportType,1905 as BetType --11HiLo

INSERT INTO SportNonOfferedSiteCurrency (SportType,BetType,Currency,SiteID)
-- Sited non Offered games exclude Currency UUS,YNG
SELECT b.SportType,b.BetType,a.ExchangeId AS Currency,c.SiteID AS SiteID
FROM exchange  a WITH(NOLOCK)
INNER JOIN #Sport_Temp b ON a.isActive = 1 AND a.OfferSite in (0,1) AND a.ExchangeId NOT IN ( 20,72)
INNER JOIN SportNonOfferedSiteCurrency c WITH(NOLOCK) ON b.SportType = c.SportType AND b.BetType = c.BetType AND c.Currency = 0

DROP TABLE #Sport_Temp


--==============================================================================
