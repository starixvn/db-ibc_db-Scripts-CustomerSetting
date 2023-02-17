/*<info serverAlias="dbtxn-bodb02"></info>*/
/*
	Created: 20230116@Helios
	Task: Insert new Product profile for Jili Games [redmine:#182869]
	DB: dbtxn/bodb02
*/

use bodb02

IF NOT EXISTS (SELECT 1 FROM WinLimit_ProductOffer  WHERE BetType = 4001 AND ProductID = 75)
BEGIN 
	-- [WinLimit_ProductOffer]
	INSERT INTO [WinLimit_ProductOffer] ([ProductID], [BetType], [IsActive_SMA], [IsActive_Company])
	VALUES 
	  ( 75, 4001, 1, 0)
END
ELSE IF EXISTS (SELECT 1 FROM WinLimit_ProductOffer  WHERE BetType = 4001 AND ProductID = 75 AND IsActive_SMA = 0)
BEGIN
	UPDATE [WinLimit_ProductOffer]
	SET IsActive_SMA = 1
	WHERE BetType = 4001 AND ProductID = 75 AND IsActive_SMA = 0
END
