/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211214@Winfred
	Task : Create table Products In DBCust [Redmine:#165393]
	DB:  DBCUST/CustDB 
	Replication : 
*/
USE CustDB
GO

CREATE TABLE [dbo].[Products](
	[ProductID] [tinyint] NOT NULL,
	[ProductName] [varchar](50) NOT NULL,
	[Description] [varchar](100) NULL,
	[ProductPrefix] [varchar](10) NULL,
	[Enabled] [bit] NULL CONSTRAINT [DF_Products_Enabled]  DEFAULT ((0)),
	[ProductNameCh] [nvarchar](50) NULL,
	[ProductNameCs] [nvarchar](50) NULL,
	[ProductNameJp] [nvarchar](50) NULL,
	[ProductNameIt] [nvarchar](50) NULL,
	[ProductNameTh] [nvarchar](50) NULL,
	[ProductNameKo] [nvarchar](50) NULL,
	[ProductNameES] [nvarchar](50) NULL,
	[ProductNameVN] [nvarchar](50) NULL,
	[ProductNameEL] [nvarchar](50) NULL,
	[ProductNameRU] [nvarchar](50) NULL,
	[ProductNameID] [nvarchar](50) NULL,
	[BalanceType] [tinyint] NULL,
	[SubProductBalanceType] [varchar](512) NULL CONSTRAINT [DF_Products_IsOfferPlayForFun]  DEFAULT ((0)),
	[GroupType] [tinyint] NULL,
	[CasinoType] [tinyint] NULL,
	[IsOfferPlayForFun] [bit] NULL,
	[EndOfSupportDate] [date] NULL,
	[VendorID] [smallint] NULL,
	[OrderNo] [int] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]

GO