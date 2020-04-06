/*
	Created: 20200406@Elodie
	Task: Insert product profile for BBIN
	DB: DBTXN/bodb02
*/

USE bodb02
GO

INSERT INTO	dbo.WinLimit_ProductOffer (ProductID, BetType, IsActive_SMA, IsActive_Company)       
VALUES	(47, 3300, 1, 0)

--DELETE WinLimit_ProductOffer WHERE BetType = 4901



