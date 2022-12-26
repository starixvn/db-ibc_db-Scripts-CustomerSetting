/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221121@Eden
	Task: Add new table ProductSettingDetail_UAT [#180640]
	DB: DBCust/CustDB and all replicated server of pub: CustDB_Customer_Info, CustDB_DBTrans_CustInfo
*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductSettingDetail_UAT]') AND type in (N'U'))
DROP TABLE [dbo].[ProductSettingDetail_UAT]
GO

/****** Object:  Table [dbo].[ProductSettingDetail_UAT]    Script Date: 11/28/2022 1:25:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ProductSettingDetail_UAT](
	[SettingType] [smallint] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[ProductID] [tinyint] NOT NULL,
	[MaxPT] [smallmoney] NULL,
	[MaxDiscount] [decimal](9, 8) NULL,
	[IsSync] [bit] NULL,
	[IsHidden] [bit] NULL,
	[IsDisabled] [bit] NULL,
	[SettingLevel] [tinyint] NULL,
	[DisplayOrder] [tinyint] NOT NULL,
	[SettingStatus] [tinyint] NULL,
	[IntervalValue] [decimal](19, 8) NULL,
	[RealProductId] [tinyint] NOT NULL,
	[MaxChoice] [tinyint] NULL,
	[ProductSettingID] [int] NOT NULL,
	[Parent_ProductSettingID] [int] NULL,
	[Child_DisplayOrder] [int] NULL,
	[SubType] [tinyint] NULL,
 CONSTRAINT [PK_ProductSettingDetail_UAT] PRIMARY KEY CLUSTERED 
(
	[SettingType] ASC,
	[SportType] ASC,
	[BetType] ASC,
	[IsLive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA],
 CONSTRAINT [UQ_ProductSettingID_UAT] UNIQUE NONCLUSTERED 
(
	[ProductSettingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[ProductSettingDetail_UAT] ADD  CONSTRAINT [DF_ProductSettingDetail_UAT_MaxPT]  DEFAULT ((90)) FOR [MaxPT]
GO

ALTER TABLE [dbo].[ProductSettingDetail_UAT] ADD  CONSTRAINT [DF_ProductSettingDetail_UAT_MaxDiscount]  DEFAULT ((0.01)) FOR [MaxDiscount]
GO

ALTER TABLE [dbo].[ProductSettingDetail_UAT] ADD  CONSTRAINT [DF_ProductSettingDetail_UAT_IsSync]  DEFAULT ((0)) FOR [IsSync]
GO

ALTER TABLE [dbo].[ProductSettingDetail_UAT] ADD  CONSTRAINT [DF_ProductSettingDetail_UAT_IsHidden]  DEFAULT ((1)) FOR [IsHidden]
GO

ALTER TABLE [dbo].[ProductSettingDetail_UAT] ADD  CONSTRAINT [DF_ProductSettingDetail_UAT_IsDisabled]  DEFAULT ((0)) FOR [IsDisabled]
GO

ALTER TABLE [dbo].[ProductSettingDetail_UAT] ADD  CONSTRAINT [DF_ProductSettingDetail_UAT_DisplayOrder]  DEFAULT ((0)) FOR [DisplayOrder]
GO

ALTER TABLE [dbo].[ProductSettingDetail_UAT] ADD  CONSTRAINT [DF_ProductSettingDetail_UAT_SettingStatus]  DEFAULT ((0)) FOR [SettingStatus]
GO

--select * from vw_DBA_Replication_GetInfo where Article = 'ProductSettingDetail'
