/*
	Created by: Eden
	Date: 2019-07-24
	Task: Hide Bullfighting, Lucky 3, Porkergame
	DB: DBCust/CustDB
*/ 
-------------------------------------------------
--> Hide Bullfighting, Lucky 3, Porkergame
UPDATE ProductSettingDetail 
SET SettingStatus = 2 --Hide
WHERE ProductID IN(26,30,33)