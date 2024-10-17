/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created: Winfred
	Date: 31072024
	Task: Scale Out DBCUST - Apply In-house Replication for Virtual Rate Setting  [redmine: #207029]
	DB: DBCust-CustDB
*/
ALTER TABLE [VRSettingRule] ADD RepUpdateTime DATETIME2 NULL 
GO

ALTER TABLE [VRSettingRuleDetail] ADD RepUpdateTime DATETIME2 NULL 
GO

ALTER TABLE [VRSettingRuleDetail_NotApply] ADD RepUpdateTime DATETIME2 NULL 
GO

ALTER TABLE [dbo].[VRSettingRule] ADD  CONSTRAINT [DF_VRSettingRule_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

ALTER TABLE [dbo].[VRSettingRuleDetail] ADD  CONSTRAINT [DF_VRSettingRuleDetail_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

ALTER TABLE [dbo].[VRSettingRuleDetail_NotApply] ADD  CONSTRAINT [DF_VRSettingRuleDetail_NotApply_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[VRSettingRule]') AND name = N'IX_VRSettingRule_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_VRSettingRule_RepUpdateTime] ON [dbo].[VRSettingRule]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[VRSettingRuleDetail]') AND name = N'IX_VRSettingRuleDetail_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_VRSettingRuleDetail_RepUpdateTime] ON [dbo].[VRSettingRuleDetail]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[VRSettingRuleDetail_NotApply]') AND name = N'IX_VRSettingRuleDetail_NotApply_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_VRSettingRuleDetail_NotApply_RepUpdateTime] ON [dbo].[VRSettingRuleDetail_NotApply]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO