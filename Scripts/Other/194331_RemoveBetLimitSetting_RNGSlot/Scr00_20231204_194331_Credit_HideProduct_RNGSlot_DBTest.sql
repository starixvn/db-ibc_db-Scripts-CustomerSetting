/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20231204
	Task: Hide RNG slot products - PRO
		https://nexdev.net/issues/194331
	DB: DBCust-CustDB
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
GO