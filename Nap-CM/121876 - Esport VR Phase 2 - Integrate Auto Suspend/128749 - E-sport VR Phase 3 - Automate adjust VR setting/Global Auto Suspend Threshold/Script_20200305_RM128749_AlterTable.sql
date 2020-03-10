/*
	Created: 20200310@Eden
	Task: ALTER TABLE VRSettingHierarchy 
	RM: #128749
	DB: DBCUST/CustDB and CustDB_CustSetting publication
*/

ALTER TABLE VRSettingHierarchy ADD VRAutoSuspendThresholdNonLive smallmoney
ALTER TABLE VRSettingHierarchy ADD VRAutoSuspendThresholdLive smallmoney
GO