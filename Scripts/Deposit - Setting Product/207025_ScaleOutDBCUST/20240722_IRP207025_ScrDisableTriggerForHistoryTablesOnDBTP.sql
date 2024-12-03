/*<info serverAlias="DBTP-bodb02"></info>*/
/*
	Created: 20240722@Johnson
	Task: Disable trigger for history table on DBTP.bodb02 [redmine:#207025]
	DB: DBTP/bodb02
*/

DISABLE TRIGGER dbo.Dep_CustBetSetting_Agent_update ON [dbo].[Dep_CustBetSetting_Agent]
GO

DISABLE TRIGGER [Dep_CustBetSetting_Member_update] ON [dbo].[Dep_CustBetSetting_Member]
GO

DISABLE TRIGGER [Dep_CustBetSettingGame_Agent_update] ON [dbo].[Dep_CustBetSettingGame_Agent]
GO

DISABLE TRIGGER [Dep_CustBetSettingGame_Member_update] ON [dbo].[Dep_CustBetSettingGame_Member]
GO

DISABLE TRIGGER [Dep_CustBetSettingGameGroup_Member_update] ON [dbo].[Dep_CustBetSettingGameGroup_Member]
GO

DISABLE TRIGGER [Dep_CustDiscountGroupSetting_Member_update] ON [dbo].[Dep_CustDiscountGroupSetting_Member]
GO

DISABLE TRIGGER [Dep_CustDiscountSetting_Agent_update] ON [dbo].[Dep_CustDiscountSetting_Agent]
GO

DISABLE TRIGGER [Dep_CustDiscountSetting_Member_update] ON [dbo].[Dep_CustDiscountSetting_Member]
GO

DISABLE TRIGGER [Dep_CustProductStatus_update] ON [dbo].[Dep_CustProductStatus]
GO

DISABLE TRIGGER [Dep_CustPTGroupSetting_Member_update] ON [dbo].[Dep_CustPTGroupSetting_Member]
GO

DISABLE TRIGGER [Dep_CustPTSetting_Agent_update] ON [dbo].[Dep_CustPTSetting_Agent]
GO

DISABLE TRIGGER [Dep_CustPTSetting_Member_update] ON [dbo].[Dep_CustPTSetting_Member]
GO

DISABLE TRIGGER [Dep_CustSettingGame_update] ON [dbo].[Dep_CustSettingGame]
GO

DISABLE TRIGGER [Dep_CustSettingMode_update] ON [dbo].[Dep_CustSettingMode]
GO

DISABLE TRIGGER [Dep_CustStakeLevel_Agent__update] ON [dbo].[Dep_CustStakeLevel_Agent]
GO

DISABLE TRIGGER [Dep_CustStakeLevel_Member__update] ON [dbo].[Dep_CustStakeLevel_Member]
GO

