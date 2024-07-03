/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20240626@Johnson
	Task: Scale out dbcust [redmine: #206738]
	DB: DBCUST-CUSTDB
*/ 

--tables need UM
-----------------------------------------------------------------
--Dep_CustBAActive
ALTER TABLE	Dep_CustBAActive	ADD RepUpdateTime DATETIME2
GO

CREATE TABLE [dbo].[Dep_CustBAActive_Del_InHouse](
	[CustId] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_CustBAActive_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[CustId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO
-----------------------------------------------------------------
--Dep_CustBetLimit_Special
ALTER TABLE	Dep_CustBetLimit_Special	ADD RepUpdateTime DATETIME2
GO

CREATE TABLE [dbo].[Dep_CustBetLimit_Special_Del_InHouse](	
	[Keyid] [int] ,	
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_CustBetLimit_Special_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[Keyid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO
-----------------------------------------------------------------
--Dep_CustBetSetting_Agent
ALTER TABLE	Dep_CustBetSetting_Agent	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_CustBetSetting_Agent_Del_InHouse](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,	
 CONSTRAINT [PK_Dep_CustBetSetting_Agent_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustBetSetting_Agent_table]
) ON [Dep_CustBetSetting_Agent_table]

GO
-----------------------------------------------------------------
--Dep_CustBetSetting_Member
ALTER TABLE	Dep_CustBetSetting_Member	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_CustBetSetting_Member_Del_InHouse](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,	
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_CustBetSetting_Member_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustBetSetting_Member_table]
) ON [Dep_CustBetSetting_Member_table]
GO

-----------------------------------------------------------------
--Dep_CustBetSettingGame_Agent
ALTER TABLE	Dep_CustBetSettingGame_Agent	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_CustBetSettingGame_Agent_Del_InHouse](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,	
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_CustBetSettingGame_Agent_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustBetSetting_Agent_table]
) ON [Dep_CustBetSetting_Agent_table]

GO

-----------------------------------------------------------------
--Dep_CustBetSettingGame_Member
ALTER TABLE	Dep_CustBetSettingGame_Member	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_CustBetSettingGame_Member_Del_InHouse](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_CustBetSettingGame_Member_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustBetSetting_Member_table]
) ON [Dep_CustBetSetting_Member_table]

GO
-----------------------------------------------------------------
--Dep_CustBetSettingGameGroup_Member
ALTER TABLE	Dep_CustBetSettingGameGroup_Member	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_CustBetSettingGameGroup_Member_Del_InHouse](
	[AgentID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_CustBetSettingGameGroup_Member_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[AgentID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustBetSetting_Agent_table]
) ON [Dep_CustBetSetting_Agent_table]

GO
-----------------------------------------------------------------
--Dep_CustCategoryHistory
ALTER TABLE	Dep_CustCategoryHistory	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_CustCategoryHistory_Del_InHouse](
	[LogID] [bigint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_CustCategoryHistory_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [table_customer]
) ON [table_customer]
GO

-----------------------------------------------------------------
--Dep_CustDiscountGroupSetting_Member
ALTER TABLE	Dep_CustDiscountGroupSetting_Member	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_CustDiscountGroupSetting_Member_Del_InHouse](
	[AgentID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_CustDiscountGroupSetting_Member_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[AgentID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustDiscount_Member_Table]
) ON [Dep_CustDiscount_Member_Table]
GO

-----------------------------------------------------------------
--Dep_CustDiscountSetting_Agent
ALTER TABLE	Dep_CustDiscountSetting_Agent	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_CustDiscountSetting_Agent_Del_InHouse](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_CustDiscountSetting_Agent_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustDiscountSetting_Agent_table]
) ON [Dep_CustDiscountSetting_Agent_table]

