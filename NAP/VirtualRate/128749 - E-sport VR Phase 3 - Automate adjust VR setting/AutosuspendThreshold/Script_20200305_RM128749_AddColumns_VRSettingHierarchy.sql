/*
	Created: 20200305@Eden
	Task: Add more columns for VRSettingHierarchy table 
	RM: #128749
	DB: DBCUST/CustDB and CustDB_CustSetting publication
*/

USE CustDB
ALTER TABLE VRSettingHierarchy ADD VRAutoSuspendThresholdNonLive smallmoney
ALTER TABLE VRSettingHierarchy ADD VRAutoSuspendThresholdLive smallmoney

UPDATE VRSettingHierarchy WITH(ROWLOCK)
SET VRAutoSuspendThresholdNonLive = 1.00,
	VRAutoSuspendThresholdLive = 1.00
WHERE SportType = 43