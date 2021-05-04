/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210428@Eden
	Task: Create View VRSettingRule, VRSettingRuleDetail, VRSettingRuleDetail_NotApply [RM#136423]
	DB: all subscribers of CustDB_CustSetting publication
*/

CREATE VIEW [dbo].VRSettingRuleDetail_NotApply
/*
	Created: 20210428@Eden
	Task : VR Engine
	DB: DBACC-bodb02
	Original:

	Revisions:  
	- 20210428@Eden: First commit [Redmine:#136423]

	Parameter explanation:
*/
AS
	SELECT *
	FROM DBCUST.CUSTDB.dbo.VRSettingRuleDetail_NotApply WITH(NOLOCK)
GO
CREATE VIEW [dbo].VRSettingRuleDetail
/*
	Created: 20210428@Eden
	Task : VR Engine
	DB: DBACC-bodb02
	Original:

	Revisions:  
	- 20210428@Eden: First commit [Redmine:#136423]

	Parameter explanation:
*/
AS
	SELECT *
	FROM DBCUST.CUSTDB.dbo.VRSettingRuleDetail WITH(NOLOCK)
GO
CREATE VIEW [dbo].VRSettingRule
/*
	Created: 20210428@Eden
	Task : VR Engine
	DB: DBACC-bodb02
	Original:

	Revisions:  
	- 20210428@Eden: First commit [Redmine:#136423]

	Parameter explanation:
*/
AS
	SELECT *
	FROM DBCUST.CUSTDB.dbo.VRSettingRule WITH(NOLOCK)
GO