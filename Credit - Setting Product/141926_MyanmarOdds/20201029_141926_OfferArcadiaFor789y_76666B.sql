/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20201029
	Task: offer product and games for new site 76666B currency MMK RedmineID:#141926
	DB: DBCust/CustDB
*/

USE CustDB
GO

--==============================================================================
--Offer Arcadia Mini Games and Arcadia Lotto for 789y and 76666B

CREATE TABLE #Sport_Temp (SportType SMALLINT,BetType INT)

INSERT INTO #Sport_Temp (SportType,BetType)
SELECT 165 as SportType,1902 as BetType --BigSmall 
UNION ALL
SELECT 165 as SportType,1903 as BetType --OddEven
UNION ALL
SELECT 165 as SportType,1904 as BetType --Lotto3
UNION ALL
SELECT 165 as SportType,1905 as BetType --11HiLo

--Delete data exists
DELETE a FROM SportNonOfferedSiteCurrency a INNER JOIN #Sport_Temp b ON a.SportType = b.SportType AND a.BetType = b.BetType

INSERT INTO SportNonOfferedSiteCurrency (SportType,BetType,Currency,SiteID)
-- Sited non Offered games
SELECT b.SportType,b.BetType,0 AS Currency,a.siteid AS SiteID
FROM Site  a WITH(NOLOCK)
INNER JOIN #Sport_Temp b ON a.isActive = 1 AND a.isLicensee = 0 AND a.isDeposit = 0 AND siteid not in (3,547,1)
UNION ALl
-- Site BEST-ODDS Currency UUS
SELECT b.SportType,b.BetType,a.ExchangeId AS Currency,1 AS SiteID
FROM exchange  a WITH(NOLOCK)
INNER JOIN #Sport_Temp b ON a.isActive = 1 AND a.OfferSite in (0,1) AND a.ExchangeId <> 20

DROP TABLE #Sport_Temp