/*
	Created: Eden
	Date: 20200226
	Task: UPDATE global setting in WinLimit_ProductOffer
	DB: DBTXN/bodb02
*/

USE bodb02
GO

UPDATE ps
SET ps.isActive_SMA = 1
FROM dbo.WinLimit_ProductOffer ps WITH(ROWLOCK,UPDLOCK)
WHERE ProductID IN (38,39)

