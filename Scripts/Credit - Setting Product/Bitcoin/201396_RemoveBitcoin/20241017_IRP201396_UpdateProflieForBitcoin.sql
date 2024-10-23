/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20241017@Johnson
	Task: Update Profile for bitcoin [redmine: #201396]
	DB: DBCUST/CUSTDB
*/

UPDATE ProductSettingProfile WITH(ROWLOCK)
SET SettingStatus = 2
WHERE SportType = 175

UPDATE ProductSettingProfile_UAT  WITH(ROWLOCK)
SET SettingStatus = 2
WHERE SportType = 175
