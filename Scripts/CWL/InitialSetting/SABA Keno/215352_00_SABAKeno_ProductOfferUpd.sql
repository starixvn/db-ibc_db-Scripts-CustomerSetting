/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator: 20241216@Virgil
	Task: CWL - SABA Keno - Integrate New Product [Redmine: #214760]
	Database: DBTXN/bodb02
*/
USE bodb02
GO

DECLARE	@ProductID TINYINT = 102, 
		@RepresentativeBettype SMALLINT = 4601;

IF EXISTS ( SELECT TOP 1 1
				FROM dbo.WinLimit_ProductOffer WITH(NOLOCK)
				WHERE ProductID = @ProductID
					AND BetType = 12300
			)
BEGIN
	UPDATE p
	SET p.BetType = @RepresentativeBettype
	FROM dbo.WinLimit_ProductOffer p WITH (ROWLOCK, UPDLOCK)
	WHERE p.ProductID = @ProductID
		AND BetType = 12300
END