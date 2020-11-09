/*
	Created: 20201109@Johnson
	Task: update communication tool for sub-catergory = 'Any' for current users
	DB: DBCRM/bodb_CRM
*/

--234 rows affect
UPDATE crmDefaultCommTool WITH(UPDLOCK,ROWLOCK)
SET SettingID = 0 --any
WHERE SettingType = 2--sub-catergory
	AND custid > 0 --exclude all-licensee