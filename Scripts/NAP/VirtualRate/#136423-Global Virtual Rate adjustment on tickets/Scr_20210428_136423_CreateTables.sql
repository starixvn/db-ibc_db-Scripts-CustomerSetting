/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210428@Eden
	Task: Create table VRSettingRule, VRSettingRuleDetail, VRSettingRuleDetail_NotApply [RM#136423]
	DB: DBCUST/CustDB fisrt (and add to CustDB_CustSetting publication when UM - Drop view before add table)
*/
SET ANSI_NULLS ON
GO
IF EXISTS(
	SELECT TOP 1 1 FROM sys.views v WHERE OBJECT_NAME(v.object_id) = 'VRSettingRule'
)
	DROP VIEW [dbo].VRSettingRule 
GO
IF EXISTS(
	SELECT TOP 1 1 FROM sys.views v WHERE OBJECT_NAME(v.object_id) = 'VRSettingRuleDetail'
)
	DROP VIEW [dbo].VRSettingRuleDetail 
GO
IF EXISTS(
	SELECT TOP 1 1 FROM sys.views v WHERE OBJECT_NAME(v.object_id) = 'VRSettingRuleDetail_NotApply'
)
	DROP VIEW [dbo].VRSettingRuleDetail_NotApply 
GO

--DROP TABLE [VRSettingRule]
--DROP TABLE [VRSettingRuleDetail]
--DROP TABLE [VRSettingRuleDetail_NotApply]
--GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VRSettingRule](
	[RuleID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[RuleName] [varchar](100) NOT NULL,
	[SiteType] [tinyint] NOT NULL,
	[Betfrom] [varchar](3) NOT NULL,
	[StakeRM_From] MONEY  NOT NULL,
	[StakeRM_To] MONEY NOT NULL,
	[VR_From] SMALLMONEY NOT NULL,
	[VR_To] SMALLMONEY NOT NULL,
	[VRStatus] TINYINT NOT NULL,
	[BeginTime] [time] NULL,
	[EndTime] [time] NULL,
	[LiveIndicator] [tinyint] NOT NULL,
	[Adjustmenttype] [tinyint] NOT NULL,
	[AdjustmentValue] SMALLMONEY NOT NULL,
	[Priority] INT NOT NULL,
	[Status] TINYINT NOT NULL,
	[CreatedDTS] DATETIME NULL CONSTRAINT [DF_VRSettingRule_CreatedDTS]  DEFAULT GETDATE(),
	[CreatedBy] VARCHAR(30) NULL,
	[Enabled_Column] VARCHAR(200) NULL
 CONSTRAINT [PK_VRSettingRule] PRIMARY KEY CLUSTERED 
(
	[RuleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [virtualrate_table]
) ON [virtualrate_table]

GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[VRSettingRuleDetail](
	[DetailID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL, 
	[RuleID] [int] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[SiteID] [int] NOT NULL,
	[CustomerClass] [smallint] NOT NULL,
	[DateOfWeek] [tinyint] NOT NULL,
	[LeagueGroupID] [int] NOT NULL,
	[LeagueID] [int] NOT NULL,
CONSTRAINT [PK_VRSettingRuleDetail] PRIMARY KEY NONCLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [virtualrate_table]
) ON [virtualrate_table]

GO
CREATE CLUSTERED INDEX ix_VRSettingRuleDetail ON [VRSettingRuleDetail]([Sporttype]) 
--DROP INDEX VRSettingRuleDetail.ix_VRSettingRuleDetail
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[VRSettingRuleDetail_NotApply](
	[DetailID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL, 
	[RuleID] [int] NOT NULL,
	[Sporttype] [smallint] NULL,
	[Bettype] [smallint] NULL,
	[SiteID] [int] NULL,
	[CustomerClass] [smallint] NULL,
	[DateOfWeek] [tinyint] NULL,
	[LeagueGroupID] [int] NULL,
	[LeagueID] [int] NULL,
CONSTRAINT [PK_VRSettingRuleDetail_NotApply] PRIMARY KEY NONCLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [virtualrate_table]
) ON [virtualrate_table]

GO
CREATE NONCLUSTERED INDEX ix_VRSettingRuleDetail_NotApply ON [VRSettingRuleDetail_NotApply]([Sporttype],[Bettype],[SiteID],[CustomerClass],[DateOfWeek],[LeagueGroupID],[LeagueID],[RuleID])
--DROP INDEX [VRSettingRuleDetail_NotApply].ix_VRSettingRuleDetail_NotApply