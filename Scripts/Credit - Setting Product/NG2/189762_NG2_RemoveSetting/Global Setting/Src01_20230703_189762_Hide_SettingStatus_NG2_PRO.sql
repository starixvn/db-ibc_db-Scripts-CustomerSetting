/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20230703
	Task: NG2 - Remove Setting - PRO
		https://nexdev.net/issues/189762
	DB: DBCust/CustDB
*/ 
-------------------------------------------------
UPDATE ProductSettingDetail 
SET SettingStatus = 2 
WHERE ProductID=23
	  AND SettingStatus <> 2