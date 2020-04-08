/*
	Created: 20200406@Eden
	Task: Update ProductStatusSiteCurrency for BBIN
	DB: DBCUST/CustDB
*/

USE CustDB
GO
DELETE FROM ProductStatusSiteCurrency WITH(ROWLOCK) WHERE Sporttype = 241

CREATE TABLE #NonOfferedCurency (Currency INT) 

INSERT INTO #NonOfferedCurency (Currency)
SELECT exchangeid 
FROM exchange WITH(NOLOCK) 
WHERE exchangeid NOT IN (12,
						13,
						15,
						16,
						2,
						22,
						3,
						33,
						34,
						35,
						4,
						43,
						45,
						47,
						5,
						51,
						55,
						6,
						61,
						64,
						66,
						67,
						74,
						78,
						81,
						20,72 --test
					) --supported currencies


INSERT INTO ProductStatusSiteCurrency (SportType, BetType, SiteID, Currency, IsHidden, IsDisabled, HasSynced)
SELECT DISTINCT 241, 3300, 0, Currency, 1, 1, 1  
FROM #NonOfferedCurency WITH (NOLOCK)

DROP TABLE #NonOfferedCurency





