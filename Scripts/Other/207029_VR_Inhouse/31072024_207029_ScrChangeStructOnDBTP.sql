/*<info serverAlias="DBTP-bodb_CustHistory"></info>*/
/*
	Created: Winfred
	Date: 31072024
	Task: Scale Out DBCUST - Apply In-house Replication for Virtual Rate Setting add history tables  [redmine: #207029]
	DB: DBTP/bodb_CustHistory
*/
------------------------------------------------------CustVirtualSetting_History
ALTER TABLE CustVirtualSetting_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_CustVirtualSetting_History_rID_SiteDBGroupID] ON [dbo].[CustVirtualSetting_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [Dep_CustBetSetting_table]
GO

------------------------------------------------------VRCustLockStatus_History
ALTER TABLE VRCustLockStatus_History 
ADD rID BIGINT,
	SiteDBGroupID smallint NULL
GO

CREATE NONCLUSTERED INDEX [IX_VRCustLockStatus_History_rID_SiteDBGroupID] ON [dbo].[VRCustLockStatus_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,DATA_COMPRESSION = PAGE) ON [Dep_CustBetSetting_table]
GO
