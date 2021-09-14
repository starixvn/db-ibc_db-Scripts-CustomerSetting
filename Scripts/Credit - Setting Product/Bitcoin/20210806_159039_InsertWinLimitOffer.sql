/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: Winfred
	Date: 20210806
	Task: Insert product profile for Bitcoin RedmineID:#159039
	DB: DBTXN/bodb02
*/

USE bodb02
GO
DECLARE @ProductID TINYINT = 69 , @Bettype SMALLINT = 7901 
IF EXISTS (SELECT 1 FROM Winlimit_ProductOffer W WITH (NOLOCK) WHERE W.ProductID = @ProductID AND W.BetType = @Bettype)
	UPDATE W
	SET W.IsActive_SMA = 1 , W.IsActive_Company = 1
	FROM Winlimit_ProductOffer W WITH (ROWLOCK, UPDLOCK)
	WHERE W.ProductID = @ProductID AND W.BetType = @Bettype
ELSE
	INSERT INTO	dbo.WinLimit_ProductOffer (ProductID, BetType, IsActive_SMA, IsActive_Company)       
	VALUES	(@ProductID, @Bettype, 1, 1)



