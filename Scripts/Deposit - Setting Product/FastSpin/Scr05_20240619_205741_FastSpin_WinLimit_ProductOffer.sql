/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: 20240619@Tacy
	Task: FastSpin - Incorporate new product [RM:#205741]
	DB: DBTXN-bodb02
*/
USE bodb02
GO

IF NOT EXISTS (SELECT 1 FROM WinLimit_ProductOffer  WHERE ProductID = 87)
BEGIN 
	INSERT INTO [WinLimit_ProductOffer] ([ProductID], [BetType], [IsActive_SMA], [IsActive_Company])
	VALUES 
	  ( 87, 4001, 1, 0)
END
ELSE IF EXISTS (SELECT 1 FROM WinLimit_ProductOffer  WHERE BetType = 4001 AND ProductID = 87 AND IsActive_SMA = 0)
BEGIN
	UPDATE [WinLimit_ProductOffer]
	SET IsActive_SMA = 1
	WHERE BetType = 4001 AND ProductID = 87 AND IsActive_SMA = 0
END
GO