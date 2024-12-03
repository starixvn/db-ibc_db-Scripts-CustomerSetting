/*<info serverAlias="DBTP-bodb_CustHistory"></info>*/
/*
	Created: 20240719@Johnson
	Task: database structure change on DBTP.bodb_CustHistory [redmine:#207025]
	DB: DBTP/bodb_CustHistory
*/
----------------------------------------------------
--Dep_CustBetSetting_Agent_History
ALTER TABLE Dep_CustBetSetting_Agent_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_Dep_CustBetSetting_Agent_History_rID_SiteDBGroupID] ON [dbo].[Dep_CustBetSetting_Agent_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [Dep_CustBetSetting_table]
GO

----------------------------------------------------
--Dep_CustBetSetting_Member_History
ALTER TABLE Dep_CustBetSetting_Member_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_Dep_CustBetSetting_Member_History_rID_SiteDBGroupID] ON [dbo].[Dep_CustBetSetting_Member_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [Dep_CustBetSetting_table]
GO

----------------------------------------------------
--Dep_CustBetSettingGame_Agent_History
ALTER TABLE Dep_CustBetSettingGame_Agent_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_Dep_CustBetSettingGame_Agent_History_rID_SiteDBGroupID] ON [dbo].[Dep_CustBetSettingGame_Agent_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [Dep_CustSetting_table]
GO

----------------------------------------------------
--Dep_CustBetSettingGame_Member_History
ALTER TABLE Dep_CustBetSettingGame_Member_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_Dep_CustBetSettingGame_Member_History_rID_SiteDBGroupID] ON [dbo].[Dep_CustBetSettingGame_Member_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [Dep_CustSetting_table]
GO

----------------------------------------------------
--Dep_CustBetSettingGameGroup_Member_History
ALTER TABLE Dep_CustBetSettingGameGroup_Member_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_Dep_CustBetSettingGameGroup_Member_History_rID_SiteDBGroupID] ON [dbo].[Dep_CustBetSettingGameGroup_Member_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [Dep_CustSetting_table]
GO

----------------------------------------------------
--Dep_CustDiscountGroupSetting_Member_History
ALTER TABLE Dep_CustDiscountGroupSetting_Member_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_Dep_CustDiscountGroupSetting_Member_History_rID_SiteDBGroupID] ON [dbo].[Dep_CustDiscountGroupSetting_Member_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [Dep_CustDiscount_Member_Table]
GO

----------------------------------------------------
--Dep_CustDiscountSetting_Agent_History
ALTER TABLE Dep_CustDiscountSetting_Agent_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_Dep_CustDiscountSetting_Agent_History_rID_SiteDBGroupID] ON [dbo].[Dep_CustDiscountSetting_Agent_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [Dep_CustDiscountSetting_Agent_table]
GO

----------------------------------------------------
--Dep_CustDiscountSetting_Member_History
ALTER TABLE Dep_CustDiscountSetting_Member_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_Dep_CustDiscountSetting_Member_History_rID_SiteDBGroupID] ON [dbo].[Dep_CustDiscountSetting_Member_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [Dep_CustDiscount_Member_Table]
GO

----------------------------------------------------
--Dep_CustProductStatus_History
ALTER TABLE Dep_CustProductStatus_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_Dep_CustProductStatus_History_rID_SiteDBGroupID] ON [dbo].[Dep_CustProductStatus_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [Dep_CustSetting3rd_table]
GO

----------------------------------------------------
--Dep_CustPTGroupSetting_Member_History
ALTER TABLE Dep_CustPTGroupSetting_Member_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_Dep_CustPTGroupSetting_Member_History_rID_SiteDBGroupID] ON [dbo].[Dep_CustPTGroupSetting_Member_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [Dep_CustSetting3rd_table]
GO

----------------------------------------------------
--Dep_CustPTSetting_Agent_History
ALTER TABLE Dep_CustPTSetting_Agent_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_Dep_CustPTSetting_Agent_History_rID_SiteDBGroupID] ON [dbo].[Dep_CustPTGroupSetting_Member_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [Dep_CustSetting3rd_table]
GO

----------------------------------------------------
--Dep_CustPTSetting_Member_History
ALTER TABLE Dep_CustPTSetting_Member_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_Dep_CustPTSetting_Member_History_rID_SiteDBGroupID] ON [dbo].[Dep_CustPTSetting_Member_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [Dep_CustSetting3rd_table]
GO

----------------------------------------------------
--Dep_CustSettingGame_History
ALTER TABLE Dep_CustSettingGame_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_Dep_CustSettingGame_History_rID_SiteDBGroupID] ON [dbo].[Dep_CustSettingGame_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [Dep_CustSettingGame_table]
GO

----------------------------------------------------
--Dep_CustSettingMode_History
ALTER TABLE Dep_CustSettingMode_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_Dep_CustSettingMode_History_rID_SiteDBGroupID] ON [dbo].[Dep_CustSettingMode_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [Dep_CustSetting3rd_table]
GO

----------------------------------------------------
--Dep_CustStakeLevel_Agent_History
ALTER TABLE Dep_CustStakeLevel_Agent_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_Dep_CustStakeLevel_Agent_History_rID_SiteDBGroupID] ON [dbo].[Dep_CustStakeLevel_Agent_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [Dep_CustSetting3rd_table]
GO

----------------------------------------------------
--Dep_CustStakeLevel_Member_History
ALTER TABLE Dep_CustStakeLevel_Member_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_Dep_CustStakeLevel_Member_History_rID_SiteDBGroupID] ON [dbo].[Dep_CustStakeLevel_Member_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [Dep_CustSetting3rd_table]
GO