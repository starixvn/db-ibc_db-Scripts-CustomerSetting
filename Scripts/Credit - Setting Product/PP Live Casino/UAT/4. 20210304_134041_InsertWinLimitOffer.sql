/*
	Created: 20210304@Tina
	Task: Insert product profile for PP Live Casino
	DB: DBTXN/bodb02
*/

USE bodb02
GO
DECLARE @ProductID TINYINT = 65 , @Bettype SMALLINT = 3701
IF EXISTS (SELECT 1 FROM Winlimit_ProductOffer W WITH (NOLOCK) WHERE W.ProductID = @ProductID AND W.BetType = @Bettype)
	UPDATE W
	SET W.IsActive_SMA = 1
	FROM Winlimit_ProductOffer W WITH (ROWLOCK, UPDLOCK)
	WHERE W.ProductID = @ProductID AND W.BetType = @Bettype
ELSE
	INSERT INTO	dbo.WinLimit_ProductOffer (ProductID, BetType, IsActive_SMA, IsActive_Company)       
	VALUES	(@ProductID, @Bettype, 1, 0)

/*
SELECT *
FROM dbo.WinLimit_ProductOffer P WITH (NOLOCK)
WHERE P.ProductID = 65
*/
