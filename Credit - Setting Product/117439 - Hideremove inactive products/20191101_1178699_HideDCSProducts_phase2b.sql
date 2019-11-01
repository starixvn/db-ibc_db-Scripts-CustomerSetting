/*
	Created by: Eden
	Date: 2019-11-01
	Task: Cricket, Cockfighting
	DB: DBCust/CustDB
*/ 
-------------------------------------------------
--> Hide Bullfighting, Lucky 3, Porkergame
UPDATE ProductSettingDetail 
SET SettingStatus = 2 --Hide
WHERE SportType IN (50, 206) --Cricket, Cockfighting
