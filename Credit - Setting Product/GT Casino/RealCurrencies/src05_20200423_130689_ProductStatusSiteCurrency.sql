/*
	Created: 20200423@Tiara
	Date: 20200423
	Task: Update ProductStatusSiteCurrency for GT Casino [Redmine: #130689]
	DB: DBCUST/CustDB
*/

-- BEGIN DEPLOY THIS SCRIPT ON DBCUST/CustDB	 --
-----------------------------------------------------------
USE CustDB
GO

DECLARE @Sporttype INT, @Bettype INT
SELECT @Sporttype = 242, @Bettype = 3201

CREATE TABLE #NonOfferedCurency (Currency INT) --KHR(KHR); PLN(PLN); VND (INH);INR(INR);RUB(RUB);JPY (JPY);SGD (SD$)
INSERT INTO #NonOfferedCurency (Currency)
SELECT 71 UNION ALL
SELECT 56 UNION ALL
SELECT 51 UNION ALL
SELECT 61 UNION ALL
SELECT 55 UNION ALL
SELECT 32 UNION ALL
SELECT 1

DELETE FROM ProductStatusSiteCurrency WHERE SportType=@Sporttype

INSERT INTO ProductStatusSiteCurrency (SportType, BetType, SiteID, Currency, IsHidden, IsDisabled, HasSynced)
SELECT DISTINCT @Sporttype, @Bettype, 0, Currency, 1, 1, 1  
FROM #NonOfferedCurency WITH (NOLOCK)

DROP TABLE #NonOfferedCurency
