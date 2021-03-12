/*
    Created: Winfred
    Date: 20210312
    Task: Update data for KHR
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO

UPDATE e 
SET OfferSite = 0  ,IsActive =1 
FROM Exchange e WITH (ROWLOCK)
WHERE exchangeid = 71
