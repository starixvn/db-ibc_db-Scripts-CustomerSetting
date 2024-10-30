/*<info serverAlias="dbtxn-bodb02"></info>*/
/*
	Created: 20241030@Virgil
	Task: Virtual Sports 6 (Betby) - Integrate New Product [Redmine: #212562]
	DB: dbtxn-bodb02
*/

USE bodb02
GO

IF NOT EXISTS (SELECT 1 FROM WinLimit_ProductOffer  WHERE BetType = 1201 AND ProductID = 71)
BEGIN 
	-- [WinLimit_ProductOffer]
	INSERT INTO [WinLimit_ProductOffer] ([ProductID], [BetType], [IsActive_SMA], [IsActive_Company])
	VALUES 
	  (71, 1201, 0, 0)
END

