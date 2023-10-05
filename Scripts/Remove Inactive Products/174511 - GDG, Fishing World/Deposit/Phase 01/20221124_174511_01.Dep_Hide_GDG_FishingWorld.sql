/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20221124
	Task: Deposit - Hide inactive products : GDG, Fishing World
		https://nexdev.net/issues/174511
	DB: DBCust/CustDB
*/ 
-------------------------------------------------
--> Hide GDG, Fishing World
UPDATE Dep_ProductSettingDetail 
SET SettingStatus = 2 --Hide
WHERE SportType IN (236,219) --GDG, Fishing World
	  AND SettingStatus <> 2