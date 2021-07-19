/*
	Created: 20200121@Eden
	Task: Update VRAutoSuspendThreshold of VRSettingHierarchy
	RM: #121876
	DB: DBCUST/CustDB
*/

UPDATE a 
SET VRAutoSuspendThreshold = 1.00
FROM VRSettingHierarchy a WITH(ROWLOCK)
WHERE SportType = 43