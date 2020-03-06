/*
	Created: 20200305@Eden
	Task: Add more columns for VRSettingHierarchy table
	RM: #128749
	DB: DBCUST/CustDB
*/

USE CustDB
ALTER TABLE VRSettingHierarchy ADD VRAutoSuspendThresholdNonLive smallmoney
ALTER TABLE VRSettingHierarchy ADD VRAutoSuspendThresholdLive smallmoney