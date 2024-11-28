/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: 20240708@Tacy
	Task: VS5 - Incorporate new product [RM:#207587]
	DB: DBTXN-bodb02
*/
USE bodb02
GO

DECLARE @ProductID TINYINT = 88
		,@BetType SMALLINT = 1201

IF NOT EXISTS (SELECT 1 FROM WinLimit_ProductOffer  WHERE ProductID = @ProductID)
BEGIN 
	INSERT INTO [WinLimit_ProductOffer] ([ProductID], [BetType], [IsActive_SMA], [IsActive_Company])
	VALUES 
	  ( @ProductID, @BetType, 1, 0)
END
ELSE IF EXISTS (SELECT 1 FROM WinLimit_ProductOffer  WHERE BetType = @BetType AND ProductID = @ProductID AND IsActive_SMA = 0)
BEGIN
	UPDATE [WinLimit_ProductOffer]
	SET IsActive_SMA = 1
	WHERE BetType = @BetType AND ProductID = @ProductID AND IsActive_SMA = 0
END
GO