GO
-----------------------------------------------------------------
--Dep_CustDiscountSetting_Member
ALTER TABLE	Dep_CustDiscountSetting_Member	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_CustDiscountSetting_Member_Del_InHouse](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_CustDiscountSetting_Member_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustDiscount_Member_Table]
) ON [Dep_CustDiscount_Member_Table]

GO
-----------------------------------------------------------------
--Dep_Customer_Archived
ALTER TABLE	Dep_Customer_Archived	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_Customer_Archived_Del_InHouse](
	[CustID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_Customer_Archived_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [table_customer]
) ON [table_customer]
GO

-----------------------------------------------------------------
--Dep_CustomerClass
ALTER TABLE	Dep_CustomerClass	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_CustomerClass_Del_InHouse](
	[CustID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_CustomerClass_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

-----------------------------------------------------------------
--Dep_CustProductSetting
ALTER TABLE	Dep_CustProductSetting	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_CustProductSetting_Del_InHouse](
	[CustID] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_CustProductSetting_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

-----------------------------------------------------------------
--Dep_CustProductStatus
ALTER TABLE	Dep_CustProductStatus	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_CustProductStatus_Del_InHouse](
	[CustID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [CIX_Dep_CustProductStatus_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [table_customer]
) ON [table_customer]
GO

-----------------------------------------------------------------
--Dep_CustPTGroupSetting_Member
ALTER TABLE	Dep_CustPTGroupSetting_Member	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_CustPTGroupSetting_Member_Del_InHouse](
	[AgentID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_CustPTGroupSetting_Member_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[AgentID] ASC,
	[SportType] ASC,
	[BetType] ASC,
	[IsLive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustPTSetting_table]
) ON [Dep_CustPTSetting_table]

GO

-----------------------------------------------------------------
--Dep_CustPTSetting_Agent
ALTER TABLE	Dep_CustPTSetting_Agent	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_CustPTSetting_Agent_Del_InHouse](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_CustPTSetting_Agent_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC,
	[IsLive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustPTSetting_table]
) ON [Dep_CustPTSetting_table]

GO
-----------------------------------------------------------------
--Dep_CustPTSetting_Member
ALTER TABLE	Dep_CustPTSetting_Member	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_CustPTSetting_Member_Del_InHouse](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_CustPTSetting_Member_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC,
	[IsLive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustPTSetting_table]
) ON [Dep_CustPTSetting_table]
GO

-----------------------------------------------------------------
--Dep_CustSetting_AGCasino
ALTER TABLE	Dep_CustSetting_AGCasino	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_CustSetting_AGCasino_Del_InHouse](
	[CustID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_CustSetting_AGCasino_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

-----------------------------------------------------------------
--Dep_CustSettingGame
ALTER TABLE	Dep_CustSettingGame	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_CustSettingGame_Del_InHouse](
	[CustID] [int] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_CustSettingGame_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[Bettype] ASC,
	[Sporttype] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustSettingGame_Table]
) ON [Dep_CustSettingGame_Table]
GO

-----------------------------------------------------------------
--Dep_CustSettingMode
ALTER TABLE	Dep_CustSettingMode	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_CustSettingMode_Del_InHouse](
	[CustID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_CustSettingMode_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustPTSetting_table]
) ON [Dep_CustPTSetting_table]

GO
-----------------------------------------------------------------
--Dep_CustSpecialLevel
ALTER TABLE	Dep_CustSpecialLevel	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_CustSpecialLevel_Del_InHouse](
	[custid] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_CustSpecialLevel_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[custid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

-----------------------------------------------------------------
--Dep_CustStakeLevel_Agent
ALTER TABLE	Dep_CustStakeLevel_Agent	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_CustStakeLevel_Agent_Del_InHouse](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_CustStakeLevel_Agent_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustStakeLevel_table]
) ON [Dep_CustStakeLevel_table]

GO
-----------------------------------------------------------------
--Dep_CustStakeLevel_Member
ALTER TABLE	Dep_CustStakeLevel_Member	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_CustStakeLevel_Member_Del_InHouse](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_CustStakeLevel_Member_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustStakeLevel_table]
) ON [Dep_CustStakeLevel_table]

