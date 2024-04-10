/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: Luke
	Date: 20240229
	Task: UUSlots - Integrate New Product - Implement Customer setting , Initial Setting [Redmine: #192601]
	DB: DBTXN/bodb02
*/
DECLARE @ProductID SMALLINT = 78,
		@BetType SMALLINT = 10000

IF EXISTS (
	SELECT TOP 1 1
	FROM WinLimit_ProductOffer WITH (NOLOCK)
	WHERE ProductID = @ProductID AND BetType = @BetType
)
BEGIN
	UPDATE p 
	SET p.IsActive_SMA = 1
	FROM WinLimit_ProductOffer p WITH (ROWLOCK, UPDLOCK)
	WHERE ProductID = @ProductID AND BetType = @BetType
END
ELSE
BEGIN
	INSERT INTO WinLimit_ProductOffer(ProductID, BetType, IsActive_SMA, IsActive_Company)
	VALUES
		(@ProductID, @BetType, 1, 1)
END