/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: Johnson
	Date: 20220222
	Task: UPDATE global setting for WinLimit_ProductOffer for FGG
	DB: DBTXN/bodb02
*/

UPDATE ps
SET ps.IsActive_SMA = 1
FROM dbo.WinLimit_ProductOffer ps WITH(ROWLOCK)
WHERE ProductID = 70