/*<info serverAlias="DBTP-bodb_History"></info>*/
/*
	Created: 20241115@Johnson
	Task: Disable triggers ON DBTP for history tables [redmine:#212684]
	DB: DBTP/bodb_History
*/

DISABLE TRIGGER [CustDiscount3rd_Agent_update] ON [dbo].[CustDiscount3rd_Agent]
GO

DISABLE TRIGGER [dbo].[CustDiscount3rd_Member_update] ON [dbo].[CustDiscount3rd_Member]
GO

DISABLE TRIGGER [dbo].[CustInfo_update] ON [dbo].[custInfo]
GO

DISABLE TRIGGER [dbo].[CustMaxPayoutSetting_Agent_update] ON [dbo].[CustMaxPayoutSetting_Agent]
GO

DISABLE TRIGGER [dbo].[CustMaxPayoutSetting_Member_update] ON [dbo].[CustMaxPayoutSetting_Member]
GO

DISABLE TRIGGER [dbo].[trg_Customer_update] ON [dbo].[Customer]
GO

DISABLE TRIGGER [dbo].[CustProductStatus_update] ON [dbo].[CustProductStatus]
GO

DISABLE TRIGGER [dbo].[CustPTGroupSetting3rd_Member_update] ON [dbo].[CustPTGroupSetting3rd_Member]
GO

DISABLE TRIGGER [dbo].[CustPTSetting3rd_Agent_update] ON [dbo].[CustPTSetting3rd_Agent]
GO

DISABLE TRIGGER [dbo].[CustPTSetting3rd_Member_update] ON [dbo].[CustPTSetting3rd_Member]
GO

DISABLE TRIGGER [dbo].[CustSettingMode3rd_update] ON [dbo].[CustSettingMode3rd]
GO

DISABLE TRIGGER [dbo].[CustStakeLevel_Agent_update] ON [dbo].[CustStakeLevel_Agent]
GO

DISABLE TRIGGER [dbo].[CustStakeLevel_Member_update] ON [dbo].[CustStakeLevel_Member]
GO

DISABLE TRIGGER [dbo].[CustWinLossLimit_Agent_update] ON [dbo].[CustWinLossLimit_Agent]
GO

DISABLE TRIGGER [dbo].[CustWinLossLimit_Member_update] ON [dbo].[CustWinLossLimit_Member]
GO