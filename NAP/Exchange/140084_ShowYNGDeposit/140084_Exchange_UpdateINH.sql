/*
    Created: Winfred
    Date: 20200910
    Task: Update data for INH
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO

UPDATE e 
SET OfferSite = 0
FROM Exchange e WITH (ROWLOCK)
WHERE exchangeid = 51