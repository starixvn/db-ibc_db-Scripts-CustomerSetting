/*<info serverAlias="dbtxn-bodb02"></info>*/
/*
	Created: 20230116@Helios
	Task: Insert new Product profile for Jili Games [redmine:#182869]
	DB: dbtxn/bodb02
*/

-- [WinLimit_ProductOffer]
INSERT INTO [WinLimit_ProductOffer] ([ProductID], [BetType], [IsActive_SMA], [IsActive_Company])
VALUES 
  ( 75, 5100, 1, 0)