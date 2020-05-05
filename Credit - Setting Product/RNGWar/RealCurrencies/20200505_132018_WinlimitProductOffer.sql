/*
	Created: Tiara
	Date: 20200505
	Task: Insert Winlimit_ProductOffer for RNG War  [Redmine: 132018]
	DB: DBTXN/bodb02
*/
USE bodb02
GO

DECLARE @ProductID TINYINT = 50 , @Bettype SMALLINT = 5500
IF EXISTS (SELECT 1 FROM Winlimit_ProductOffer W WITH (NOLOCK) WHERE W.ProductID = @ProductID AND W.BetType = @Bettype)
	UPDATE W
	SET W.IsActive_SMA = 1
	FROM Winlimit_ProductOffer W WITH (ROWLOCK, UPDLOCK)
	WHERE W.ProductID = @ProductID AND W.BetType = @Bettype
ELSE
	INSERT INTO	dbo.WinLimit_ProductOffer (ProductID, BetType, IsActive_SMA, IsActive_Company)       
	VALUES	(@ProductID, @Bettype, 1, 0)


