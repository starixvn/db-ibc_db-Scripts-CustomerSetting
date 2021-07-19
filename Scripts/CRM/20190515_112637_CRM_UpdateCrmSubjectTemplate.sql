/*
	Created: 20190515@Winnie
	Task: Update crmSubjectTemplate RedmineID:#112637
	DB: DBCRM/bodb_crm
*/

UPDATE crmSubjectTemplate SET SiteOffer=2
GO

UPDATE crmSetting WITH(ROWLOCK,UPDLOCK)
	SET DisplayOrder=1
WHERE SettingID=7006

UPDATE crmSetting WITH(ROWLOCK,UPDLOCK)
	SET DisplayOrder=2
WHERE SettingID=7009

UPDATE crmSetting WITH(ROWLOCK,UPDLOCK)
	SET DisplayOrder=3
WHERE SettingID=7008

UPDATE crmSetting WITH(ROWLOCK,UPDLOCK)
	SET DisplayOrder=4
WHERE SettingID=7007

UPDATE crmSetting WITH(ROWLOCK,UPDLOCK)
	SET DisplayOrder=5
WHERE SettingID=7011

UPDATE crmSetting WITH(ROWLOCK,UPDLOCK)
	SET DisplayOrder=6
WHERE SettingID=7010