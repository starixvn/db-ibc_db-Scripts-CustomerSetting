/*<info serverAlias="DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241104@Johnson	
	Task: Add new tables Del_Inhouse for credit setting [redmine:#212684]
	DB: DBCUST-CustDB
*/
------------------------------------------------------------------------
--CustAgent
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustAgent_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustAgent_Del_InHouse]
	(
		CustId [INT]  NOT NULL,
		[RepUpdateTime] DATETIME2(7) NULL
	) ON [DATA]

	ALTER TABLE [dbo].[CustAgent_Del_InHouse] ADD  CONSTRAINT [DF_CustAgent_Del_InHouse_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]

	CREATE CLUSTERED INDEX [CIX_CustAgent_Del_InHouse_RepUpdateTime] ON [dbo].[CustAgent_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
	SELECT 'table CustAgent_Del_InHouse exists!!!'
GO
------------------------------------------------------------------------

------------------------------------------------------------------------
--CustDiscount3rd_Agent
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustDiscount3rd_Agent_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustDiscount3rd_Agent_Del_InHouse]
	(
		CustId [INT]  NOT NULL,
		[SportType] [smallint] NOT NULL,
		[BetType] [smallint] NOT NULL,
		[RepUpdateTime] DATETIME2(7) NULL
	) ON [DATA]

	ALTER TABLE [dbo].[CustDiscount3rd_Agent_Del_InHouse] ADD  CONSTRAINT [DF_CustDiscount3rd_Agent_Del_InHouse_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]

	CREATE CLUSTERED INDEX [CIX_CustDiscount3rd_Agent_Del_InHouse_RepUpdateTime] ON [dbo].[CustDiscount3rd_Agent_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
	SELECT 'table CustDiscount3rd_Agent_Del_InHouse exists!!!'
GO
------------------------------------------------------------------------

------------------------------------------------------------------------
--CustDiscount3rd_Member
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustDiscount3rd_Member_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustDiscount3rd_Member_Del_InHouse]
	(
		CustId [INT]  NOT NULL,
		[SportType] [smallint] NOT NULL,
		[BetType] [smallint] NOT NULL,
		[RepUpdateTime] DATETIME2(7) NULL
	) ON [DATA]

	ALTER TABLE [dbo].[CustDiscount3rd_Member_Del_InHouse] ADD  CONSTRAINT [DF_CustDiscount3rd_Member_Del_InHouse_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]

	CREATE CLUSTERED INDEX [CIX_CustDiscount3rd_Member_Del_InHouse_RepUpdateTime] ON [dbo].[CustDiscount3rd_Member_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
	SELECT 'table CustDiscount3rd_Member_Del_InHouse exists!!!'
GO
------------------------------------------------------------------------


------------------------------------------------------------------------
--CustInfo
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustInfo_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustInfo_Del_InHouse]
	(
		CustId [INT]  NOT NULL,
		[RepUpdateTime] DATETIME2(7) NULL
	) ON [DATA]

	ALTER TABLE [dbo].[CustInfo_Del_InHouse] ADD  CONSTRAINT [DF_CustInfo_Del_InHouse_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]

	CREATE CLUSTERED INDEX [CIX_CustInfo_Del_InHouse_RepUpdateTime] ON [dbo].[CustInfo_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
	SELECT 'table CustInfo_Del_InHouse exists!!!'
GO
------------------------------------------------------------------------

------------------------------------------------------------------------
--CustMaster
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustMaster_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustMaster_Del_InHouse]
	(
		CustId [INT]  NOT NULL,
		[RepUpdateTime] DATETIME2(7) NULL
	) ON [DATA]

	ALTER TABLE [dbo].[CustMaster_Del_InHouse] ADD  CONSTRAINT [DF_CustMaster_Del_InHouse_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]

	CREATE CLUSTERED INDEX [CIX_CustMaster_Del_InHouse_RepUpdateTime] ON [dbo].[CustMaster_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
	SELECT 'table CustMaster_Del_InHouse exists!!!'
GO
------------------------------------------------------------------------

------------------------------------------------------------------------
--CustMaxPayoutSetting_Agent
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustMaxPayoutSetting_Agent_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustMaxPayoutSetting_Agent_Del_InHouse]
	(
		CustId [INT]  NOT NULL,
		[SportType] [smallint] NOT NULL,
		[BetType] [smallint] NOT NULL,
		[RepUpdateTime] DATETIME2(7) NULL
	) ON [DATA]

	ALTER TABLE [dbo].[CustMaxPayoutSetting_Agent_Del_InHouse] ADD  CONSTRAINT [DF_CustMaxPayoutSetting_Agent_Del_InHouse_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]

	CREATE CLUSTERED INDEX [CIX_CustMaxPayoutSetting_Agent_Del_InHouse_RepUpdateTime] ON [dbo].[CustMaxPayoutSetting_Agent_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
	SELECT 'table CustMaxPayoutSetting_Agent_Del_InHouse exists!!!'
GO
------------------------------------------------------------------------

------------------------------------------------------------------------
--CustMaxPayoutSetting_Member
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustMaxPayoutSetting_Member_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustMaxPayoutSetting_Member_Del_InHouse]
	(
		CustId [INT]  NOT NULL,
		[SportType] [smallint] NOT NULL,
		[BetType] [smallint] NOT NULL,
		[RepUpdateTime] DATETIME2(7) NULL
	) ON [DATA]

	ALTER TABLE [dbo].[CustMaxPayoutSetting_Member_Del_InHouse] ADD  CONSTRAINT [DF_CustMaxPayoutSetting_Member_Del_InHouse_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]

	CREATE CLUSTERED INDEX [CIX_CustMaxPayoutSetting_Member_Del_InHouse_RepUpdateTime] ON [dbo].[CustMaxPayoutSetting_Member_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
	SELECT 'table CustMaxPayoutSetting_Member_Del_InHouse exists!!!'
GO
------------------------------------------------------------------------

------------------------------------------------------------------------
--Customer
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'Customer_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[Customer_Del_InHouse]
	(
		CustId [INT]  NOT NULL,
		[RepUpdateTime] DATETIME2(7) NULL
	) ON [DATA]

	ALTER TABLE [dbo].[Customer_Del_InHouse] ADD  CONSTRAINT [DF_Customer_Del_InHouse_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]

	CREATE CLUSTERED INDEX [CIX_Customer_Del_InHouse_RepUpdateTime] ON [dbo].[Customer_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
	SELECT 'table Customer_Del_InHouse exists!!!'
GO
------------------------------------------------------------------------

------------------------------------------------------------------------
--CustProductStatus
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustProductStatus_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustProductStatus_Del_InHouse]
	(
		CustId [INT]  NOT NULL,
		[RepUpdateTime] DATETIME2(7) NULL
	) ON [DATA]

	ALTER TABLE [dbo].[CustProductStatus_Del_InHouse] ADD  CONSTRAINT [DF_CustProductStatus_Del_InHouse_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]

	CREATE CLUSTERED INDEX [CIX_CustProductStatus_Del_InHouse_RepUpdateTime] ON [dbo].[CustProductStatus_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
	SELECT 'table CustProductStatus_Del_InHouse exists!!!'
GO
------------------------------------------------------------------------

------------------------------------------------------------------------
--CustPTGroupSetting3rd_Member
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustPTGroupSetting3rd_Member_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustPTGroupSetting3rd_Member_Del_InHouse]
	(
		AgentId [INT]  NOT NULL,
		[SportType] [smallint] NOT NULL,
		[BetType] [smallint] NOT NULL,
		[IsLive] [bit] NOT NULL,
		[RepUpdateTime] DATETIME2(7) NULL
	) ON [DATA]

	ALTER TABLE [dbo].[CustPTGroupSetting3rd_Member_Del_InHouse] ADD  CONSTRAINT [DF_CustPTGroupSetting3rd_Member_Del_InHouse_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]

	CREATE CLUSTERED INDEX [CIX_CustPTGroupSetting3rd_Member_Del_InHouse_RepUpdateTime] ON [dbo].[CustPTGroupSetting3rd_Member_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
	SELECT 'table CustPTGroupSetting3rd_Member_Del_InHouse exists!!!'
GO
------------------------------------------------------------------------

------------------------------------------------------------------------
--CustPTSetting3rd_Agent
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustPTSetting3rd_Agent_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustPTSetting3rd_Agent_Del_InHouse]
	(
		[CustId] [INT]  NOT NULL,
		[SportType] [smallint] NOT NULL,
		[BetType] [smallint] NOT NULL,
		[IsLive] [bit] NOT NULL,
		[RepUpdateTime] DATETIME2(7) NULL
	) ON [DATA]

	ALTER TABLE [dbo].[CustPTSetting3rd_Agent_Del_InHouse] ADD  CONSTRAINT [DF_CustPTSetting3rd_Agent_Del_InHouse_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]

	CREATE CLUSTERED INDEX [CIX_CustPTSetting3rd_Agent_Del_InHouse_RepUpdateTime] ON [dbo].[CustPTSetting3rd_Agent_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
	SELECT 'table CustPTSetting3rd_Agent exists!!!'
GO
------------------------------------------------------------------------

------------------------------------------------------------------------
--CustPTSetting3rd_Member
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustPTSetting3rd_Member_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustPTSetting3rd_Member_Del_InHouse]
	(
		[CustId] [INT]  NOT NULL,
		[SportType] [smallint] NOT NULL,
		[BetType] [smallint] NOT NULL,
		[IsLive] [bit] NOT NULL,
		[RepUpdateTime] DATETIME2(7) NULL
	) ON [DATA]

	ALTER TABLE [dbo].[CustPTSetting3rd_Member_Del_InHouse] ADD  CONSTRAINT [DF_CustPTSetting3rd_Member_Del_InHouse_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]

	CREATE CLUSTERED INDEX [CIX_CustPTSetting3rd_Member_Del_InHouse_RepUpdateTime] ON [dbo].[CustPTSetting3rd_Member_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
	SELECT 'table CustPTSetting3rd_Member exists!!!'
GO
------------------------------------------------------------------------

----------------------------------------------------------------------
--CustPTTemplate
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustPTTemplate_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustPTTemplate_Del_InHouse]
	(
		TemplateID [INT]  NOT NULL,
		[RepUpdateTime] DATETIME2(7) NULL
	) ON [DATA]

	ALTER TABLE [dbo].[CustPTTemplate_Del_InHouse] ADD  CONSTRAINT [DF_CustPTTemplate_Del_InHouse_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]

	CREATE CLUSTERED INDEX [CIX_CustPTTemplate_Del_InHouse_RepUpdateTime] ON [dbo].[CustPTTemplate_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
	SELECT 'table CustPTTemplate_Del_InHouse exists!!!'
GO
------------------------------------------------------------------------

----------------------------------------------------------------------
--CustPTTemplateDetail
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustPTTemplateDetail_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustPTTemplateDetail_Del_InHouse]
	(
		[TemplateID] [int] NOT NULL,
		[GroupID] [tinyint] NOT NULL,
		[SubGroupID] [tinyint] NOT NULL,
		[RepUpdateTime] DATETIME2(7) NULL
	) ON [DATA]

	ALTER TABLE [dbo].[CustPTTemplateDetail_Del_InHouse] ADD  CONSTRAINT [DF_CustPTTemplateDetail_Del_InHouse_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]

	CREATE CLUSTERED INDEX [CIX_CustPTTemplateDetail_Del_InHouse_RepUpdateTime] ON [dbo].[CustPTTemplateDetail_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
	SELECT 'table CustPTTemplateDetail_Del_InHouse exists!!!'
GO
------------------------------------------------------------------------

------------------------------------------------------------------------
--CustQRCode
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustQRCode_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustQRCode_Del_InHouse]
	(
		CustId [INT]  NOT NULL,
		[RepUpdateTime] DATETIME2(7) NULL
	) ON [DATA]

	ALTER TABLE [dbo].[CustQRCode_Del_InHouse] ADD  CONSTRAINT [DF_CustQRCode_Del_InHouse_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]

	CREATE CLUSTERED INDEX [CIX_CustQRCode_Del_InHouse_RepUpdateTime] ON [dbo].[CustQRCode_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
	SELECT 'table CustQRCode_Del_InHouse exists!!!'
GO
------------------------------------------------------------------------

------------------------------------------------------------------------
--CustSettingMode3rd
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustSettingMode3rd_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustSettingMode3rd_Del_InHouse]
	(
		CustId [INT]  NOT NULL,
		[RepUpdateTime] DATETIME2(7) NULL
	) ON [DATA]

	ALTER TABLE [dbo].[CustSettingMode3rd_Del_InHouse] ADD  CONSTRAINT [DF_CustSettingMode3rd_Del_InHouse_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]

	CREATE CLUSTERED INDEX [CIX_CustSettingMode3rd_Del_InHouse_RepUpdateTime] ON [dbo].[CustSettingMode3rd_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
	SELECT 'table CustSettingMode3rd_Del_InHouse exists!!!'
GO
------------------------------------------------------------------------

------------------------------------------------------------------------
--CustStakeLevel_Agent
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustStakeLevel_Agent_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustStakeLevel_Agent_Del_InHouse]
	(
		[CustId] [INT]  NOT NULL,
		[SportType] [smallint] NOT NULL,
		[BetType] [smallint] NOT NULL,		
		[RepUpdateTime] DATETIME2(7) NULL
	) ON [DATA]

	ALTER TABLE [dbo].[CustStakeLevel_Agent_Del_InHouse] ADD  CONSTRAINT [DF_CustStakeLevel_Agent_Del_InHouse_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]

	CREATE CLUSTERED INDEX [CIX_CustStakeLevel_Agent_Del_InHouse_RepUpdateTime] ON [dbo].[CustStakeLevel_Agent_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
	SELECT 'table CustStakeLevel_Agent exists!!!'
GO
------------------------------------------------------------------------

------------------------------------------------------------------------
--CustStakeLevel_Member
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustStakeLevel_Member_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustStakeLevel_Member_Del_InHouse]
	(
		[CustId] [INT]  NOT NULL,
		[SportType] [smallint] NOT NULL,
		[BetType] [smallint] NOT NULL,		
		[RepUpdateTime] DATETIME2(7) NULL
	) ON [DATA]

	ALTER TABLE [dbo].[CustStakeLevel_Member_Del_InHouse] ADD  CONSTRAINT [DF_CustStakeLevel_Member_Del_InHouse_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]

	CREATE CLUSTERED INDEX [CIX_CustStakeLevel_Member_Del_InHouse_RepUpdateTime] ON [dbo].[CustStakeLevel_Member_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
	SELECT 'table CustStakeLevel_Member exists!!!'
GO
------------------------------------------------------------------------

------------------------------------------------------------------------
--custSub
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustSub_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustSub_Del_InHouse]
	(
		SubaccId [INT]  NOT NULL,
		[RepUpdateTime] DATETIME2(7) NULL
	) ON [DATA]

	ALTER TABLE [dbo].[CustSub_Del_InHouse] ADD  CONSTRAINT [DF_CustSub_Del_InHouse_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]

	CREATE CLUSTERED INDEX [CIX_CustSub_Del_InHouse_RepUpdateTime] ON [dbo].[CustSub_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
	SELECT 'table custSub_Del_InHouse exists!!!'
GO
------------------------------------------------------------------------

------------------------------------------------------------------------
--CustSuper
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustSuper_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustSuper_Del_InHouse]
	(
		[CustId] [INT]  NOT NULL,
		[RepUpdateTime] DATETIME2(7) NULL
	) ON [DATA]

	ALTER TABLE [dbo].[CustSuper_Del_InHouse] ADD  CONSTRAINT [DF_CustSuper_Del_InHouse_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]

	CREATE CLUSTERED INDEX [CIX_CustSuper_Del_InHouse_RepUpdateTime] ON [dbo].[CustSuper_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
	SELECT 'table CustSuper_Del_InHouse exists!!!'
GO
------------------------------------------------------------------------

------------------------------------------------------------------------
--CustSuperProfile
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustSuperProfile_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustSuperProfile_Del_InHouse]
	(
		[CustId] [INT]  NOT NULL,
		[RepUpdateTime] DATETIME2(7) NULL
	) ON [DATA]

	ALTER TABLE [dbo].[CustSuperProfile_Del_InHouse] ADD  CONSTRAINT [DF_CustSuperProfile_Del_InHouse_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]

	CREATE CLUSTERED INDEX [CIX_CustSuperProfile_Del_InHouse_RepUpdateTime] ON [dbo].[CustSuperProfile_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
	SELECT 'table CustSuperProfile_Del_InHouse exists!!!'
GO
------------------------------------------------------------------------

------------------------------------------------------------------------
--CustWinLossLimit_Agent
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustWinLossLimit_Agent_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustWinLossLimit_Agent_Del_InHouse]
	(
		[CustId] [INT]  NOT NULL,
		[SportType] [smallint] NOT NULL,
		[BetType] [smallint] NOT NULL,		
		[RepUpdateTime] DATETIME2(7) NULL
	) ON [DATA]

	ALTER TABLE [dbo].[CustWinLossLimit_Agent_Del_InHouse] ADD  CONSTRAINT [DF_CustWinLossLimit_Agent_Del_InHouse_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]

	CREATE CLUSTERED INDEX [CIX_CustWinLossLimit_Agent_Del_InHouse_RepUpdateTime] ON [dbo].[CustWinLossLimit_Agent_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
	SELECT 'table CustWinLossLimit_Agent_Del_InHouse exists!!!'
GO
------------------------------------------------------------------------

------------------------------------------------------------------------
--CustWinLossLimit_Member
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustWinLossLimit_Member_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustWinLossLimit_Member_Del_InHouse]
	(
		[CustId] [INT]  NOT NULL,
		[SportType] [smallint] NOT NULL,
		[BetType] [smallint] NOT NULL,		
		[RepUpdateTime] DATETIME2(7) NULL
	) ON [DATA]

	ALTER TABLE [dbo].[CustWinLossLimit_Member_Del_InHouse] ADD  CONSTRAINT [DF_CustWinLossLimit_Member_Del_InHouse_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]

	CREATE CLUSTERED INDEX [CIX_CustWinLossLimit_Member_Del_InHouse_RepUpdateTime] ON [dbo].[CustWinLossLimit_Member_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
	SELECT 'table CustWinLossLimit_Member_Del_InHouse exists!!!'
GO
------------------------------------------------------------------------
