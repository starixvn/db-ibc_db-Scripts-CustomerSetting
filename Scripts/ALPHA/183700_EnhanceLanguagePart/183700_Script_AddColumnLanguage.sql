/*<info serverAlias="DBCUST-TESTDBCUST"></info>*/
--/*
--	Date: 2/13/2023 1:03:18
--	Created: Helios 
--	Task: Alpha - Enhance language part ADD Column to Stored Language in DB Local [redmine : #183700]
--*/

USE [CustDB]
GO

ALTER TABLE CustLoginInfo     ADD LanguageUsage varchar(4) NULL
GO
GO
ALTER TABLE CustLoginInfoSub  ADD LanguageUsage varchar(4) NULL
GO