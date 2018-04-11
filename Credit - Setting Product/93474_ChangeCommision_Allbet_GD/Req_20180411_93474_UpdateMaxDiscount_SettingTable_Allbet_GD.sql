/*
	Created: Elodie
	Task: Update commission - Remine: https://nexdev.net/issues/93474
	DB: DBCUST/CustDB
	Date: 20180411	
*/ 

UPDATE GS
	SET Maxsdiscount = 0.01
FROM ProductGlobalSetting gs  (rowlock)
WHERE sporttype = 255 AND bettype = 1701

UPDATE T
	SET MaxDiscount = 0.01
FROM ProductSettingDetail T (rowlock)
WHERE ProductID = 21 AND BetType = 2401 AND SettingType = 3