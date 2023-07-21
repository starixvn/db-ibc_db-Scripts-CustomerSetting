/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20230626@Winfred
	DB: DBCUST/CustDB, DBACC-bodb02 and add pub CustDB_CustSetting
	Task:  Add Spread on rule setting
	Revisions:
		- 20230626@Winfred: NAP CM Customer Class - Add Spread on rule setting [RedmineID: #187354]
*/

--DROP TABLE [dbo].[CustomerClassSpread]
--DROP TABLE [dbo].[CustomerClassSpreadClass]
--DROP TABLE [dbo].[CustomerClassSpreadManagement]

--DROP TABLE [dbo].[CustomerClassSpread_UAT]
--DROP TABLE [dbo].[CustomerClassSpreadClass_UAT]
--DROP TABLE [dbo].[CustomerClassSpreadManagement_UAT]

CREATE TABLE [dbo].[CustomerClassSpread](
	[PolicyID] [int] IDENTITY(1,1) NOT NULL,
	[PolicyTitle] [varchar](500)  NOT NULL,
	[Spread] [decimal](4, 2) NULL,
	[Enable] [bit]  NOT NULL,
	[IsTest] [TINYINT]  NOT NULL,
	[LastModifiedUser] [int] NULL,
	[LastModifiedTime] [datetime] NULL,
 CONSTRAINT [PK_CustomerClassSpread] PRIMARY KEY CLUSTERED
(
	[PolicyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]

GO

CREATE NONCLUSTERED INDEX [IX_CustomerClassSpread_Spread] ON [dbo].[CustomerClassSpread] 
(
	[Spread] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

CREATE TABLE [dbo].[CustomerClassSpreadClass](
	[PolicyID] [int] NOT NULL,
	[CustomerClass] [smallint] NOT NULL,
 CONSTRAINT [PK_CustomerClassSpreadClass] PRIMARY KEY CLUSTERED 
(
	[PolicyID] ASC,
	[CustomerClass] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO

CREATE TABLE [dbo].[CustomerClassSpreadManagement](
	[PolicyID] [int] NOT NULL,
	[Site] [nvarchar](50) NOT NULL,
	[Currency] [int] NOT NULL,
	[Platform] [tinyint] NOT NULL,
 CONSTRAINT [PK_CustomerClassSpreadManagement] PRIMARY KEY CLUSTERED 
(
	[PolicyID] ASC,
	[Site] ASC,
	[Currency] ASC,
	[Platform] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO

--================================= UAT

CREATE TABLE [dbo].[CustomerClassSpread_UAT](
	[PolicyID] [int] IDENTITY(1,1) NOT NULL,
	[PolicyTitle] [varchar](500)  NOT NULL,
	[Spread] [decimal](4, 2) NULL,
	[Enable] [bit]  NOT NULL,
	[IsTest] [TINYINT]  NOT NULL,
	[LastModifiedUser] [int] NULL,
	[LastModifiedTime] [datetime] NULL,
 CONSTRAINT [PK_CustomerClassSpread_UAT] PRIMARY KEY CLUSTERED
(
	[PolicyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]

GO

CREATE TABLE [dbo].[CustomerClassSpreadClass_UAT](
	[PolicyID] [int] NOT NULL,
	[CustomerClass] [smallint] NOT NULL,
 CONSTRAINT [PK_CustomerClassSpreadClass_UAT] PRIMARY KEY CLUSTERED 
(
	[PolicyID] ASC,
	[CustomerClass] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO

CREATE TABLE [dbo].[CustomerClassSpreadManagement_UAT](
	[PolicyID] [int] NOT NULL,
	[Site] [nvarchar](50) NOT NULL,
	[Currency] [int] NOT NULL,
	[Platform] [tinyint] NOT NULL,
 CONSTRAINT [PK_CustomerClassSpreadManagement_UAT] PRIMARY KEY CLUSTERED 
(
	[PolicyID] ASC,
	[Site] ASC,
	[Currency] ASC,
	[Platform] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO
