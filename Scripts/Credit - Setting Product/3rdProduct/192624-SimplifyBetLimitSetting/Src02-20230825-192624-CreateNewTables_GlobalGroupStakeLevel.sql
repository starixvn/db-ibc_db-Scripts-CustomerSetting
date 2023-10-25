/*<info serverAlias="DBCUST-CustDB,DBACC-bodb02,DBTP-bodb02,DBSPARE-CustDB"></info>*/
/*
	Created by: Tacy@20230825
	Task: Create new tables and add in house replication [Redmine:#186192] 
	DB:	DBCUST-CustDB,DBACC-bodb02,DBSPARE-CustDB
		,DBTP-bodb02	-- for DR site
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--ProductStakeLevelGroup
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ProductStakeLevelGroup](
	[Sporttype] [smallint] NOT NULL,
	[GameGroupID] [tinyint] NOT NULL,
	[MinBet] [money] NOT NULL,
	[MaxBet] [money] NOT NULL,
	[CreditGroupID] [tinyint] NOT NULL,
	[Remark] [varchar](1000) NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_ProductStakeLevelGroup] PRIMARY KEY CLUSTERED 
(
	[Sporttype] ASC,
	[GameGroupID] ASC,
	[CreditGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [BetRestriction]
) ON [BetRestriction]
GO

ALTER TABLE [dbo].[ProductStakeLevelGroup] ADD  CONSTRAINT [DF_ProductStakeLevelGroup_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

ALTER TABLE [dbo].[ProductStakeLevelGroup] ADD  CONSTRAINT [DF_ProductStakeLevelGroup_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

--CREATE INDEX
CREATE NONCLUSTERED INDEX [IX_ProductStakeLevelGroup_RepUpdateTime] ON [dbo].[ProductStakeLevelGroup]
(
	[RepUpdateTime] ASC
)
GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
CREATE TABLE [dbo].[Dep_ProductStakeLevelGroup](
	[Sporttype] [smallint] NOT NULL,
	[GameGroupID] [tinyint] NOT NULL,
	[MinBet] [money] NOT NULL,
	[MaxBet] [money] NOT NULL,
	[LicenseeGroupID] [tinyint] NOT NULL,
	[SiteID] [int] NOT NULL,
	[Remark] [varchar](1000) NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_ProductStakeLevelGroup] PRIMARY KEY CLUSTERED 
(
	[Sporttype] ASC,
	[GameGroupID] ASC,
	[LicenseeGroupID] ASC,
	[SiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [BetRestriction]
) ON [BetRestriction]
GO

ALTER TABLE [dbo].[Dep_ProductStakeLevelGroup] ADD  CONSTRAINT [DF_Dep_ProductStakeLevelGroup_SiteID]  DEFAULT ((0)) FOR [SiteID]		-- 0 ~ All site
GO

ALTER TABLE [dbo].[Dep_ProductStakeLevelGroup] ADD  CONSTRAINT [DF_Dep_ProductStakeLevelGroup_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

ALTER TABLE [dbo].[Dep_ProductStakeLevelGroup] ADD  CONSTRAINT [DF_Dep_ProductStakeLevelGroup_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

--CREATE INDEX
CREATE NONCLUSTERED INDEX [IX_Dep_ProductStakeLevelGroup_RepUpdateTime] ON [dbo].[Dep_ProductStakeLevelGroup]
(
	[RepUpdateTime] ASC
)
GO