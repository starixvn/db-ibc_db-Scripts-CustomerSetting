/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: 202409009@Virgil
	Task:  ON Casino - Implement customer setting [RedmineID: #210025]
	DB: DBTXN-bodb02
*/

USE bodb02
GO

DECLARE @ProductID	TINYINT	= 96,
		@Bettype	SMALLINT= 11850;


IF EXISTS (
	SELECT TOP 1 1
	FROM WinLimit_ProductOffer WITH (NOLOCK)
	WHERE ProductID = @ProductID AND BetType = @Bettype
)
BEGIN
	UPDATE p 
	SET p.IsActive_SMA = 1
	FROM WinLimit_ProductOffer p WITH (ROWLOCK, UPDLOCK)
	WHERE ProductID = @ProductID AND BetType = @Bettype
END
ELSE
BEGIN
	INSERT INTO WinLimit_ProductOffer(ProductID, BetType, IsActive_SMA, IsActive_Company)
	VALUES
		(@ProductID, @Bettype, 1, 0)
END
