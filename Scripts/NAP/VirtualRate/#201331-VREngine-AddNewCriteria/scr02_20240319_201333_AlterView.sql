/*<info serverAlias="DBACC-bodb02"></info>*/
/*
	Created: Luke
	Date: 20240319
	Task: [NAP CM] VR Engine - Add in new criteria: Apply follow the VR accumulated balance, Currency [Redmine: #201333]
	DB: DBACC/bodb02
*/

ALTER VIEW [dbo].VRSettingRuleDetail_NotApply
/*
	Created: 20210428@Eden
	Task : VR Engine
	DB: DBACC-bodb02
	Original:

	Revisions:  
	- 20210428@Eden: First commit [Redmine:#136423]
	- 20240319@Luke: [NAP CM] VR Engine - Add in new criteria: Apply follow the VR accumulated balance, Currency [Redmine: #201333]

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
	FROM DBCUST.CUSTDB.dbo.VRSettingRuleDetail_NotApply WITH(NOLOCK)
GO

ALTER VIEW [dbo].VRSettingRuleDetail
/*
	Created: 20210428@Eden
	Task : VR Engine
	DB: DBACC-bodb02
	Original:

	Revisions:  
	- 20210428@Eden: First commit [Redmine:#136423]
	- 20240319@Luke: [NAP CM] VR Engine - Add in new criteria: Apply follow the VR accumulated balance, Currency [Redmine: #201333]

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
	FROM DBCUST.CUSTDB.dbo.VRSettingRuleDetail WITH(NOLOCK)
GO

ALTER VIEW [dbo].VRSettingRule
/*
	Created: 20210428@Eden
	Task : VR Engine
	DB: DBACC-bodb02
	Original:

	Revisions:  
	- 20210428@Eden: First commit [Redmine:#136423]
	- 20240319@Luke: [NAP CM] VR Engine - Add in new criteria: Apply follow the VR accumulated balance, Currency [Redmine: #201333]

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
