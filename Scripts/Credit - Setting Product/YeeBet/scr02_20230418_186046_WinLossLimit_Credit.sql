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

DELETE wp
FROM WinLimit_ProductOffer wp WITH (ROWLOCK)
WHERE wp.ProductID = @ProductID AND wp.Bettype = @Bettype

INSERT INTO WinLimit_ProductOffer(ProductID, BetType, IsActive_SMA, IsActive_Company)
VALUES
(@ProductID, @Bettype, 1, 1)
