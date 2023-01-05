/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: 20230105@Johnson    
    Task : data patch for VR E-Sports settings [redmine:#177594]
    DB: DBCUST/CustDB
*/

UPDATE VRSettingHierarchy WITH(ROWLOCK) 
SET VRAutoSuspendThresholdNonLive = 1,
	VRAutoSuspendThresholdLive = 1
where VRLeagueGroupID >= 45 
	AND SportType = 43