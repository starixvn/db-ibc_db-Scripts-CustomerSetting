/*
	Created: 20201109@Johnson
	Task: update communication tool = 'Any' for current users
	DB: DBCRM/bodb_CRM
*/

--234 rows affect
UPDATE crmDefaultCommTool WITH(UPDLOCK,ROWLOCK)
SET SettingID = 0
WHERE SettingType = 2
	AND custid > 0