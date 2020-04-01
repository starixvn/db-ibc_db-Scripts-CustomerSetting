/*
	Created: 20200318@Elodie
	Task: Insert product profile for Saba.club
	DB: DBTXN/bodb02
*/

USE bodb02
GO

INSERT INTO	dbo.WinLimit_ProductOffer (ProductID, BetType, IsActive_SMA, IsActive_Company)       
VALUES	(40, 4901, 1, 0)

--DELETE WinLimit_ProductOffer WHERE BetType = 4901



