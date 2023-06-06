/*<info serverAlias="DBARCCUST-bodb_Customer"></info>*/
/*
	Created: Eden@20230529
	Task: Include newly created tables into Archive Credit Dormant Account process [Redmine: #162050]   
		CustMaxPayoutSetting_Member_old
		CustMaxPayoutSetting_Agent_old
		CustProfilePicture_old
	DB: DBARCCUST/bodb_Customer
*/
USE bodb_Customer
GO
--DROP TABLE [CustMaxPayoutSetting_Member_old]
--DROP TABLE [CustMaxPayoutSetting_Agent_old]
--DROP TABLE [CustProfilePicture_old]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CustMaxPayoutSetting_Member_old](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[SingleMatchParlay] [money] NULL,
	[Combo2] [money] NULL,
	[Combo35] [money] NULL,
	[ComboOver6] [money] NULL,
 CONSTRAINT [PK_CustMaxPayoutSetting_Member_old] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CustSetting_table]
) ON [CustSetting_table]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CustMaxPayoutSetting_Agent_old](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[SingleMatchParlay] [money] NULL,
	[Combo2] [money] NULL,
	[Combo35] [money] NULL,
	[ComboOver6] [money] NULL,
 CONSTRAINT [PK_CustMaxPayoutSetting_Agent_old] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CustSetting_table]
) ON [CustSetting_table]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CustProfilePicture_old](
	[CustId] [int] NOT NULL,
	[ImageId] [int] NULL,
	[Modified] [datetime],
 CONSTRAINT [PK_CustProfilePicture_old] PRIMARY KEY CLUSTERED 
(
	[CustId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CustSetting_table]
) ON [CustSetting_table]
GO