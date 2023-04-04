/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20230317@Tacy
	Task: update ActionNameTH on table LogAction [redmine:#171247]
	DB: DBLOG.bodb_CustomerLog
*/
/*
	6100 - Created API key
	6101 - Edited API key
	6102 - Revoked API key
*/
UPDATE LogAction WITH (ROWLOCK, UPDLOCK)
SET [ActionNameTH] = CASE WHEN ActionID=6100 THEN N'API Key ถูกสร้าง' WHEN ActionID=6101 THEN N'API Key ถููกแก้ไข' ELSE N'API Key ถูกเพิกถอน' END
WHERE ActionID BETWEEN 6100 AND 6102