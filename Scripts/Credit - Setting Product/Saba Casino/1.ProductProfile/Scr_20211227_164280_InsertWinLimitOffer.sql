/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: 20211227@Eden
	Task: Insert product profile for Saba Casino [#164280]
	DB: DBTXN/bodb02
*/

USE bodb02
GO
DECLARE @ProductID TINYINT = 6 , @Bettype SMALLINT = 2101 
IF EXISTS (SELECT 1 FROM Winlimit_ProductOffer W WITH (NOLOCK) WHERE W.ProductID = @ProductID AND W.BetType = @Bettype)
	UPDATE W
	SET W.IsActive_SMA = 1 , W.IsActive_Company = 1
	FROM Winlimit_ProductOffer W WITH (ROWLOCK, UPDLOCK)
	WHERE W.ProductID = @ProductID AND W.BetType = @Bettype
ELSE
	INSERT INTO	dbo.WinLimit_ProductOffer (ProductID, BetType, IsActive_SMA, IsActive_Company)       
	VALUES	(@ProductID, @Bettype, 1, 1)

--SELECT * FROM Winlimit_ProductOffer(NOLOCK) WHERE PRODUCTID = 6





