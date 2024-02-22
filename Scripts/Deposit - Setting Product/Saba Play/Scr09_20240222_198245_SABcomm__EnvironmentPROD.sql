/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: Tacy@20240126 
	Task: Saba Play - Integrate New Product [redmine: #198243]
	DB: DBPRO-bodb02
*/
USE bodb02
GO

UPDATE Products WITH (UPDLOCK, ROWLOCK)
SET Environment=0
WHERE ProductID=82
GO
