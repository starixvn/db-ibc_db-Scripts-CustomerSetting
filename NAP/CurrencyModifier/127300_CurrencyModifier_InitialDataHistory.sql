/*
    Created: Elodie
    Date: 20200116
    Task: Set Currency Modifier = 1 for RMB Licensee
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @FromDate DATETIME = GETDATE()

--333 affected rows
INSERT INTO CurrencyModifier_History(CustId, CurrencyModifier, FromDate, ToDate)
SELECT s.custid, 0.95, @FromDate, '9999-12-31 0:00:00.000'
FROM dbo.Dep_CustSuper s WITH (ROWLOCK)
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON e.exchangeid = s.currency
WHERE e.currency = 'RMB'

SELECT * 
FROM dbo.Dep_CustSuper s WITH (NOLOCK)
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON e.exchangeid = s.currency
WHERE e.currency = 'RMB'