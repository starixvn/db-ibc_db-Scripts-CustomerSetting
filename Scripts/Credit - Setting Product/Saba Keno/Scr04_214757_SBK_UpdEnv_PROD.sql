/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20241213@Virgil
	Task: Saba Keno - Implement Setting and Initial data [RedmineID: #214757]
	DB: DBPRO-bodb02
*/
USE bodb02
GO

UPDATE p
SET p.Environment = 0, 
	RepUpdateTime = dbo.f_GetDateTime2()
FROM Products p WITH (ROWLOCK, UPDLOCK)
WHERE p.ProductID = 102

GO

