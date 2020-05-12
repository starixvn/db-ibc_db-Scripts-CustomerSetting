/*
	Created: 20200512@Tiara
	Date: 20200512
	Task: Update ProductStatusSiteCurrency for Sexy Gaming [Redmine: #134023]
	DB: DBCUST/CustDB
*/

-- BEGIN DEPLOY THIS SCRIPT ON DBCUST/CustDB	 --
-----------------------------------------------------------
USE CustDB
GO

DECLARE @Sporttype INT, @Bettype INT
SELECT @Sporttype = 243, @Bettype = 3101

CREATE TABLE #NonOfferedCurency (Currency INT) --AUD, NTD, NT, Y$US, P, IRR, PE, PT, CAN, KW
INSERT INTO #NonOfferedCurency (Currency)
SELECT 9 UNION ALL
SELECT 17 UNION ALL
SELECT 30 UNION ALL
SELECT 36 UNION ALL
SELECT 37 UNION ALL
SELECT 40 UNION ALL
SELECT 42 UNION ALL
SELECT 44 UNION ALL
SELECT 50 UNION ALL
SELECT 62 

INSERT INTO ProductStatusSiteCurrency (SportType, BetType, SiteID, Currency, IsHidden, IsDisabled, HasSynced)
SELECT DISTINCT @Sporttype, @Bettype, 0, Currency, 1, 1, 1  
FROM #NonOfferedCurency WITH (NOLOCK)

DROP TABLE #NonOfferedCurency

/*<info serverAlias="DBCUST-CustDB" executers="" selectors="" viewers="" isFunction="0" isNested="0"></info>*/



