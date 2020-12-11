/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20201211@Eden
	Task: Create Cust_ArchiveAccount table [RM#144903]	
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO
--DROP TABLE [Cust_ArchiveAccount]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cust_ArchiveAccount](
	[CustID] [int] NOT NULL,
	[StageID] [tinyint] NOT NULL,
	[ReducedCredit] [money] NULL,
	[ClosedDate] [datetime] NULL,
	[DisabledDate] [datetime] NULL,
	[SettingDeletedDate] [datetime] NULL,
	[TotalDownline] [int] NULL CONSTRAINT [DF_Cust_ArchiveAccount_TotalDownline] DEFAULT ((0)),
	[RoleID] [tinyint] NULL,
	[ArchivedDate] [date] NULL,
CONSTRAINT PK_Cust_ArchiveAccount PRIMARY KEY CLUSTERED  
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON DATA
) ON DATA
GO