/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20200805@Eden
	Task: Create table VRCustAutoAdjustment [RM#138168]
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO
--DROP TABLE [dbo].[VRCustAutoAdjustment]
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VRCustAutoAdjustment](
	[SportType] [smallint] NOT NULL,
	[CustID] [int] NOT NULL,
	[FirstBetDate] [SMALLDATETIME] NULL
 CONSTRAINT [PK_VRCustAutoAdjustment] PRIMARY KEY CLUSTERED 
(
	[SportType] ASC,
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [virtualrate_table]
) ON [virtualrate_table]

GO
CREATE NONCLUSTERED INDEX [IX_FirstBetDate] ON [dbo].[VRCustAutoAdjustment]
(
	[FirstBetDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [virtualrate_table]
GO
