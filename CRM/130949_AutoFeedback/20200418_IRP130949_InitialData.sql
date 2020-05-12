/*
	Created: 20200418@@Johnson
	Task : Initial data for system setting for auto feedback[redmine:#130949]
	DB: DBCRM/bodb_CRM	
*/

INSERT INTO SystemSetting(SettingName, Value)
SELECT 'JobStatus','Completed'
UNION SELECT 'BatchSize','10'
UNION SELECT 'LastMsgID','942192'
UNION SELECT 'ConfigUAT','1'
UNION SELECT 'ConfigPRO','0'