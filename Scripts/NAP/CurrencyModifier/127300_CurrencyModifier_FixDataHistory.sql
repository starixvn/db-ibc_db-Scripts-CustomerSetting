/*
    Created: Elodie
    Date: 20200403
    Task: Add Currency Modifier history
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO

--5 affected rows
INSERT INTO CurrencyModifier_History(CustId, CurrencyModifier, FromDate, ToDate)
SELECT s.custid, 0.95, c.creatdate, '9999-12-31 0:00:00.000'
FROM dbo.Dep_CustSuper s WITH (NOLOCK)
	INNER JOIN Customer c WITH (NOLOCK) ON c.custid = s.custid
	INNER JOIN dbo.exchange e WITH (NOLOCK) ON e.exchangeid = s.currency
WHERE e.currency = 'RMB'
	AND NOT EXISTS (SELECT 1 FROM CurrencyModifier_History WITH (NOLOCK) WHERE custid = s.custid)

