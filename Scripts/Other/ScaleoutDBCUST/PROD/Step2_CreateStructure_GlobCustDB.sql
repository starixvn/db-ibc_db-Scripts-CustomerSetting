/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: @Helios
	Date: 2024-09-26
	Task: Create CustInfoMini | CustSubMini & CustSubMini_Del_Inhouse | CustInfoMini_Del_Inhouse tables [Redmine: #206823]  
	DB: DBGLOB-GlobCustDB
*/

USE GlobCustDB

/****** Object:  Table [dbo].[CustInfoMini_Del_Inhouse]    Script Date: 9/26/2024 9:39:48 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CustInfoMini_Del_Inhouse](
	[CustID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL
) ON [CustInfo_table]
GO

--CREATE INDEX
CREATE CLUSTERED INDEX [IX_CustInfoMini_Del_Inhouse_RepUpdateTime] ON [dbo].[CustInfoMini_Del_Inhouse]
(
	[RepUpdateTime] ASC
)
GO


/****** Object:  Table [dbo].[CustSubMini_Del_Inhouse]    Script Date: 9/26/2024 9:40:25 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CustSubMini_Del_Inhouse](
	[subaccid] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL
) ON [CustInfo_table]
GO

--CREATE INDEX
CREATE CLUSTERED INDEX [IX_CustSubMini_Del_Inhouse_RepUpdateTime] ON [dbo].[CustSubMini_Del_Inhouse]
(
	[RepUpdateTime] ASC
)
GO
