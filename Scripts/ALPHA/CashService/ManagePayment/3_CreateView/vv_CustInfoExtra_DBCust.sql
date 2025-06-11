/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service -  Create new View  [CustInfoExtra] [223896]  
	DB: DBCUST/CustDB
*/

/****** Object:  Table [dbo].[CustProductStatus_UAT]    Script Date: 5/7/2025 5:22:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CustProductStatus_UAT](
	[CustID] [int] NOT NULL,
	[bitmapHasSynced] [binary](32) NOT NULL,
	[bitmapIsHidden] [binary](32) NOT NULL,
	[bitmapIsDisabled] [binary](32) NOT NULL,
	[SuspendInfo] [tinyint] NULL,
	[Locked] [tinyint] NULL,
	[CloseInfo] [tinyint] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[ServiceType] [tinyint] NULL,
 CONSTRAINT [CIX_CustProductStatus_UAT_custid] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CustProductStatus_Table]
) ON [CustProductStatus_Table]
GO

ALTER TABLE [dbo].[CustProductStatus_UAT] ADD  CONSTRAINT [DF_CustProductStatus_UAT_bitmapHasSynced]  DEFAULT (0x00) FOR [bitmapHasSynced]
GO

ALTER TABLE [dbo].[CustProductStatus_UAT] ADD  CONSTRAINT [DF_CustProductStatus_UAT_bitmapIsHidden]  DEFAULT (0x00) FOR [bitmapIsHidden]
GO

ALTER TABLE [dbo].[CustProductStatus_UAT] ADD  CONSTRAINT [DF_CustProductStatus_UAT_bitmapIsDisabled]  DEFAULT (0x00) FOR [bitmapIsDisabled]
GO

ALTER TABLE [dbo].[CustProductStatus_UAT] ADD  CONSTRAINT [DF_CustProductStatus_UAT_SuspendInfo]  DEFAULT ((0)) FOR [SuspendInfo]
GO

ALTER TABLE [dbo].[CustProductStatus_UAT] ADD  CONSTRAINT [DF_CustProductStatus_UAT_Locked]  DEFAULT ((0)) FOR [Locked]
GO

ALTER TABLE [dbo].[CustProductStatus_UAT] ADD  CONSTRAINT [DF_CustProductStatus_UAT_CloseInfo]  DEFAULT ((0)) FOR [CloseInfo]
GO

ALTER TABLE [dbo].[CustProductStatus_UAT] ADD  CONSTRAINT [DF_CustProductStatus_UAT_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

ALTER TABLE [dbo].[CustProductStatus_UAT] ADD  CONSTRAINT [DF_CustProductStatus_UAT_ServiceType]  DEFAULT ((0)) FOR [ServiceType]
GO

--DROP VIEW IF EXISTS [vw_CustInfoExtra];

USE CustDB
GO

CREATE VIEW [dbo].[vw_CustInfoExtra]
AS

SELECT 
    cpp.[CustID], 
    cpp.[bitmapHasSynced], 
    cpp.[bitmapIsHidden], 
    cpp.[bitmapIsDisabled], 
    cpp.[SuspendInfo], 
    cpp.[Locked], 
    cpp.[CloseInfo], 
    cpp.[RepUpdateTime],
    CASE 
	WHEN tb_uat.CustID IS NOT NULL THEN tb_uat.ServiceType 
	WHEN tb_uat.CustID IS NULL THEN 0
   END AS ServiceType
FROM dbo.CustProductStatus cpp
LEFT JOIN dbo.CustProductStatus_UAT tb_uat ON cpp.CustID = tb_uat.CustID
GO

GRANT SELECT ON [dbo].[CustProductStatus_UAT] TO asv_CashService;
GRANT SELECT ON [dbo].[CustProductStatus_UAT] TO wsv_CashService;

GRANT SELECT ON [dbo].[vw_CustInfoExtra] TO asv_CashService;
GRANT SELECT ON [dbo].[vw_CustInfoExtra] TO wsv_CashService;