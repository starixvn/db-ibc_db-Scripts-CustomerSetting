/*<info serverAlias="DBTP-bodb_History"></info>*/
/*
	Created: 20241106@Johnson
	Task: Database structure change ON DBTP for history tables [redmine:#212684]
	DB: DBTP/bodb_History
*/
----------------------------------------------------
--CustDiscount3rd_Agent_History
ALTER TABLE CustDiscount3rd_Agent_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_CustDiscount3rd_Agent_History_rID_SiteDBGroupID] ON [dbo].[CustDiscount3rd_Agent_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [CustDiscount3rd_Agent_table]
GO

----------------------------------------------------
--CustDiscount3rd_Member_History
ALTER TABLE CustDiscount3rd_Member_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_CustDiscount3rd_Member_History_rID_SiteDBGroupID] ON [dbo].[CustDiscount3rd_Member_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [CustDiscount3rd_Member_table]
GO

----------------------------------------------------
--CustInfo_History
ALTER TABLE CustInfo_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_CustInfo_History_rID_SiteDBGroupID] ON [dbo].[CustInfo_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [Customer_table]
GO

----------------------------------------------------
--CustMaxPayoutSetting_Agent_History
ALTER TABLE CustMaxPayoutSetting_Agent_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_CustMaxPayoutSetting_Agent_History_rID_SiteDBGroupID] ON [dbo].[CustMaxPayoutSetting_Agent_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO

----------------------------------------------------
--CustMaxPayoutSetting_Member_History
ALTER TABLE CustMaxPayoutSetting_Member_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_CustMaxPayoutSetting_Member_History_rID_SiteDBGroupID] ON [dbo].[CustMaxPayoutSetting_Member_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO

----------------------------------------------------
--Customer_History
ALTER TABLE Customer_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_Customer_History_rID_SiteDBGroupID] ON [dbo].[Customer_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [Customer_table]
GO

----------------------------------------------------
--CustProductStatus_History
ALTER TABLE CustProductStatus_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_CustProductStatus_History_rID_SiteDBGroupID] ON [dbo].[CustProductStatus_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [CustProductStatus_table]
GO

----------------------------------------------------
--CustPTGroupSetting3rd_Member_History
ALTER TABLE CustPTGroupSetting3rd_Member_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_CustPTGroupSetting3rd_Member_History_rID_SiteDBGroupID] ON [dbo].[CustPTGroupSetting3rd_Member_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [CustPTGroupSetting3rd_Member_table]
GO

----------------------------------------------------
--CustPTSetting3rd_Agent_History
ALTER TABLE CustPTSetting3rd_Agent_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_CustPTSetting3rd_Agent_History_rID_SiteDBGroupID] ON [dbo].[CustPTSetting3rd_Agent_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [CustPTSetting3rd_Agent_table]
GO

----------------------------------------------------
--CustPTSetting3rd_Member_History
ALTER TABLE CustPTSetting3rd_Member_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_CustPTSetting3rd_Member_History_rID_SiteDBGroupID] ON [dbo].[CustPTSetting3rd_Member_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [CustPTSetting3rd_Member_table]
GO

----------------------------------------------------
--CustSettingMode3rd_History
ALTER TABLE CustSettingMode3rd_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_CustSettingMode3rd_History_rID_SiteDBGroupID] ON [dbo].[CustSettingMode3rd_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [CustSettingMode3rd_table]
GO

----------------------------------------------------
--CustStakeLevel_Agent_History
ALTER TABLE CustStakeLevel_Agent_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_CustStakeLevel_Agent_History_rID_SiteDBGroupID] ON [dbo].[CustStakeLevel_Agent_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [CustStakeLevel_table]
GO

----------------------------------------------------
--CustStakeLevel_Member_History
ALTER TABLE CustStakeLevel_Member_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_CustStakeLevel_Member_History_rID_SiteDBGroupID] ON [dbo].[CustStakeLevel_Member_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [CustStakeLevel_table]
GO

----------------------------------------------------
--CustWinLossLimit_Agent_History
ALTER TABLE CustWinLossLimit_Agent_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_CustWinLossLimit_Agent_History_rID_SiteDBGroupID] ON [dbo].[CustWinLossLimit_Agent_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [CustWinLossLimit_table]
GO

----------------------------------------------------
--CustWinLossLimit_Member_History
ALTER TABLE CustWinLossLimit_Member_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_CustWinLossLimit_Member_History_rID_SiteDBGroupID] ON [dbo].[CustWinLossLimit_Member_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [CustWinLossLimit_table]
GO