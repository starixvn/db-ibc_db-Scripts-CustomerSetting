/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230911@Tacy
	Task: Add new columns on table WinLimit_ProductSettingDetail
		 https://nexdev.net/issues/192624 [RedmineID: #192624]
	Database: DBCUST/CustDB
*/

USE CustDB
GO

ALTER TABLE [dbo].[WinLimit_ProductSettingDetail] ADD IsSuspendedAccount BIT NULL
GO

ALTER TABLE [dbo].[WinLimit_ProductSettingDetail] ADD  CONSTRAINT [DF_WinLimit_ProductSettingDetail_IsSuspendedAccount]  DEFAULT ((0)) FOR [IsSuspendedAccount]
GO