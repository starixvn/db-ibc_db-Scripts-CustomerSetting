/*
	Created: 20200504@Eden
	Task: Update ProductStatusSiteCurrency for Virtual game
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @SportBettype TABLE( Sporttype INT, Bettype INT )
INSERT INTO @SportBettype(Sporttype,Bettype)
SELECT 245,4601 
UNION ALL SELECT 245,4602

DELETE a
FROM ProductStatusSiteCurrency a WITH(ROWLOCK)
	INNER JOIN @SportBettype s ON s.SportType = a.Sporttype AND s.BetType = a.BetType

CREATE TABLE #NonOfferedCurency (Currency INT) 

INSERT INTO #NonOfferedCurency (Currency)
SELECT exchangeid 
FROM exchange WITH(NOLOCK) 
WHERE exchangeid  NOT IN ( 	2	--RM
					, 	71	--KHR
					, 	56	--PLN
					, 	67	--HKK
					, 	16	--Yen
					, 	64	--UT
					, 	35	--$US
					, 	3	--US$
					, 	69	--MMK
					, 	70	--MKK
					, 	72	--YNG
					, 	13	--RMB
					, 	81	--CY
					, 	66	--YUN
					, 	5	--HK$
					, 	47	--DDD
					, 	22	--IND
					, 	34	--IDR
					, 	33	--IDD
					, 	15	--IN
					, 	43	--THB
					, 	4	--TB
					, 	45	--Won
					, 	51	--INH
					, 	61	--INR
					, 	55	--RUB
					, 	6	--EURO
					, 	12	--GBP
					, 	32	--JPY
					,   20  --UUS
					) --Offered Currencies

INSERT INTO ProductStatusSiteCurrency (SportType, BetType, SiteID, Currency, IsHidden, IsDisabled, HasSynced)
SELECT DISTINCT s.Sporttype, s.Bettype, 0, a.Currency, 1, 1, 1  
FROM #NonOfferedCurency a WITH (NOLOCK)
	CROSS APPLY @SportBettype s

SELECT a.* 
FROM ProductStatusSiteCurrency a WITH(NOLOCK) 
	INNER JOIN @SportBettype s ON s.SportType = a.Sporttype AND s.BetType = a.BetType

DROP TABLE #NonOfferedCurency





