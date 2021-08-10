/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 2021810@Johnson
	Task: delete un-used settings in crm
	DB: DBCRM/bodb_CRM
*/
	--select * from crmSetting where SettingValue in ('i228bet','mymbet')

DELETE crmSetting WITH(UPDLOCK) WHERE SettingID IN (6258,6293)

DELETE crmSettingRelation WITH(UPDLOCK) WHERE SettingID IN (6258,6293)