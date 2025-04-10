/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: 20250314@Tacy
	Task: Funky Games - Incorporate new product [RM:#219766]
	DB: DBTXN-bodb02
*/
USE bodb02
GO

DECLARE @ProductID INT = 95

IF NOT EXISTS (SELECT 1 FROM WinLimit_ProductOffer  WHERE ProductID = @ProductID)
BEGIN 
	INSERT INTO [WinLimit_ProductOffer] ([ProductID], [BetType], [IsActive_SMA], [IsActive_Company])
	VALUES 
	  ( @ProductID, 4001, 1, 0)
END
ELSE IF EXISTS (SELECT 1 FROM WinLimit_ProductOffer  WHERE BetType = 4001 AND ProductID = @ProductID AND IsActive_SMA = 0)
BEGIN
	UPDATE [WinLimit_ProductOffer]
	SET IsActive_SMA = 1
	WHERE BetType = 4001 AND ProductID = @ProductID AND IsActive_SMA = 0
END
GO