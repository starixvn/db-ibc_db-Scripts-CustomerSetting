/*
	Created: Eden@20201216
	Task: Insert value SportNonOfferedSiteCurrency for Max Game [RM:#147232]
	DB: DBCUST/CustDB
*/
--SELECT * from SportNonOfferedSiteCurrency with(nolock) where sporttype = 237
--SELECT * FROM ProductSettingDetail with(nolock)   where ProductID = 22 and SettingType = 8

DECLARE @SportType INT = 237,@BetType INT = 5401

--Delete data exits
DELETE 
FROM SportNonOfferedSiteCurrency WITH(ROWLOCK)
WHERE SportType = @SportType AND BetType = @BetType

-- Currencies non Offered
INSERT INTO SportNonOfferedSiteCurrency (SportType,BetType,Currency,SiteID)
SELECT 
	@SportType as SportType,
	@BetType as BetType,
	e.ExchangeId as Currency, -- all currency
	0 AS SiteID
FROM exchange e WITH(NOLOCK) 
WHERE e.currency NOT IN	 ('IN'
						,'IND'
						,'IDD'
						,'IDR'
						,'DDD'
						,'EURO'
						,'GBP'
						,'HK$'
						,'HKK'
						,'INH'
						,'INR'
						,'RM'
						,'RMB'
						,'THB'
						,'US$'
						,'Yen'
						,'$US'
						,'UT'
						,'USD'
						,'Won'
						,'MMK'
						,'YNG'
						,'UUS') 

SELECT *
FROM SportNonOfferedSiteCurrency WITH(NOLOCK)
WHERE SportType = @SportType AND BetType = @BetType

