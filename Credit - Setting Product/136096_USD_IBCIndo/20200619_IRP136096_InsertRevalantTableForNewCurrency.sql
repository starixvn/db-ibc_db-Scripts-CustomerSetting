/*
	Created: 20200619@Elodie
	Task: Initial PlayCurrencySetting [redmine:#136096]
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO

DECLARE @CurrencyFrom INT = 22, @CurrencyTo INT = 95

INSERT INTO PlayCurrencySetting(SiteId, SiteName, SportType, MemberCurrency, PlayCurrency, FromDate, ToDate)
SELECT 487, 'IBCIndo', 211, @CurrencyTo, 5, '2020-06-19', '2050-01-01'

UPDATE e
SET PJUnitPrice = 0.2552 
FROM Exchange e WITH (ROWLOCK)
WHERE Exchangeid = @CurrencyTo