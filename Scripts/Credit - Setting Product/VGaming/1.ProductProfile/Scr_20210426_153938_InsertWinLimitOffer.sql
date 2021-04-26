/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: 20210426@Eden
	Task: Insert WinLimit_ProductOffer for VGaming [#RM:153938]
	DB: DBTXN/bodb02
*/
USE bodb02
GO
DECLARE @ProductID tinyint = 66, @Bettype INT = 3801

IF EXISTS( SELECT 1 FROM WinLimit_ProductOffer WITH(NOLOCK) WHERE ProductId = @ProductID AND Bettype = @Bettype)
	UPDATE WinLimit_ProductOffer WITH(ROWLOCK)
	SET  IsActive_SMA = 1
	WHERE ProductId = @ProductID AND Bettype = @Bettype

ELSE
	INSERT INTO dbo.WinLimit_ProductOffer(
		  ProductID
		, Bettype
		, IsActive_SMA
		, IsActive_Company
	)
	SELECT @ProductID AS ProductId
		, @Bettype AS BetType
		, 1 AS IsActive_SMA
		, 0 AS IsActive_Company


--SELECT * FROM WinLimit_ProductOffer WITH(NOLOCK) WHERE ProductId = 66 AND Bettype = 3801
