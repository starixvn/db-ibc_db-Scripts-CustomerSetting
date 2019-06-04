
/*
	Date: 2019-05-31
	Created: Winnie
	Task: Delete unused status for CN88  #112637
	DB: DBCRM/bodb_CRM
*/

DELETE
FROM crmSetting
WHERE SettingValue IN('KIV', 'Claimed', 'Expired', 'Cancelled')
AND SiteOffer=1