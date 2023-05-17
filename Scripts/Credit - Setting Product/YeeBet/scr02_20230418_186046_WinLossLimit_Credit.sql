/*<info serverAlias="DBTRANS-bodb02"></info>*/
/*
	Created: Luke
	Date: 20230418
	Task:  Insert Win Loss Limit for YeeBet - Credit [RedmineID: #186046]
	DB: DBTRANS/bodb02
*/
USE bodb02
GO

DECLARE @ProductID SMALLINT,
		@Bettype SMALLINT
SET @ProductID = 76
SET @Bettype = 3151

IF EXISTS(
	SELECT 1
	FROM WinLimit_ProductOffer WITH (NOLOCK)
	WHERE ProductID = @ProductID AND bettype = @Bettype
)
BEGIN
	RAISERROR('This ProductID and BetType have been used.', 16, 1)
END
ELSE
BEGIN
	INSERT INTO WinLimit_ProductOffer(ProductID, BetType, IsActive_SMA, IsActive_Company)
	VALUES
	(@ProductID, @Bettype, 1, 1)
END