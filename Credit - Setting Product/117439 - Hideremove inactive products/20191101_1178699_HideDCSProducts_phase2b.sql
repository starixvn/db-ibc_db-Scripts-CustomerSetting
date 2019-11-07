/*
	Created by: Eden
	Date: 2019-11-01
	Task: Hide inactive products : Lucky 3,Poker Games,Bullfighting,IMBC Cricket,Cockfighting
	DB: DBCust/CustDB
*/ 
-------------------------------------------------
--> Hide Bullfighting, Lucky 3, Porkergame
UPDATE ProductSettingDetail 
SET SettingStatus = 2 --Hide
WHERE SportType IN(160,163,207,50,206) --Lucky 3,Poker Games,Bullfighting,IMBC Cricket,Cockfighting
	  AND SettingStatus <> 2 