/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20201211@Eden
	Task: Create ArchivedMasterAgent_Stage3 table  to get report for CSD [RM#130032]	
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
	[Level] VARCHAR(10) NULL,
 CONSTRAINT [PK_ArchivedMasterAgent_Stage3] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON DATA
GO
CREATE NONCLUSTERED INDEX ix_ArchivedMasterAgent_Stage3_username ON ArchivedMasterAgent_Stage3(username)
GO
GRANT SELECT ON OBJECT::[dbo].ArchivedMasterAgent_Stage3 TO dot_casino; 
GO