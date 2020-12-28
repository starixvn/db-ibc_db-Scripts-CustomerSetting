/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20201211@Eden
	Task: Create ArrchivedMasterAgent_stage3 table  to get report for CSD [RM#144903]	
	DB: DBCUST/CustDB
*/

USE [CustDB]
GO
--DROP TABLE [ArrchivedMasterAgent_stage3]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].ArrchivedMasterAgent_stage3(
	[CustID] [int] NOT NULL,
	[username] VARCHAR(30) NOT NULL,
	[Level] VARCHAR(10) NULL
) ON DATA
GO
CREATE NONCLUSTERED INDEX ix_ArrchivedMasterAgent_stage3_username ON ArrchivedMasterAgent_stage3(username)