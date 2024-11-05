/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 202409009@Virgil
	Task:  ON Casino - Implement Customer Setting and Initial data [RedmineID: #210025]
	DB: DBPRO-bodb02
*/
USE bodb02
GO

UPDATE p
SET p.Environment = 0, RepUpdateTime = dbo.f_GetDateTime2()
FROM Products p WITH (ROWLOCK, UPDLOCK)
WHERE p.ProductID = 96
GO
