/*
	Created: Elodie
	Date: 20180917
	Task: Update Max Comm setting of Poker Games
	DB: DBCust/CustDB
*/

UPDATE ps
SET ps.MaxDiscount = 0.85
FROM dbo.ProductSettingDetail ps WITH (ROWLOCK)
WHERE ProductID = 33 AND SettingType = 3