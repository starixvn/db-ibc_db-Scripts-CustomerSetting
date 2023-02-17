/*<info serverAlias="dbtxn-bodb02"></info>*/
/*
	Created: 20230116@Helios
	Task: Insert new Product profile for Jili Games [redmine:#182869]
	DB: dbtxn/bodb02
*/


DELETE [WinLimit_ProductOffer] WITH(ROWLOCK) WHERE [ProductID] = 75 AND [BetType] = 5100 and [IsActive_SMA] = 1


-- [WinLimit_ProductOffer]
INSERT INTO [WinLimit_ProductOffer] ([ProductID], [BetType], [IsActive_SMA], [IsActive_Company])
VALUES 
  ( 75, 4001, 1, 0)