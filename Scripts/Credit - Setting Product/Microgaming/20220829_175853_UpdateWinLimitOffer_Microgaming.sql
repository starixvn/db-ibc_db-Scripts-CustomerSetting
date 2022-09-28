/*<info serverAlias="dbtxn-bodb02"></info>*/
/*
	Created: 20220829@Tacy
	Task: UPDATE WinLimit_ProductOffer for Microgaming [redmine:#175853]
	DB: dbtxn/bodb02
*/
-- [WinLimit_ProductOffer]
UPDATE [WinLimit_ProductOffer]
SET [IsActive_SMA]=1
WHERE [ProductID]=73 AND [BetType]=8400
