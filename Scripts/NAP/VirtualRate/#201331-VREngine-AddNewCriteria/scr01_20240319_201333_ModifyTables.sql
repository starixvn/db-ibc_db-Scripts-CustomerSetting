/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20240319
	Task: [NAP CM] VR Engine - Add in new criteria: Apply follow the VR accumulated balance, Currency [Redmine: #201333]
	DB: DBCUST/CustDB
*/

ALTER TABLE VRSettingRule ADD AccumulatedBalance BIT NOT NULL CONSTRAINT DF_VRSettingRule_AccumulatedBalance DEFAULT(0) WITH VALUES
GO

ALTER TABLE VRSettingRuleDetail ADD CurrencyID INT NOT NULL CONSTRAINT DF_VRSettingRuleDetail_CurrencyID DEFAULT(0) WITH VALUES 
GO

ALTER TABLE VRSettingRuleDetail_NotApply ADD CurrencyID INT NOT NULL CONSTRAINT DF_VRSettingRuleDetail_NotApply_CurrencyID DEFAULT(0) WITH VALUES 
GO

CREATE NONCLUSTERED INDEX [ix_VRSettingRuleDetail_NotApply] ON [dbo].[VRSettingRuleDetail_NotApply]
(
	[Sporttype] ASC,
	[Bettype] ASC,
	[SiteID] ASC,
	[CustomerClass] ASC,
	[DateOfWeek] ASC,
	[LeagueGroupID] ASC,
	[LeagueID] ASC,
	[RuleID] ASC,
	[CurrencyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [virtualrate_table]
GO