GO
-----------------------------------------------------------------
--Dep_CustSuper
ALTER TABLE	Dep_CustSuper	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_CustSuper_Del_InHouse](
	[custid] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_CustSuper_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[custid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

-----------------------------------------------------------------
--Dep_CustVIP
ALTER TABLE	Dep_CustVIP	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_CustVIP_Del_InHouse](
	[CustID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_CustVIP_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [table_customer]
) ON [table_customer]
GO

-----------------------------------------------------------------
--Dep_DefaultOddGroup
ALTER TABLE	Dep_DefaultOddGroup	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_DefaultOddGroup_Del_InHouse](
	[AgentID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_DefaultOddGroup_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[AgentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [DATA]
) ON [DATA]
GO

-----------------------------------------------------------------
--Dep_LicenseeProductSetting
ALTER TABLE	Dep_LicenseeProductSetting	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_LicenseeProductSetting_Del_InHouse](
	[CustID] [int] NOT NULL,
	[ProductSettingID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_LicenseeProductSetting_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[ProductSettingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

-----------------------------------------------------------------
--Dep_ProductBetSetting
ALTER TABLE	Dep_ProductBetSetting	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_ProductBetSetting_Del_InHouse](
	[Sporttype] [int] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[Currency] [tinyint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_ProductBetSetting_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[Sporttype] ASC,
	[Bettype] ASC,
	[Currency] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

-----------------------------------------------------------------
--Dep_ProductSetting
ALTER TABLE	Dep_ProductSetting	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_ProductSetting_Del_InHouse](
	[ProductSettingID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_ProductSetting_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[ProductSettingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

-----------------------------------------------------------------
--Dep_ProductSettingDetail
ALTER TABLE	Dep_ProductSettingDetail	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_ProductSettingDetail_Del_InHouse](
	[ProductSettingID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_ProductSettingDetail_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[ProductSettingID] ASC,
	[SportType] ASC,
	[BetType] ASC,
	[IsLive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

-----------------------------------------------------------------
--Dep_ProductStatusProfile
ALTER TABLE	Dep_ProductStatusProfile	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_ProductStatusProfile_Del_InHouse](
	[Sporttype] [smallint] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_ProductStatusProfile_Del_InHouse] PRIMARY KEY NONCLUSTERED 
(
	[Sporttype] ASC,
	[Bettype] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

-----------------------------------------------------------------
--Dep_StakeLevel
ALTER TABLE	Dep_StakeLevel	ADD RepUpdateTime DATETIME2
GO

CREATE TABLE [dbo].[Dep_StakeLevel_Del_InHouse](
	[StakeLevelID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_StakeLevel_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[StakeLevelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

-----------------------------------------------------------------
--Dep_StakeLevelGroupDetail
ALTER TABLE	Dep_StakeLevelGroupDetail	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_StakeLevelGroupDetail_Del_InHouse](
	[StakeLevelID] [int] NOT NULL,
	[GameTypeID] [smallint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_StakeLevelGroupDetail_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[StakeLevelID] ASC,
	[GameTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

-----------------------------------------------------------------
--Dep_SuperSetting_AGCasino
ALTER TABLE	Dep_SuperSetting_AGCasino	ADD RepUpdateTime DATETIME2
GO

CREATE TABLE [dbo].[Dep_SuperSetting_AGCasino_Del_InHouse](
	[CustID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_SuperSetting_AGCasino_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO
-----------------------------------------------------------------
--Dep_SupperProductSetting
ALTER TABLE	Dep_SupperProductSetting	ADD RepUpdateTime DATETIME2
GO
CREATE TABLE [dbo].[Dep_SupperProductSetting_Del_InHouse](
	[CustID] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Dep_SupperProductSetting_Del_InHouse] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO
--tables dont need UM