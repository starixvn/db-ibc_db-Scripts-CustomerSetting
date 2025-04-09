/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20241218@Virgil
	Task: SABA Keno - Implement Setting and Initial data [RedmineID: #214757]
	DB: DBCUST-CustDB
	Description: Update ProductID 102
*/

USE CustDB
GO

DECLARE @OldProductID TINYINT = 82,
		@NewProductID TINYINT = 102,
		@Sporttype SMALLINT = 133,
		@Bettype SMALLINT = 12300;	-- Representative Bettype


IF EXISTS (
	SELECT TOP 1 *
	FROM SportNonOfferedSiteCurrency WITH (NOLOCK)
	WHERE RealProductID = @OldProductID AND BetType = @Bettype
)
BEGIN
	UPDATE p 
	SET p.RealProductID = @NewProductID,
		p.RepUpdateTime = SYSDATETIME()
	FROM SportNonOfferedSiteCurrency p WITH (ROWLOCK, UPDLOCK)
	WHERE RealProductID = @OldProductID 
		AND SportType = @Sporttype
		AND BetType = @Bettype
END
