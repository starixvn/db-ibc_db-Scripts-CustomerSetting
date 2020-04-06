/*
	Created: 20200406@Eden
	Task: Drop column VRAutoSuspendThreshold for VRSettingHierarchy table 
	RM: #128749
	DB: DBCUST/CustDB and CustDB_CustSetting publication
*/

USE CustDB
ALTER TABLE VRSettingHierarchy DROP COLUMN VRAutoSuspendThreshold
GO