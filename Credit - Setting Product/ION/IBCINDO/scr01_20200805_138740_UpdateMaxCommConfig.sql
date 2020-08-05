/*
	Created by: Elodie
	Date: 20200805
	Task: Update max comm config
	DB: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE ps 
SET MaxDiscount = 0.00800000
FROM ProductSettingDetail ps WITH (ROWLOCK)
WHERE ProductId = 41 AND sporttype = 225 AND SettingType = 3