/*
	CreatedDate: 20181120@Elodie
	Task: Initial data for currency, code, site of eaGroup table
	DB: DBEAS/bodb_EAS
*/
USE bodb_EAS
GO

--3 affected rows
UPDATE g1
SET g1.Currency = g2.Currency,
	g1.CurrencyCode = g2.CurrencyCode,
	g1.Site = g2.Site
FROM dbo.eaGroup g1
	CROSS JOIN eaGroup g2
WHERE g1.GroupID IN (42,43,44) AND g2.GroupID = 41

SELECT * FROM dbo.eaGroup WITH (NOLOCK)