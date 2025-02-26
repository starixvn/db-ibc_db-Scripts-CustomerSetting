/*<info serverAlias="DBCUST-CustDB,IRS_DBACC-bodb02,IRS_DBTP-bodb02"></info>*/
/*
	Created: 20240919@Johnson
	Task: Database structure change on DBCUST for Bet Limit Control [redmine: #209892]
	DB: DBCUST/CUSTDB	
*/ 

--run this script on DBCUST-CustDB,IRS_DBACC-bodb02:

CREATE TABLE [dbo].[BetLimitControlTypeDetails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BetLimitTypeID] [int] NOT NULL,
	[ProductID] [tinyint] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[LeagueGroupID] [int] NOT NULL,
	[LeagueID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
CONSTRAINT PK_BetLimitControlTypeDetails PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [BetRestriction]
) ON [BetRestriction]

GO

CREATE NONCLUSTERED INDEX [IX_BetLimitControlTypeDetails_BetLimitTypeID] ON [dbo].[BetLimitControlTypeDetails]
(
	[BetLimitTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO

----------------------------------------------
--run this script on DBCUST only
CREATE NONCLUSTERED INDEX [IX_BetLimitControlTypeDetails_RepUpdateTime] ON [dbo].[BetLimitControlTypeDetails]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO

------------------------------------------------------------------
--run this script on IRS_DBTP-bodb02
CREATE TABLE [dbo].[BetLimitControlTypeDetails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BetLimitTypeID] [int] NOT NULL,
	[ProductID] [tinyint] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[LeagueGroupID] [int] NOT NULL,
	[LeagueID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NULL,
CONSTRAINT PK_BetLimitControlTypeDetails PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [BetRestriction]
) ON [BetRestriction]

GO

CREATE NONCLUSTERED INDEX [IX_BetLimitControlTypeDetails_RepUpdateTime] ON [dbo].[BetLimitControlTypeDetails]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO

CREATE NONCLUSTERED INDEX [IX_BetLimitControlTypeDetails_BetLimitTypeID] ON [dbo].[BetLimitControlTypeDetails]
(
	[BetLimitTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO
