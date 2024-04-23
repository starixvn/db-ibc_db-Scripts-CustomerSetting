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

ALTER TABLE VRSettingRuleDetail_NotApply ADD CCSporttype	SMALLINT NOT NULL CONSTRAINT DF_VRSettingRuleDetail_NotApply_CCSporttype DEFAULT(0) WITH VALUES 
GO
