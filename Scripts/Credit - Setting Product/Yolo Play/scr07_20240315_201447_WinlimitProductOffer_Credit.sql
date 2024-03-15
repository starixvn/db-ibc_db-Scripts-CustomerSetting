/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: Luke@20240315
	Task: Yolo Play - Implement customer setting - initial setting [Redmine: #201447]
	DB: DBTXN/bodb02
*/
DECLARE @ProductID SMALLINT = 84,
		@BetType_Old SMALLINT = 3650,
		@BetType_New SMALLINT = 4001

DELETE 
FROM WinLimit_ProductOffer WITH (ROWLOCK)
WHERE ProductID = @ProductID AND BetType = @BetType_Old

IF EXISTS (
	SELECT TOP 1 1
	FROM WinLimit_ProductOffer WITH (NOLOCK)
	WHERE ProductID = @ProductID AND BetType = @BetType_New
)
BEGIN
	UPDATE p 
	SET p.IsActive_SMA = 1
	FROM WinLimit_ProductOffer p WITH (ROWLOCK, UPDLOCK)
	WHERE ProductID = @ProductID AND BetType = @BetType_New
END
ELSE
BEGIN
	INSERT INTO WinLimit_ProductOffer(ProductID, BetType, IsActive_SMA, IsActive_Company)
	VALUES
		(@ProductID, @BetType_New, 1, 0)
END