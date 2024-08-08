/*<info serverAlias="DBACC-bodb02"></info>*/
/*
	Created: Winfred
	Date: 20240808
	Task: [NAP CM] [NAP CM] Scale out DBCust - VR - Rename "Views" and update SP [Redmine: #209106]
	DB: DBACC/bodb02
*/

CREATE VIEW [dbo].vw_VRSettingRulee
/*
	Created: 20210428@Eden
	Task : VR Engine
	DB: DBACC-bodb02
	Original:

	Revisions:  
	- 20210428@Eden: First commit [Redmine:#136423]
	- 20240319@Luke: [NAP CM] VR Engine - Add in new criteria: Apply follow the VR accumulated balance, Currency [Redmine: #201333]
	-- 20240808@Winfred: [NAP CM] Scale out DBCust - VR - Rename "Views" and update SP [Redmine: #209106]

	Parameter explanation:
*/
AS
	SELECT [RuleID]
		  ,[RuleName]
		  ,[SiteType]
		  ,[Betfrom]
		  ,[StakeRM_From]
		  ,[StakeRM_To]
		  ,[VR_From]
		  ,[VR_To]
		  ,[VRStatus]
		  ,[BeginTime]
		  ,[EndTime]
		  ,[LiveIndicator]
		  ,[Adjustmenttype]
		  ,[AdjustmentValue]
		  ,[Priority]
		  ,[Status]
		  ,[CreatedDTS]
		  ,[CreatedBy]
		  ,[Enabled_Column]
		  ,[AccumulatedBalance]
	FROM DBCUST.CUSTDB.dbo.VRSettingRule WITH(NOLOCK)
GO

CREATE VIEW [dbo].vw_VRSettingRuleDetail_NotApply
/*
	Created: 20210428@Eden
	Task : VR Engine
	DB: DBACC-bodb02
	Original:

	Revisions:  
	- 20210428@Eden: First commit [Redmine:#136423]
	- 20240319@Luke: [NAP CM] VR Engine - Add in new criteria: Apply follow the VR accumulated balance, Currency [Redmine: #201333]
	-- 20240422@Winfred: [NAP CM] VR Engine - Allow to add CC by Sport, and re-arrange league group on dropdownlist [Redmine: #195539]
	-- 20240808@Winfred: [NAP CM] Scale out DBCust - VR - Rename "Views" and update SP [Redmine: #209106]

	Parameter explanation:
*/
AS
	SELECT [DetailID]
		  ,[RuleID]
		  ,[Sporttype]
		  ,[Bettype]
		  ,[SiteID]
		  ,[CustomerClass]
		  ,[DateOfWeek]
		  ,[LeagueGroupID]
		  ,[LeagueID]
		  ,[CurrencyID]
		  ,[CustomerClassDetail]
		  ,[CCSporttype]
	FROM DBCUST.CUSTDB.dbo.VRSettingRuleDetail_NotApply WITH(NOLOCK)
GO

CREATE VIEW [dbo].vw_VRSettingRuleDetail
/*
	Created: 20210428@Eden
	Task : VR Engine
	DB: DBACC-bodb02
	Original:

	Revisions:  
	- 20210428@Eden: First commit [Redmine:#136423]
	- 20240319@Luke: [NAP CM] VR Engine - Add in new criteria: Apply follow the VR accumulated balance, Currency [Redmine: #201333]
	-- 20240422@Winfred: [NAP CM] VR Engine - Allow to add CC by Sport, and re-arrange league group on dropdownlist [Redmine: #195539]
	-- 20240808@Winfred: [NAP CM] Scale out DBCust - VR - Rename "Views" and update SP [Redmine: #209106]

	Parameter explanation:
*/
AS
	SELECT [DetailID]
		  ,[RuleID]
		  ,[Sporttype]
		  ,[Bettype]
		  ,[SiteID]
		  ,[CustomerClass]
		  ,[DateOfWeek]
		  ,[LeagueGroupID]
		  ,[LeagueID]
		  ,[CurrencyID]
		  ,[CustomerClassDetail]
		  ,[CCSporttype]
	FROM DBCUST.CUSTDB.dbo.VRSettingRuleDetail WITH(NOLOCK)
GO