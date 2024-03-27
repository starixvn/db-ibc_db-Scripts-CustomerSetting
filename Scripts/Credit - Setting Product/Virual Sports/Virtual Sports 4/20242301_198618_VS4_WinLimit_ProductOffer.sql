/*<info serverAlias="dbtxn-bodb02"></info>*/
/*
	Created: Tacy@20240123 
	Task: Virtual Sports 4 - Integrate New Product [redmine: #198618]
	DB: dbtxn-bodb02
*/

USE bodb02
GO

IF NOT EXISTS (SELECT 1 FROM WinLimit_ProductOffer  WHERE BetType = 1201 AND ProductID = 83)
BEGIN 
	-- [WinLimit_ProductOffer]
	INSERT INTO [WinLimit_ProductOffer] ([ProductID], [BetType], [IsActive_SMA], [IsActive_Company])
	VALUES 
	  (83, 1201, 1, 0)
END
ELSE IF EXISTS (SELECT 1 FROM WinLimit_ProductOffer  WHERE BetType = 1201 AND ProductID = 83 AND IsActive_SMA = 0)
BEGIN
	UPDATE [WinLimit_ProductOffer]
	SET IsActive_SMA = 1
	WHERE BetType = 1201 AND ProductID = 83 AND IsActive_SMA = 0
END
