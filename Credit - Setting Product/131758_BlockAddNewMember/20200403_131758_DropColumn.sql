/*
    Created: Eden
    Date: 20200403
    Task: Drop column BlockNewCusti7, UnblockTime of SettingSystem table [#131758]
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO
--Drop constraint
ALTER TABLE dbo.SettingSystem DROP CONSTRAINT DF_SettingSystem_BlockNewCusti7
GO

--DROP columns
ALTER TABLE dbo.SettingSystem DROP COLUMN BlockNewCusti7
GO
ALTER TABLE dbo.SettingSystem DROP COLUMN UnblockTime
GO