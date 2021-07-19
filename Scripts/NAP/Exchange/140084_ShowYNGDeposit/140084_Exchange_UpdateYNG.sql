/*
    Created: Winfred
    Date: 20200828
    Task: Update data for YNG
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO

UPDATE e 
SET OfferSite = 0
FROM Exchange e WITH (ROWLOCK)
WHERE exchangeid = 72