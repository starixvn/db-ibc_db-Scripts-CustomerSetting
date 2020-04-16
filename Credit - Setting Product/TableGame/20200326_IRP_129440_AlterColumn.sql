/*
    Created: Elodie
    Date: 20200416
    Task: alter RealProductId
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO

ALTER TABLE dbo.ProductSettingDetail ADD RealProductId TINYINT NOT NULL
GO


