/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20231130
	Task: Hide RNG slot products - PRO
		https://nexdev.net/issues/196141
	DB: DBCust/CustDB
*/ 
-------------------------------------------------
USE CustDB
GO

--ProductSettingDetail
UPDATE psd
SET SettingStatus=2
FROM ProductSettingDetail psd WITH (ROWLOCK, UPDLOCK)
WHERE SettingType=8 AND ProductID=18
AND SettingStatus <> 2

--ProductSettingProfile
UPDATE psd
SET SettingStatus=2, CreationStatus=2
FROM ProductSettingProfile psd WITH (ROWLOCK, UPDLOCK)
WHERE SettingType=8 AND ProductID=18
AND (SettingStatus <> 2 OR CreationStatus<>2)