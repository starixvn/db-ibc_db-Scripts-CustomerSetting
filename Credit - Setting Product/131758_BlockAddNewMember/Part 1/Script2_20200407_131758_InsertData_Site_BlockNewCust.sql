/*
    Created: Eden
    Date: 20200407
    Task: Insert data for [Site_BlockNewCust] table(Temp) [#131758]
    DB: DBCUST/CustDB
*/ 
USE [CustDB]
GO

INSERT INTO [dbo].[Site_BlockNewCust] (siteid, site ,BlockNewCust)
SELECT siteid, site , 0 FROM Site WITH(NOLOCK)