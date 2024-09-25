/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: @Helios
	Date: 03/05/2024
	Task: Inital Data WinLimit_ProductOffer  [#204358] 
	DB: DBTXN-bodb02
*/

SET ANSI_NULLS  ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT TOP 1 1 FROM WinLimit_ProductOffer WITH (NOLOCK) WHERE ProductID IN (3,5,8,28,40,63) AND IsActive_SMA = 0)
BEGIN
	UPDATE w SET 
		IsActive_SMA = 1
	FROM WinLimit_ProductOffer w WITH (ROWLOCK , UPDLOCK)
	WHERE ProductID IN (3,5,8,28,40,63)
	AND IsActive_SMA = 0
END
