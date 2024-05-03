/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20240422
	Task: [NAP CM] VR Engine - Allow to add CC by Sport, and re-arrange league group on dropdownlist [Redmine: #195539]
	DB: DBCUST/CustDB
*/

ALTER TABLE VRSettingRuleDetail ADD CustomerClassDetail SMALLINT NOT NULL CONSTRAINT DF_VRSettingRuleDetail_CustomerClass DEFAULT(0) WITH VALUES 
GO

ALTER TABLE VRSettingRuleDetail ADD CCSporttype	SMALLINT NOT NULL CONSTRAINT DF_VRSettingRuleDetail_CCSporttype DEFAULT(0) WITH VALUES 
GO

ALTER TABLE VRSettingRuleDetail_NotApply ADD CustomerClassDetail SMALLINT NOT NULL CONSTRAINT DF_VRSettingRuleDetail_NotApply_CustomerClass DEFAULT(0) WITH VALUES 
GO

ALTER TABLE VRSettingRuleDetail_NotApply ADD CCSporttype SMALLINT NOT NULL CONSTRAINT DF_VRSettingRuleDetail_NotApply_CCSporttype DEFAULT(0) WITH VALUES 
GO

DROP INDEX VRSettingRuleDetail_NotApply.ix_VRSettingRuleDetail_NotApply;

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
	[CurrencyID] ASC,
	[CustomerClassDetail] ASC,
	[CCSporttype] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [virtualrate_table]
GO

