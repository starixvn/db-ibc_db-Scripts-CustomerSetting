/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20231002@Winfred
	DB: DBCUST/CustDB, DBTP-bodb02
	Task:  Allow to offer Parlay Boost on rule setting and add in house replication
	Revisions:
		- 20231002@Winfred: NAP CM Customer Class - Allow to offer Parlay Boost on rule setting [RedmineID: #190607]
*/

--DROP TABLE [dbo].[CustomerClassUtilityOffer]
--DROP TABLE [dbo].[CustomerClassUtilityOfferDetail]

--DROP TABLE [dbo].[CustomerClassUtilityOffer_UAT]
--DROP TABLE [dbo].[CustomerClassUtilityOfferDetail_UAT]

CREATE TABLE [dbo].[CustomerClassUtilityOffer](
	[PolicyID] [smallint] IDENTITY(1,1) NOT NULL,
	[PolicyTitle] [varchar](500)  NOT NULL,
	[UtilityOffering] [smallint] NULL,
	[IsTest] [TINYINT]  NOT NULL,
	[LastModifiedUser] [int] NULL,
	[LastModifiedTime] [datetime] NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_CustomerClassUtilityOffer] PRIMARY KEY CLUSTERED
(
	[PolicyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]

GO

ALTER TABLE [dbo].[CustomerClassUtilityOffer] ADD  CONSTRAINT [DF_CustomerClassUtilityOffer_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

ALTER TABLE [dbo].[CustomerClassUtilityOffer] ADD  CONSTRAINT [DF_CustomerClassUtilityOffer_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
 
CREATE NONCLUSTERED INDEX [IX_CustomerClassUtilityOffer_RepUpdateTime] ON [dbo].[CustomerClassUtilityOffer] ( [RepUpdateTime] ASC )
GO


CREATE TABLE [dbo].[CustomerClassUtilityOfferDetail](
	[PolicyID] [smallint] NOT NULL,
	[SiteID] [int] NOT NULL,
	[Currency] [int] NOT NULL,
	[CustomerClass] [smallint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_CustomerClassUtilityOfferDetail] PRIMARY KEY CLUSTERED 
(
	[Currency] ASC,
	[CustomerClass] ASC,
	[SiteID] ASC, 
	[PolicyID] ASC
	
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[CustomerClassUtilityOfferDetail] ADD  CONSTRAINT [DF_CustomerClassUtilityOfferDetail_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

ALTER TABLE [dbo].[CustomerClassUtilityOfferDetail] ADD  CONSTRAINT [DF_CustomerClassUtilityOfferDetail_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE NONCLUSTERED INDEX [IX_CustomerClassUtilityOfferDetail_RepUpdateTime] ON [dbo].[CustomerClassUtilityOfferDetail] ( [RepUpdateTime] ASC )
GO

CREATE NONCLUSTERED INDEX [IX_CustomerClassUtilityOfferDetail_PolicyID] ON [dbo].[CustomerClassUtilityOfferDetail] ( [PolicyID] ASC, [isDeleted] ASC )
GO
--================================= UAT
CREATE TABLE [dbo].[CustomerClassUtilityOffer_UAT](
	[PolicyID] [smallint] IDENTITY(1,1) NOT NULL,
	[PolicyTitle] [varchar](500)  NOT NULL,
	[UtilityOffering] [smallint] NULL,
	[IsTest] [TINYINT]  NOT NULL,
	[LastModifiedUser] [int] NULL,
	[LastModifiedTime] [datetime] NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_CustomerClassUtilityOffer_UAT] PRIMARY KEY CLUSTERED
(
	[PolicyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]

GO

ALTER TABLE [dbo].[CustomerClassUtilityOffer_UAT] ADD  CONSTRAINT [DF_CustomerClassUtilityOffer_UAT_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

ALTER TABLE [dbo].[CustomerClassUtilityOffer_UAT] ADD  CONSTRAINT [DF_CustomerClassUtilityOffer_UAT_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

--CREATE INDEX
CREATE NONCLUSTERED INDEX [IX_CustomerClassUtilityOffer_UAT_RepUpdateTime] ON [dbo].[CustomerClassUtilityOffer_UAT] ( [RepUpdateTime] ASC )

CREATE TABLE [dbo].[CustomerClassUtilityOfferDetail_UAT](
	[PolicyID] [smallint] NOT NULL,
	[SiteID] [int] NOT NULL,
	[Currency] [int] NOT NULL,
	[CustomerClass] [smallint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_CustomerClassUtilityOfferDetail_UAT] PRIMARY KEY CLUSTERED 
(
	[Currency] ASC,
	[CustomerClass] ASC,
	[SiteID] ASC, 
	[PolicyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[CustomerClassUtilityOfferDetail_UAT] ADD  CONSTRAINT [DF_CustomerClassUtilityOfferDetail_UAT_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

ALTER TABLE [dbo].[CustomerClassUtilityOfferDetail_UAT] ADD  CONSTRAINT [DF_CustomerClassUtilityOfferDetail_UAT_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE NONCLUSTERED INDEX [IX_CustomerClassUtilityOfferDetail_UAT_RepUpdateTime] ON [dbo].[CustomerClassUtilityOfferDetail_UAT] ( [RepUpdateTime] ASC )
GO

CREATE NONCLUSTERED INDEX [IX_CustomerClassUtilityOfferDetail_UAT_PolicyID] ON [dbo].[CustomerClassUtilityOfferDetail_UAT] ( [PolicyID] ASC, [isDeleted] ASC )
GO