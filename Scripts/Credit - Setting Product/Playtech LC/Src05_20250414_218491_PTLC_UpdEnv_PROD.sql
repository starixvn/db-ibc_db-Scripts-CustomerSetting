/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20250414@Tacy
	Task: Playtech Live - Integrate new Live Casino product - Implement Setting and Initial data [RedmineID: #218491]
	DB: DBPRO-bodb02
*/
USE bodb02
GO

UPDATE p
SET p.Environment = 0, 
	RepUpdateTime = dbo.f_GetDateTime2()
FROM Products p WITH (ROWLOCK, UPDLOCK)
WHERE p.ProductID = 101

GO
