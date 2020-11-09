/*
	Created: 20201104@Johnson
	Task: Initial setting mapping for product/sub-product/bettype..
	DB: DBCRM/bodb_CRM
*/

INSERT INTO crmSettingMapping(SettingID,SettingSource)
SELECT 46001, 'Virtual Sports' --product
UNION ALL SELECT 46001, 'Virtual Sports 2'
UNION ALL SELECT 8056, 'Virtual Soccer' --sub-product
UNION ALL SELECT 9063,	'Next Combo'--bettype