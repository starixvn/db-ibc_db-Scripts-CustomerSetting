/*
    Created: Eden
    Date: 20200407
    Task: Prepare structure for blocking add new customer (Temp) [#131758]
    DB: DBCUST/CustDB
*/ 
USE [CustDB]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
--DROP TABLE [Site_BlockNewCust]
CREATE TABLE [dbo].[Site_BlockNewCust](
	[siteid] [int] NOT NULL,
	[site] [nvarchar](50) NULL,
	[BlockNewCust] [bit] NULL CONSTRAINT [DF_Site_BlockNewCust_1]  DEFAULT ((0)),
	[UnblockTime] [varchar](50) NULL,
 CONSTRAINT [PK_Site_BlockNewCust] PRIMARY KEY NONCLUSTERED 
(
	[siteid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

CREATE UNIQUE CLUSTERED INDEX [IX_Site_BlockNewCust] ON [dbo].[Site_BlockNewCust]
(
	[site] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [DATA]
GO

GRANT SELECT ON [dbo].[Site_BlockNewCust] TO [bodbAdminNet] AS [dbo]
GO

GRANT SELECT ON [dbo].[Site_BlockNewCust] TO [bodbDownlineNet] AS [dbo]
GO

GRANT SELECT ON [dbo].[Site_BlockNewCust] TO [bodbDownlineNetView] AS [dbo]
GO

GRANT SELECT ON [dbo].[Site_BlockNewCust] TO [bodbExtAccNet] AS [dbo]
GO

GRANT SELECT ON [dbo].[Site_BlockNewCust] TO [bodbLicenseeNet] AS [dbo]
GO

SET ANSI_PADDING OFF
GO




