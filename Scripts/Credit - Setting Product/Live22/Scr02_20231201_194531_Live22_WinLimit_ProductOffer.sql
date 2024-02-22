/*<info serverAlias="dbtxn-bodb02"></info>*/
/*
	Created: Tacy@20231201 
	Task: Live22 - Integrate New Product [redmine: #194531]
	DB: dbtxn-bodb02
*/

use bodb02

IF NOT EXISTS (SELECT 1 FROM WinLimit_ProductOffer  WHERE BetType = 7601 AND ProductID = 79)
BEGIN 
	-- [WinLimit_ProductOffer]
	INSERT INTO [WinLimit_ProductOffer] ([ProductID], [BetType], [IsActive_SMA], [IsActive_Company])
	VALUES 
	  ( 79, 7601, 1, 0)
END
ELSE IF EXISTS (SELECT 1 FROM WinLimit_ProductOffer  WHERE BetType = 7601 AND ProductID = 79 AND IsActive_SMA = 0)
BEGIN
	UPDATE [WinLimit_ProductOffer]
	SET IsActive_SMA = 1
	WHERE BetType = 7601 AND ProductID = 79 AND IsActive_SMA = 0
END
