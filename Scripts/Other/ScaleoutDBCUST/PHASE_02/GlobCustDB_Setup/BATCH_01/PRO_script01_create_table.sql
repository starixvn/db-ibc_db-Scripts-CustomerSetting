/*<info serverAlias="DBGLOB-GlobCustDB" executers="" viewers="" isFunction="0"></info>*/
/*
	Created: DaveTruong
	Date: 20250120
	Task: Create table ScaleOut Custsetting on  GlobCustDB [RedmineID:#217137]
	DB: DBGLOB/GlobCustDB
*/
USE [GlobCustDB]
GO
IF OBJECT_ID('Site', 'V') IS NOT NULL
    DROP VIEW [Site];
GO
IF OBJECT_ID('SiteDBConfig', 'V') IS NOT NULL
    DROP VIEW SiteDBConfig;
GO

/*Site*/
/****** Object:  Table [dbo].[Site]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Site](
	[siteid] [int] IDENTITY(1,1) NOT NULL,
	[site] [nvarchar](50) NULL,
	[type] [nvarchar](50) NULL,
	[spreada] [float] NULL,
	[spreadb] [float] NULL,
	[spreadc] [float] NULL,
	[spreadd] [float] NULL,
	[spreade] [float] NULL,
	[spreadf] [float] NULL,
	[ServerID] [int] NOT NULL,
	[isLicensee] [bit] NOT NULL,
	[isActive] [bit] NOT NULL,
	[isDeposit] [bit] NOT NULL,
	[SpecialGroup] [tinyint] NULL,
	[BlockNewCust] [bit] NULL,
	[UnblockTime] [varchar](50) NULL,
	[IsChinaView] [bit] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[SiteDBGroupID] [smallint] NOT NULL,
	[SiteLabel] [varchar](50) NULL,
	[SpecialPlatfrom] [tinyint] NULL,
	[CustDBGroupID] [smallint] NOT NULL,
	[SiteType] [tinyint] NULL,
 CONSTRAINT [PK_Site] PRIMARY KEY NONCLUSTERED 
(
	[siteid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[Site] ADD  CONSTRAINT [DF_Site_ServerID]  DEFAULT ((0)) FOR [ServerID]
GO
ALTER TABLE [dbo].[Site] ADD  CONSTRAINT [DF_Site_isLicensee]  DEFAULT ((0)) FOR [isLicensee]
GO
ALTER TABLE [dbo].[Site] ADD  CONSTRAINT [DF_Site_isActive]  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[Site] ADD  CONSTRAINT [DF_Site_SpecialGroup]  DEFAULT ((0)) FOR [SpecialGroup]
GO
ALTER TABLE [dbo].[Site] ADD  CONSTRAINT [DF_SettingSystem_BlockNewCust]  DEFAULT ((0)) FOR [BlockNewCust]
GO
ALTER TABLE [dbo].[Site] ADD  CONSTRAINT [DF_Site_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
ALTER TABLE [dbo].[Site] ADD  CONSTRAINT [DF_Site_SiteDBGroupID]  DEFAULT ((0)) FOR [SiteDBGroupID]
GO
ALTER TABLE [dbo].[Site] ADD  CONSTRAINT [DF_Site_SpecialPlatform]  DEFAULT ((0)) FOR [SpecialPlatfrom]
GO
ALTER TABLE [dbo].[Site] ADD  CONSTRAINT [DF_Site_CustDBGroupID]  DEFAULT ((0)) FOR [CustDBGroupID]
GO
ALTER TABLE [dbo].[Site] ADD  CONSTRAINT [DF_Site_SiteType]  DEFAULT ((0)) FOR [SiteType]
GO
CREATE NONCLUSTERED INDEX [IX_RepUpdateTime] ON [dbo].[Site]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
CREATE UNIQUE CLUSTERED INDEX [IX_Site] ON [dbo].[Site]
(
	[site] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO


/*SiteDBConfig*/
/****** Object:  Table [dbo].[SiteDBConfig]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SiteDBConfig](
	[SiteDBGroupID] [smallint] NOT NULL,
	[LinkedServerName] [varchar](512) NULL,
	[ClientAccessName] [varchar](512) NULL,
	[AGIP] [varchar](50) NULL,
	[AWSProxyDomain] [varchar](50) NULL,
	[AWSProxyPort] [int] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[FQDN] [varchar](50) NULL,
 CONSTRAINT [PK_SiteDBConfig_SiteDBGroupID] PRIMARY KEY CLUSTERED 
(
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[SiteDBConfig] ADD  CONSTRAINT [DF_SiteDBConfig_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
CREATE NONCLUSTERED INDEX [IX_SiteDBConfig_RepUpdateTime] ON [dbo].[SiteDBConfig]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
