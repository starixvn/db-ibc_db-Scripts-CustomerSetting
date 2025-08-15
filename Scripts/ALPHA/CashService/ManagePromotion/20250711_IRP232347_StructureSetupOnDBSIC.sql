/*<info serverAlias="DBSIC-AgencyCashService,DBAGE-AgencyCashService"></info>*/
/*
	Created: 20250711@Johnson
	Task: Alpha - Agency Cash Service - Manage Promotion  [#232347]  
	DB: DBSIC/AgencyCashService
*/
use master
GO
--local path
CREATE DATABASE [AgencyCashService]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AgencyCashService', 
FILENAME = N'G:\SQLSERVER2019_DEVDBCUST\IBC_DB\AgencyCashService\AgencyCashService.mdf' , SIZE = 508928KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB 
), 
 FILEGROUP [CashService] 
( NAME = N'CashService', 
FILENAME = N'G:\SQLSERVER2019_DEVDBCUST\IBC_DB\AgencyCashService\CashService.ndf' , SIZE = 24576KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB 
)
 LOG ON 
( NAME = N'AgencyCashService_log', 
FILENAME = N'G:\SQLSERVER2019_DEVDBCUST\IBC_DB\AgencyCashService\AgencyCashService.ldf' , SIZE = 54976KB , MAXSIZE = 2048GB , FILEGROWTH = 10%
)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO

--CashPromotion
CREATE TABLE [dbo].[CashPromotion](
	[PromotionID] [int] IDENTITY(1,1) NOT NULL,
	[SiteDBGroupID] [smallint] NOT NULL,
	[AgentID] [int] NOT NULL,
	[Type] [tinyint] NOT NULL,
	[FromDate] [date] NOT NULL,
	[ToDate] [date] NOT NULL,
	[Enabled] [bit] NOT NULL,
	[IsSoftDeleted] [bit] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_CashPromotion] PRIMARY KEY CLUSTERED 
(
	[PromotionID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CashService]
) ON [CashService]
GO

ALTER TABLE CashPromotion ADD CONSTRAINT [DF_CashPromotion_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
GO
ALTER TABLE CashPromotion ADD CONSTRAINT [DF_CashPromotion_IsSoftDeleted] DEFAULT ((0)) FOR [IsSoftDeleted];
GO

--CashPromotionDetail
CREATE TABLE [dbo].[CashPromotionDetail](
	[PromotionID] [int] NOT NULL,
	[SiteDBGroupID] [smallint] NOT NULL,
	[ProductCategoryID] [tinyint] NOT NULL,
	[ProductList] [varchar](max) NOT NULL,
	[Percentage] [smallmoney] NULL,
	[MaxPayout] [money] NULL,
	[MinValue] [money] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_CashPromotionDetail] PRIMARY KEY CLUSTERED 
(
	[PromotionID] ASC,
	[SiteDBGroupID] ASC,
	[ProductCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CashService]
) ON [CashService] 
GO

ALTER TABLE CashPromotionDetail ADD CONSTRAINT [DF_CashPromotionDetail_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
GO

--CashPromotionLanguage
CREATE TABLE [dbo].[CashPromotionLanguage](
	[PromotionID] [int] NOT NULL,
	[SiteDBGroupID] [smallint] NOT NULL,
	[LanguageCode] [varchar](10) NOT NULL,
	[Title] [nvarchar](200) NULL,
	[Content] [nvarchar](max) NULL,
	[Banner] [varchar](1000) NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_CashPromotionLanguage] PRIMARY KEY CLUSTERED 
(
	[PromotionID] ASC,
	[SiteDBGroupID] ASC,
	[LanguageCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CashService]
) ON [CashService] 
GO

ALTER TABLE CashPromotionLanguage ADD CONSTRAINT [DF_CashPromotionLanguage_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime];
GO