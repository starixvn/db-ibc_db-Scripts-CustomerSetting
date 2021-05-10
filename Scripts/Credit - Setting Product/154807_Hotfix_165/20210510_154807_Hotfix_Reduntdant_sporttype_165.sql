/*
    Created: 20210508@Helen
	Task: https://nexdev.net/issues/154807 - Redundant settingtype 13 for sporttype 165 in ProductSettingDetail table
	DB: bodb02 for all replicated servers below 
		db04Admin1
		db04Admin2
		db05
		db052
		db053
		db055
		db05bk1
*/
USE bodb02
GO
DELETE psd
FROM ProductSettingDetail psd WITH (ROWLOCK)
WHERE sporttype = 165 AND SettingType = 13 AND bettype = 1901 AND ProductID = 33
GO