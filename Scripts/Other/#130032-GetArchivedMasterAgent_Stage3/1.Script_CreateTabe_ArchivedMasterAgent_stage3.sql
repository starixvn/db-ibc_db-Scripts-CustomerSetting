/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20201211@Eden
	Task: Create ArchivedMasterAgent_Stage3 table  to get report for CSD [RM#144903]	
	DB: DBCUST/CustDB
*/

USE [CustDB]
GO
--DROP TABLE [ArchivedMasterAgent_Stage3]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].ArchivedMasterAgent_Stage3(
	[CustID] [int] NOT NULL,
	[username] VARCHAR(30) NOT NULL,
	[Level] VARCHAR(10) NULL
) ON DATA
GO
CREATE NONCLUSTERED INDEX ix_ArchivedMasterAgent_Stage3_username ON ArchivedMasterAgent_Stage3(username)
GO
GRANT SELECT ON OBJECT::[dbo].ArchivedMasterAgent_Stage3 TO dot_casino; 
GO
GRANT SELECT ON OBJECT::[dbo].ArchivedMasterAgent_Stage3 TO vnteam; 
GO