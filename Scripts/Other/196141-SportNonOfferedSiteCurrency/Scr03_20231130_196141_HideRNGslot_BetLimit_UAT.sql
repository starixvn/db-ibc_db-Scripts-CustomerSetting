/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20231130
	Task: Hide RNG slot products - UAT
		https://nexdev.net/issues/196141
	DB: DBCust/CustDB
*/ 
-------------------------------------------------
USE CustDB
GO

--ProductSettingDetail_UAT
UPDATE psd
SET SettingStatus=2
FROM ProductSettingDetail_UAT psd WITH (ROWLOCK, UPDLOCK)
WHERE SettingType=8 AND ProductID=18
AND SettingStatus <> 2

--ProductSettingProfile_UAT
UPDATE psd
SET SettingStatus=2, CreationStatus=2
FROM ProductSettingProfile_UAT psd WITH (ROWLOCK, UPDLOCK)
WHERE SettingType=8 AND ProductID=18
AND (SettingStatus <> 2 OR CreationStatus<>2)