/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210219@Eden
	Task: Create table VRMemberBigStake [RM#150298]
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO
--DROP TABLE [dbo].[VRMemberBigStake]
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VRMemberBigStake](
	[CustID] [int] NOT NULL,
	[Type] [tinyint] NOT NULL,
	[FirstBetDate] [date] NULL,
	[Status] [TINYINT] NULL
 CONSTRAINT [PK_VRMemberBigStake] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [virtualrate_table]
) ON [virtualrate_table]

GO
CREATE NONCLUSTERED INDEX [IX_VRMemberBigStake_FirstBetDate] ON [dbo].[VRMemberBigStake]
(
	[FirstBetDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [virtualrate_table]
GO
