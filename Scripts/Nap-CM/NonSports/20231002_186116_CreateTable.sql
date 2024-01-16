/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20231002@Winfred
	DB: DBCUST/CustDB, DBTP-bodb02
	Task:  Support for Non-Sports and add in house replication
	Revisions:
		- 20231002@Winfred: NAP CM Customer Class - Support for Non-Sports [RedmineID: #186116]
*/

--DROP TABLE [dbo].[CustomerClassNonSports]
--DROP TABLE [dbo].[CustomerClassNonSportsDetail]

--DROP TABLE [dbo].[CustomerClassNonSports_UAT]
--DROP TABLE [dbo].[CustomerClassNonSportsDetail_UAT]

CREATE TABLE [dbo].[CustomerClassNonSports](
	[PolicyID] [int] IDENTITY(1,1) NOT NULL,
	[PolicyTitle] [varchar](500)  NOT NULL,
	[MaxBet] [int] NULL,
	[Products] [binary](32) NULL,
	[Enable] [bit]  NOT NULL,
	[IsTest] [TINYINT]  NOT NULL,
	[LastModifiedUser] [int] NULL,
	[LastModifiedTime] [datetime] NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_CustomerClassNonSports] PRIMARY KEY CLUSTERED
(
	[PolicyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[CustomerClassNonSports] ADD  CONSTRAINT [DF_CustomerClassNonSports_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

ALTER TABLE [dbo].[CustomerClassNonSports] ADD  CONSTRAINT [DF_CustomerClassNonSports_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE NONCLUSTERED INDEX [IX_CustomerClassNonSports_RepUpdateTime] ON [dbo].[CustomerClassNonSports] ( [RepUpdateTime] ASC )
GO

CREATE NONCLUSTERED INDEX [IX_CustomerClassNonSports_Products] ON [dbo].[CustomerClassNonSports] 
(
	[Products] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

CREATE TABLE [dbo].[CustomerClassNonSportsDetail](
	[PolicyID] [int] NOT NULL,
	[SiteID] [int] NOT NULL,
	[CustomerClass] [smallint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_CustomerClassNonSportsDetail] PRIMARY KEY CLUSTERED 
(
	[SiteID] ASC,
	[CustomerClass] ASC,
	[PolicyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[CustomerClassNonSportsDetail] ADD  CONSTRAINT [DF_CustomerClassNonSportsDetail_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

ALTER TABLE [dbo].[CustomerClassNonSportsDetail] ADD  CONSTRAINT [DF_CustomerClassNonSportsDetail_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE NONCLUSTERED INDEX [IX_CustomerClassNonSportsDetail_RepUpdateTime] ON [dbo].[CustomerClassNonSportsDetail] ( [RepUpdateTime] ASC )
GO

CREATE NONCLUSTERED INDEX [IX_CustomerClassNonSportsDetail_PolicyID] ON [dbo].[CustomerClassNonSportsDetail] ( [PolicyID] ASC, [isDeleted] ASC )
GO

--================================= UAT

CREATE TABLE [dbo].[CustomerClassNonSports_UAT](
	[PolicyID] [int] IDENTITY(1,1) NOT NULL,
	[PolicyTitle] [varchar](500)  NOT NULL,
	[MaxBet] [int] NULL,
	[Products] [binary](32) NULL,
	[Enable] [bit]  NOT NULL,
	[IsTest] [TINYINT]  NOT NULL,
	[LastModifiedUser] [int] NULL,
	[LastModifiedTime] [datetime] NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_CustomerClassNonSports_UAT] PRIMARY KEY CLUSTERED
(
	[PolicyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[CustomerClassNonSports_UAT] ADD  CONSTRAINT [DF_CustomerClassNonSports_UAT_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

ALTER TABLE [dbo].[CustomerClassNonSports_UAT] ADD  CONSTRAINT [DF_CustomerClassNonSports_UAT_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE NONCLUSTERED INDEX [IX_CustomerClassNonSports_UAT_RepUpdateTime] ON [dbo].[CustomerClassNonSports_UAT] ( [RepUpdateTime] ASC )
GO

CREATE NONCLUSTERED INDEX [IX_CustomerClassNonSports_UAT_Products] ON [dbo].[CustomerClassNonSports_UAT] 
(
	[Products] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

CREATE TABLE [dbo].[CustomerClassNonSportsDetail_UAT](
	[PolicyID] [int] NOT NULL,
	[SiteID] [int] NOT NULL,
	[CustomerClass] [smallint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_CustomerClassNonSportsDetail_UAT] PRIMARY KEY CLUSTERED 
(
	[SiteID] ASC,
	[CustomerClass] ASC,
	[PolicyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[CustomerClassNonSportsDetail_UAT] ADD  CONSTRAINT [DF_CustomerClassNonSportsDetail_UAT_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

ALTER TABLE [dbo].[CustomerClassNonSportsDetail_UAT] ADD  CONSTRAINT [DF_CustomerClassNonSportsDetail_UAT_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE NONCLUSTERED INDEX [IX_CustomerClassNonSportsDetail_UAT_RepUpdateTime] ON [dbo].[CustomerClassNonSportsDetail_UAT] ( [RepUpdateTime] ASC )
GO

CREATE NONCLUSTERED INDEX [IX_CustomerClassNonSportsDetail_UAT_PolicyID] ON [dbo].[CustomerClassNonSportsDetail_UAT] ( [PolicyID] ASC, [isDeleted] ASC )
GO