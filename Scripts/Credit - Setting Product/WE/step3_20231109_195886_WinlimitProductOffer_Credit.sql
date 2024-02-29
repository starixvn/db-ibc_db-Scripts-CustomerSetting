/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: Luke
	Date: 20231109
	Task:  WE Live Casino - Implement customer setting [RedmineID: #195886]
	DB: DBTXN/bodb02
*/
USE bodb02
GO

IF EXISTS (
	SELECT TOP 1 1
	FROM WinLimit_ProductOffer WITH (NOLOCK)
	WHERE ProductID = 80 AND BetType = 10300
)
BEGIN
	UPDATE p 
	SET p.IsActive_SMA = 1
	FROM WinLimit_ProductOffer p WITH (ROWLOCK, UPDLOCK)
	WHERE ProductID = 80 AND BetType = 10300
END
ELSE
BEGIN
	INSERT INTO WinLimit_ProductOffer(ProductID, BetType, IsActive_SMA, IsActive_Company)
	VALUES
		(80, 10300, 1, 1)
END

