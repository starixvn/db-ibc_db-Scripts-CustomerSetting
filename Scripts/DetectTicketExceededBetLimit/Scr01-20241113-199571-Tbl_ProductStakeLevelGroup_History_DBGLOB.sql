/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/

/*
	Created: 20241113@Tacy
	Task: Detect player exceeded the bet limit - Implement bet limit detection for RNG Casino [RedmineID: #199571]
	Database: DBGLOB-GlobCustDB
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- ProductStakeLevelGroup_History
CREATE TABLE [dbo].[ProductStakeLevelGroup_History](
	[Sporttype] [smallint] NOT NULL,
	[GameGroupID] [tinyint] NOT NULL,
	[CreditGroupID] [tinyint] NOT NULL,
	[MaxBet] [money] NOT NULL,
	[UpdateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_ProductStakeLevelGroup_History] PRIMARY KEY CLUSTERED 
(
	[Sporttype] ASC,
	[GameGroupID] ASC,
	[CreditGroupID] ASC,
	[UpdateTime] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

-- Dep_ProductStakeLevelGroup_History
CREATE TABLE [dbo].[Dep_ProductStakeLevelGroup_History](
	[Sporttype] [smallint] NOT NULL,
	[GameGroupID] [tinyint] NOT NULL,
	[LicenseeGroupID] [tinyint] NOT NULL,
	[SiteID] [int] NOT NULL,
	[MaxBet] [money] NOT NULL,
	[UpdateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Dep_ProductStakeLevelGroup_History] PRIMARY KEY CLUSTERED 
(
	[Sporttype] ASC,
	[GameGroupID] ASC,
	[LicenseeGroupID] ASC,
	[SiteID] ASC,
	[UpdateTime] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO