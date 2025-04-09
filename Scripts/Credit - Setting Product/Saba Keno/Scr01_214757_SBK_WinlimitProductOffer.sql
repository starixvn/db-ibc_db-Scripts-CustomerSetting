/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: 20241213@Virgil
	Task: SABA Keno - Implement Setting and Initial data [RedmineID: #214757]
	DB: DBTXN-bodb02
*/

USE bodb02
GO

DECLARE @ProductID TINYINT = 102,
		@Bettype SMALLINT = 4601;	-- Representative Bettype


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
	VALUES (@ProductID, @Bettype, 1, 0)
END
