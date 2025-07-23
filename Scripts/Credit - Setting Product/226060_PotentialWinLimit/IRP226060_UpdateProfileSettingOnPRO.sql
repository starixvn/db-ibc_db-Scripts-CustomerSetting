/*<info serverAlias="DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250527@Johnson	
	Task: update profile setting for Potential Winning Limit/Threshold on PRO [redmine:#226060]
	DB: DBCUST-CustDB
*/
/*
UPDATE ProductSettingProfile WITH (ROWLOCK)
SET SettingStatus = 0,
    RepUpdateTime = SYSDATETIME()
WHERE ProductSettingID = 383
*/
    
UPDATE ProductSettingProfile WITH (ROWLOCK)
SET OfferType = 1,
    RepUpdateTime = SYSDATETIME()
WHERE ProductSettingID = 383	