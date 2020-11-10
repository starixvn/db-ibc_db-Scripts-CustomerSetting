/*
	Created: Winfred
	Date: 20200828
	Task: Insert product profile for WM [Redmine: 131589]
	DB: DBTXN/bodb02
*/

USE bodb02
GO
DECLARE @ProductID TINYINT = 51 , @Bettype SMALLINT = 3401 
IF EXISTS (SELECT 1 FROM Winlimit_ProductOffer W WITH (NOLOCK) WHERE W.ProductID = @ProductID AND W.BetType = @Bettype)
	UPDATE W
	SET W.IsActive_SMA = 1
	FROM Winlimit_ProductOffer W WITH (ROWLOCK, UPDLOCK)
	WHERE W.ProductID = @ProductID AND W.BetType = @Bettype
ELSE
	INSERT INTO	dbo.WinLimit_ProductOffer (ProductID, BetType, IsActive_SMA, IsActive_Company)       
	VALUES	(@ProductID, @Bettype, 1, 0)



