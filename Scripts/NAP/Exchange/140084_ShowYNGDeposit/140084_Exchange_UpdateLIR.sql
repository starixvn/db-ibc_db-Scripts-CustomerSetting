/*
    Created: Winfred
    Date: 20200828
    Task: Update data for LIR
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO

UPDATE e 
SET OfferSite = 2 , IsActive = 1
FROM Exchange e WITH (ROWLOCK)
WHERE exchangeid = 73