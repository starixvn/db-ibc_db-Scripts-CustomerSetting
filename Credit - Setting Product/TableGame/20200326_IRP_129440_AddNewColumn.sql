/*
    Created: Elodie
    Date: 20200331
    Task: Prepare structure for blocking add new customer
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO

ALTER TABLE [Site] ADD BlockNewCust BIT CONSTRAINT [DF_SettingSystem_BlockNewCust]  DEFAULT ((0))
ALTER TABLE [Site] ADD UnblockTime VARCHAR(50) NULL
GO

UPDATE Site 
SET BlockNewCust = 0

SELECT * FROM Site WITH (NOLOCK)

