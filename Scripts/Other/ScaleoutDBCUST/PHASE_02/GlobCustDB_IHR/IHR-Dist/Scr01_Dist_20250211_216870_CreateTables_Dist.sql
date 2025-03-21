/*<info serverAlias="DBCustRepl-ReplCustDB"></info>*/
/*
	Created: 20250211@Tacy	
	Task: Scale Out DBCUST - Setup InHouse replication on Dist
	DB: DBCustRepl-ReplCustDB
	
	Revisions:
		- 20250211@Tacy: Created [RedmineID: #216870]

	Tables:
		Dep_ProductStakeLevelGroup
		ProductStakeLevelGroup
		DomainManagement
		SportBettypeSettingMatrix
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[ProductStakeLevelGroup] ADD  CONSTRAINT [DF_ProductStakeLevelGroup_isDeleted]  DEFAULT (0) FOR [isDeleted]
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[Dep_ProductStakeLevelGroup] ADD  CONSTRAINT [DF_Dep_ProductStakeLevelGroup_SiteID]  DEFAULT (0) FOR [SiteID]		-- 0 ~ All site
GO

ALTER TABLE [dbo].[Dep_ProductStakeLevelGroup] ADD  CONSTRAINT [DF_Dep_ProductStakeLevelGroup_isDeleted]  DEFAULT (0) FOR [isDeleted]
GO

ALTER TABLE [dbo].[Dep_ProductStakeLevelGroup] ADD  CONSTRAINT [DF_Dep_ProductStakeLevelGroup_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

--CREATE INDEX
CREATE NONCLUSTERED INDEX [IX_Dep_ProductStakeLevelGroup_RepUpdateTime] ON [dbo].[Dep_ProductStakeLevelGroup]
(
	[RepUpdateTime] ASC
)
GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--DomainManagement
CREATE TABLE [dbo].[DomainManagement](
	[DomainID] [smallint] IDENTITY(1,1) NOT NULL,
	[Domain] [varchar](50) NOT NULL,
	[System] [varchar](20) NOT NULL,
	[Site] [varchar](500) NOT NULL,
	[BrandName] [varchar](10) NULL,
	[Status] [tinyint] NOT NULL,
	[ExpiredDate] [datetime] NULL,
	[LastUpdateTime] [datetime] NOT NULL,
	[RestrictedCountries] [varchar](4000) NULL,
	[Remark] [nvarchar](2000) NULL,
	[isDeleted] [bit] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_DomainManagement] PRIMARY KEY CLUSTERED 
(
	[DomainID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[DomainManagement] ADD  CONSTRAINT [DF_DomainManagement_LastUpdateTime]  DEFAULT (getdate()) FOR [LastUpdateTime]
GO

ALTER TABLE [dbo].[DomainManagement] ADD  CONSTRAINT [DF_DomainManagement_isDeleted]  DEFAULT (0) FOR [isDeleted]
GO

ALTER TABLE [dbo].[DomainManagement] ADD  CONSTRAINT [DF_DomainManagement_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

--CREATE INDEX
CREATE NONCLUSTERED INDEX [IX_DomainManagement_RepUpdateTime] ON [dbo].[DomainManagement]
(
	[RepUpdateTime] ASC
)
GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--SportBettypeSettingMatrix
CREATE TABLE [dbo].[SportBettypeSettingMatrix]
(
	  [SportType] SMALLINT NOT NULL
	, [BetType] INT NOT NULL
	, [isLicensee] BIT NOT NULL
	, [isLive] BIT NOT NULL
	, [Site] VARCHAR(50) NOT NULL
	, [isActive] BIT NOT NULL
	, [SportTypeRefPT] SMALLINT NULL
	, [BetTypeRefPT] INT NULL
	, [isLivePT] BIT NOT NULL
	, [TablePT] VARCHAR(50) NULL
	, [SportTypeRefComm] SMALLINT NULL
	, [BetTypeRefComm] INT NULL
	, [TableComm] VARCHAR(50) NULL
	, [SportTypeRefBetSetting] SMALLINT NULL
	, [BetTypeRefBetSetting] INT NULL
	, [TableBetSetting] VARCHAR(50) NULL
	, [IsLiveComm] BIT NOT NULL
	, [IsLiveBetSetting] BIT NOT NULL
	, [TableBettrans] VARCHAR(100) NULL
	, [SporttypeRefWinlossLimit] SMALLINT NULL
	, [BettypeRefWinlossLimit] SMALLINT NULL
	, [RealProductId] TINYINT NULL
	, [isDeleted] BIT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, [ProductID] TINYINT NULL
	, CONSTRAINT [PK_SportBettypeSettingMatrix] PRIMARY KEY CLUSTERED 
	(
		[BetType] ASC,
		[SportType] ASC,
		[isLicensee] ASC,
		[isLive] ASC,
		[Site] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[SportBettypeSettingMatrix] ADD CONSTRAINT [DF_SportBettypeSettingMatrix_isDeleted] DEFAULT (0) FOR [isDeleted]; 
GO
ALTER TABLE [dbo].[SportBettypeSettingMatrix] ADD CONSTRAINT [SportBettypeSettingMatrix_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO
ALTER TABLE [dbo].[SportBettypeSettingMatrix] ADD CONSTRAINT [DF_SportBettypeSettingMatrix_isActive] DEFAULT (0) FOR [isActive]; 
GO
ALTER TABLE [dbo].[SportBettypeSettingMatrix] ADD CONSTRAINT [DF_SportBettypeSettingMatrix_isLivePT] DEFAULT (0) FOR [isLivePT]; 
GO
ALTER TABLE [dbo].[SportBettypeSettingMatrix] ADD CONSTRAINT [SportBettypeSettingMatrix_IsLiveComm] DEFAULT (0) FOR [IsLiveComm]; 
GO
ALTER TABLE [dbo].[SportBettypeSettingMatrix] ADD CONSTRAINT [SportBettypeSettingMatrix_IsLiveBetSetting] DEFAULT (0) FOR [IsLiveBetSetting]; 
GO

--CREATE INDEX
CREATE NONCLUSTERED INDEX [IX_SportBettypeSettingMatrix_RepUpdateTime] ON [dbo].[SportBettypeSettingMatrix] ([RepUpdateTime] ASC);
GO
CREATE NONCLUSTERED INDEX [IX_SportBettypeSettingMatrix_SportType] ON [dbo].[SportBettypeSettingMatrix] ([SportType] ASC, [RealProductId] ASC, [ProductID] ASC);
GO
