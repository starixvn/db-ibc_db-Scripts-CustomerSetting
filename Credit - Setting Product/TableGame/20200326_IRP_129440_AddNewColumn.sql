/*
    Created: Elodie
    Date: 20200331
    Task: Add RealProductId
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO

ALTER TABLE dbo.ProductSettingDetail ADD RealProductId TINYINT NULL
GO


