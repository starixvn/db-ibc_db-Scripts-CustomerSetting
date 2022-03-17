/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20220317@Johnson
	Task: extend data length for crmSettingMapping.SettingSource
	DB: DBCRM/bodb_CRM
*/

ALTER TABLE crmSettingMapping ALTER COLUMN SettingSource VARCHAR(500)