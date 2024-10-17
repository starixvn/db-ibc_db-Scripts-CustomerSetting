/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created: Winfred
	Date: 31072024
	Task: Scale Out DBCUST - Apply In-house Replication for Virtual Rate Setting  [redmine: #207029]
	DB: DBCust-CustDB
*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustSettingAutoSuspend]') AND type in (N'U'))   
	ALTER TABLE [dbo].[CustSettingAutoSuspend] DROP CONSTRAINT IF EXISTS [DF_CustSettingAutoSuspend_RepUpdateTime]  
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustVirtualSetting]') AND type in (N'U'))   
	ALTER TABLE [dbo].[CustVirtualSetting] DROP CONSTRAINT IF EXISTS [DF_CustVirtualSetting_RepUpdateTime]  
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProfileVirtualSetting]') AND type in (N'U'))   
	ALTER TABLE [dbo].[ProfileVirtualSetting] DROP CONSTRAINT IF EXISTS [DF_ProfileVirtualSetting_RepUpdateTime]  
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VRAgentAutoAdjustment]') AND type in (N'U'))  
	ALTER TABLE [dbo].[VRAgentAutoAdjustment] DROP CONSTRAINT IF EXISTS [DF_VRAgentAutoAdjustment_RepUpdateTime] 
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VRAgentProfile]') AND type in (N'U'))   
	ALTER TABLE [dbo].[VRAgentProfile] DROP CONSTRAINT IF EXISTS [DF_VRAgentProfile_RepUpdateTime]  
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VRBettypeGroup]') AND type in (N'U'))   
	ALTER TABLE [dbo].[VRBettypeGroup] DROP CONSTRAINT IF EXISTS [DF_VRBettypeGroup_RepUpdateTime]  
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VRCustAutoAdjustment]') AND type in (N'U'))   
	ALTER TABLE [dbo].[VRCustAutoAdjustment] DROP CONSTRAINT IF EXISTS [DF_VRCustAutoAdjustment_RepUpdateTime]  
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VRCustLockStatus]') AND type in (N'U'))  
	ALTER TABLE [dbo].[VRCustLockStatus] DROP CONSTRAINT IF EXISTS [DF_VRCustLockStatus_RepUpdateTime]  
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VRCustSetting]') AND type in (N'U'))   
	ALTER TABLE [dbo].[VRCustSetting] DROP CONSTRAINT IF EXISTS [DF_VRCustSetting_RepUpdateTime] 
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VRLeagueGroup]') AND type in (N'U'))   
	ALTER TABLE [dbo].[VRLeagueGroup] DROP CONSTRAINT IF EXISTS [DF_VRLeagueGroup_RepUpdateTime]  
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VRLeagueGroupMapping]') AND type in (N'U'))   
	ALTER TABLE [dbo].[VRLeagueGroupMapping] DROP CONSTRAINT IF EXISTS [DF_VRLeagueGroupMapping_RepUpdateTime]  
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VRSettingHierarchy]') AND type in (N'U'))   
	ALTER TABLE [dbo].[VRSettingHierarchy] DROP CONSTRAINT IF EXISTS [DF_VRSettingHierarchy_RepUpdateTime]  
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VRSettingManualUpdAcc]') AND type in (N'U'))   
	ALTER TABLE [dbo].[VRSettingManualUpdAcc] DROP CONSTRAINT IF EXISTS [DF_VRSettingManualUpdAcc_RepUpdateTime]  
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VRSettingReference]') AND type in (N'U'))   
	ALTER TABLE [dbo].[VRSettingReference] DROP CONSTRAINT IF EXISTS [DF_VRSettingReference_RepUpdateTime]  
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VRSettingRule]') AND type in (N'U'))   
ALTER TABLE [dbo].[VRSettingRule] DROP CONSTRAINT IF EXISTS [DF_VRSettingRule_RepUpdateTime]  
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VRSettingRuleDetail_NotApply]') AND type in (N'U'))   
	ALTER TABLE [dbo].[VRSettingRuleDetail_NotApply] DROP CONSTRAINT IF EXISTS [DF_VRSettingRuleDetail_NotApply_RepUpdateTime] 
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VRSettingRuleDetail]') AND type in (N'U'))   
	ALTER TABLE [dbo].[VRSettingRuleDetail] DROP CONSTRAINT IF EXISTS [DF_VRSettingRuleDetail_RepUpdateTime]  
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VRValueMapping]') AND type in (N'U'))   
	ALTER TABLE [dbo].[VRValueMapping] DROP CONSTRAINT IF EXISTS [DF_VRValueMapping_RepUpdateTime]  
GO