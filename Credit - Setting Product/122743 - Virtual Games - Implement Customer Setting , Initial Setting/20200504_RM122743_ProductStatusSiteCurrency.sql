/*
	Created: 20200504@Eden
	Task: Update ProductStatusSiteCurrency for Virtual game [Redmine: 122743]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype INT, @Bettype INT
SELECT @Sporttype = 245, @Bettype = 4601

DELETE FROM ProductStatusSiteCurrency WHERE SportType=@Sporttype

CREATE TABLE #NonOfferedCurency (Currency INT) 

INSERT INTO #NonOfferedCurency (Currency)
SELECT exchangeid 
FROM exchange WITH(NOLOCK) 
WHERE exchangeid  IN (72,27,28,17,21,31,36,37,40,44,46,50,62,63,65,68,73) -- non supported currencies

INSERT INTO ProductStatusSiteCurrency (SportType, BetType, SiteID, Currency, IsHidden, IsDisabled, HasSynced)
SELECT DISTINCT @Sporttype, @Bettype, 0, Currency, 1, 1, 1  
FROM #NonOfferedCurency WITH (NOLOCK)

DROP TABLE #NonOfferedCurency





