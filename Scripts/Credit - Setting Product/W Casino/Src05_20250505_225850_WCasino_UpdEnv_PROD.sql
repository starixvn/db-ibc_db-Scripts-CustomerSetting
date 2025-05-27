/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: Tacy@20250505
	Task: W Casino - Integrate new Live Casino product - Implement Setting and Initial data [RedmineID: #225850]
	DB: DBPRO-bodb02
*/
USE bodb02
GO

DECLARE @ProductID SMALLINT = 98

UPDATE p
SET p.Environment = 0, 
	RepUpdateTime = dbo.f_GetDateTime2()
FROM Products p WITH (ROWLOCK, UPDLOCK)
WHERE p.ProductID = @ProductID

GO
