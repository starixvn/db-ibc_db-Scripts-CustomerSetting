/*<info serverAlias="DBTP-bodb_History"></info>*/
/*
	Created: 20241115@Johnson
	Task: Disable triggers ON DBTP for history tables [redmine:#212684]
	DB: DBTP/bodb_History
*/

DISABLE TRIGGER [dbo].[CustInfo_update] ON [dbo].[custInfo]
GO

DISABLE TRIGGER [dbo].[trg_Customer_update] ON [dbo].[Customer]
GO
