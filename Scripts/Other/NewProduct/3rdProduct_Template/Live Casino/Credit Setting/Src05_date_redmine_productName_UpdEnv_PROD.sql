/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: {Nickname}@{date}
	Task: {ProductName} - Integrate new Live Casino product - Implement Setting and Initial data [RedmineID: #xxx]
	DB: DBPRO-bodb02
*/
USE bodb02
GO

DECLARE @ProductID SMALLINT = {ProductID}

UPDATE p
SET p.Environment = 0, 
	RepUpdateTime = dbo.f_GetDateTime2()
FROM Products p WITH (ROWLOCK, UPDLOCK)
WHERE p.ProductID = @ProductID

GO
