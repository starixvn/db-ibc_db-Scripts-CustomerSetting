/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20230928
	Task: Credit - Hide inactive products : GDG, Fishing World on UAT
		https://nexdev.net/issues/174511
	DB: DBCust/CustDB
*/ 
-------------------------------------------------
--> Hide GDG, Fishing World
UPDATE ProductSettingDetail_UAT
SET SettingStatus = 2 --Hide
WHERE SportType IN (236,219) --GDG, Fishing World
	  AND SettingStatus <> 2
