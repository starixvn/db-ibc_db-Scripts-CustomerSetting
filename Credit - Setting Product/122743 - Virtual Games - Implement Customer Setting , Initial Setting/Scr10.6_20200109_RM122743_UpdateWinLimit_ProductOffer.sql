/*
	Created: Eden
	Date: 20200309
	Task: Update WinLimit_ProductOffer IsActive_SMA = 1
	DB: DBTXN/bodb02
*/
USE bodb02
GO
IF EXISTS( SELECT 1 FROM WinLimit_ProductOffer WITH(NOLOCK) WHERE ProductId = 38 AND BettypeID = 4601)
	UPDATE WinLimit_ProductOffer WITH(ROWLOCK)
	SET  IsActive_SMA = 1
	WHERE ProductId = 38 AND BettypeID = 4601

ELSE
INSERT INTO dbo.WinLimit_ProductOffer(
	  ProductID
	, Bettype
	, IsActive_SMA
	, IsActive_Company
)
SELECT 38 AS ProductId
	, 4601 AS BetType
	, 1 AS IsActive_SMA
	, 1 AS IsActive_Company