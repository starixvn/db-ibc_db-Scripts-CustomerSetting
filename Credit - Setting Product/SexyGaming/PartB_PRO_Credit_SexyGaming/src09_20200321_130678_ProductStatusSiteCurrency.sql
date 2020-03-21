/*
	Created: 20200321@Tiara
	Date: 20200321
	Task: Update ProductStatusSiteCurrency for Sexy Gaming [Redmine: #130678]
	DB: DBCUST/CustDB
*/

-- BEGIN DEPLOY THIS SCRIPT ON DBCUST/CustDB	 --
-----------------------------------------------------------
USE CustDB
GO

DECLARE @Sporttype INT, @Bettype INT
SELECT @Sporttype = 243, @Bettype = 3101

CREATE TABLE #NonOfferedCurency (Currency INT) --KHR(KHR); PLN(PLN); CNY(RMB, CY, YUN);MMK(MMK, MKK); VND (INH);INR(INR);RUB(RUB);JPY (JPY); EUR(Euro, EUR); KRW (Won); SGD (SD$)
INSERT INTO #NonOfferedCurency (Currency)
SELECT 56 UNION ALL
SELECT 13 UNION ALL
SELECT 81 UNION ALL
SELECT 66 UNION ALL
SELECT 69 UNION ALL
SELECT 70 UNION ALL
SELECT 51 UNION ALL
SELECT 61 UNION ALL
SELECT 55 UNION ALL
SELECT 32 UNION ALL
SELECT 6 UNION ALL
SELECT 78 UNION ALL
SELECT 45 UNION ALL
SELECT 1

DELETE FROM ProductStatusSiteCurrency WHERE SportType=@Sporttype

INSERT INTO ProductStatusSiteCurrency (SportType, BetType, SiteID, Currency, IsHidden, IsDisabled, HasSynced)
SELECT DISTINCT @Sporttype, @Bettype, 0, Currency, 1, 1, 1  
FROM #NonOfferedCurency WITH (NOLOCK)

DROP TABLE #NonOfferedCurency


