/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20241030@Virgil
	Task:  VS6 (Betby) - Integrate New Product [RedmineID: #212562]
	DB: DBPRO-bodb02
*/
USE bodb02
GO

UPDATE p
SET p.Environment = 0,
	RepUpdateTime = SYSDATETIME()
FROM Products p WITH (ROWLOCK, UPDLOCK)
WHERE p.ProductID = 71
GO

