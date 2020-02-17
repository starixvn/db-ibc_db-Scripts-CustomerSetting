/*
    Created: Tiara
    Date: 2020-02-17
    Task : Update dạta for testing on UAT
    DB: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE C
SET C.CurrencyModifier = 1.2
FROM CustSuper C WITH (ROWLOCK, UPDLOCK)
WHERE C.custid = 23003140

UPDATE C
SET C.CurrencyModifier = 2
FROM CustSuper C WITH (ROWLOCK, UPDLOCK)
WHERE C.custid = 35709781

UPDATE D
SET D.CurrencyModifier = 0.95
FROM Dep_CustSuper D WITH (ROWLOCK, UPDLOCK)
WHERE D.custid = 10063437
