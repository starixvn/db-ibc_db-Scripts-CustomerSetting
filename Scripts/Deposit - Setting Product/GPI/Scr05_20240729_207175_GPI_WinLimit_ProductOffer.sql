/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: 20240729@Tacy
	Task: GPI - Incorporate new product [RM:#207175]
	DB: DBTXN-bodb02
*/
USE bodb02
GO

DECLARE  @ProductID	SMALLINT = 48
		,@RepresentativeBettype SMALLINT = 4001

IF NOT EXISTS (SELECT 1 FROM WinLimit_ProductOffer  WHERE ProductID = @ProductID)
BEGIN 
	INSERT INTO [WinLimit_ProductOffer] ([ProductID], [BetType], [IsActive_SMA], [IsActive_Company])
	VALUES 
	  ( @ProductID, @RepresentativeBettype, 1, 0)
END
ELSE IF EXISTS (SELECT 1 FROM WinLimit_ProductOffer  WHERE BetType = @RepresentativeBettype AND ProductID = @ProductID AND IsActive_SMA = 0)
BEGIN
	UPDATE [WinLimit_ProductOffer]
	SET IsActive_SMA = 1
	WHERE BetType = @RepresentativeBettype AND ProductID = @ProductID AND IsActive_SMA = 0
END
GO