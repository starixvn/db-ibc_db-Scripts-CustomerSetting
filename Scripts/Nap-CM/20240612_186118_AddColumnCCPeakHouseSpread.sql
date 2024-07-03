/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20240612@Winfred
	DB: DBCUST/CustDB
	Task:  [NAP CM] Customer Class - Add Peak Hour Spread on rule setting [186118]
*/
-- Peak Hour Spread
--===================================================================================
ALTER TABLE dbo.CustomerClassSpread ADD IsLive TINYINT NULL
GO

ALTER TABLE dbo.CustomerClassSpread ADD Type TINYINT NOT NULL CONSTRAINT [DF_CustomerClassSpread_Type] DEFAULT ((1))
GO

CREATE TABLE [dbo].[CustomerClassSpreadLeagueGroup](
	[PolicyID] [int] NOT NULL,
	[LeagueGroupID] [smallint] NOT NULL,
 CONSTRAINT [PK_CustomerClassSpreadLeagueGroup] PRIMARY KEY CLUSTERED 
(
	[LeagueGroupID] ASC,
	[PolicyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO
--DROP TABLE CustomerClassPeakHourRanger
--Go
CREATE TABLE [dbo].[CustomerClassPeakHourRanger](
	[RangeID] [int] IDENTITY(1,1) NOT NULL,
	[WeekDay] [tinyint] NOT NULL,
	[StartRange] [Time](1) NOT NULL,
	[EndRange] [Time](1) NOT NULL,
	[IsTest] [TINYINT]  NOT NULL,
	[LastModifiedUser] [int] NULL,
	[LastModifiedTime] [datetime] NULL,
 CONSTRAINT [PK_CustomerClassPeakHourRanger] PRIMARY KEY CLUSTERED 
(
	[WeekDay] ASC,
	[StartRange] ASC,
	[EndRange] ASC,
	[RangeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO
--================================UAT===================================================
ALTER TABLE dbo.CustomerClassSpread_UAT ADD IsLive TINYINT NULL
GO

ALTER TABLE dbo.CustomerClassSpread_UAT ADD Type TINYINT NOT NULL CONSTRAINT [DF_CustomerClassSpread_UAT_Type] DEFAULT ((1))
GO
--DROP TABLE CustomerClassSpreadLeagueGroup_UAT
--Go
CREATE TABLE [dbo].[CustomerClassSpreadLeagueGroup_UAT](
	[PolicyID] [int] NOT NULL,
	[LeagueGroupID] [smallint] NOT NULL,
 CONSTRAINT [PK_CustomerClassSpreadLeagueGroup_UAT] PRIMARY KEY CLUSTERED 
(
	[LeagueGroupID] ASC,
	[PolicyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO
