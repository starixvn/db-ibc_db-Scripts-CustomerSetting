/*
    Created: Elodie
    Date: 20200323
    Task: Prepare structure for blocking add new customer
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO

ALTER TABLE dbo.SettingSystem ADD BlockNewCusti7 BIT CONSTRAINT [DF_SettingSystem_BlockNewCusti7]  DEFAULT ((0))

UPDATE SettingSystem 
SET BlockNewCusti7 = 0

