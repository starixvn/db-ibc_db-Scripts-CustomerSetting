/*
	Created: Tiara
	Date: 20200220
	Task: Change Primary Constraint on ProductSettingDetail [RedmineID]:#128058
	DB: DBCust/CustDB
*/


USE [CustDB]
GO

ALTER TABLE [dbo].[ProductSettingDetail] DROP CONSTRAINT [PK_ProductSettingDetail]

ALTER TABLE [dbo].[ProductSettingDetail] ADD  CONSTRAINT [PK_ProductSettingDetail] PRIMARY KEY CLUSTERED 
(	[ProductID] ASC,
	[SettingType] ASC,
	[SportType] ASC,
	[BetType] ASC,
	[IsLive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ProductSettingDetail_table]
GO




