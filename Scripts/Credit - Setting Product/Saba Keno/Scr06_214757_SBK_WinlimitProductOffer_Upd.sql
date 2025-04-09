/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: 20250107@Virgil
	Task: SABA Keno - Implement Setting and Initial data [RedmineID: #214757]
	DB: DBTXN-bodb02
	Description: Update ProductID 102
*/

USE bodb02
GO

DECLARE @OldProductID TINYINT = 82,
		@NewProductID TINYINT = 102,
		@Bettype SMALLINT = 4601;	-- Representative Bettype


IF EXISTS (
	SELECT TOP 1 1
	FROM WinLimit_ProductOffer WITH (NOLOCK)
	WHERE ProductID = @OldProductID AND BetType = @Bettype
)
BEGIN
	UPDATE p 
	SET p.ProductID = @NewProductID
	FROM WinLimit_ProductOffer p WITH (ROWLOCK, UPDLOCK)
	WHERE ProductID = @OldProductID AND BetType = @Bettype
END

