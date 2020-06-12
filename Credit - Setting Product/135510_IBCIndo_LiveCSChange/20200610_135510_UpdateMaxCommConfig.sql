/*
	Created by: Elodie
	Date: 20200611
	Task: Update max comm config
	DB: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE ps 
SET MaxDiscount = 0.00700000
FROM ProductSettingDetail ps WITH (ROWLOCK)
WHERE ProductId = 41 AND sporttype = 242 AND SettingType = 3