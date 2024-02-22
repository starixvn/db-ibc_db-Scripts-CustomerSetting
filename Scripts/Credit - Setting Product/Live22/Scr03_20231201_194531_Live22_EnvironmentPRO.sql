/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: Tacy@20231201 
	Task: Live22 - Integrate New Product [redmine: #194531]
	DB: DBPRO-bodb02
*/
USE bodb02
GO

UPDATE Products WITH (UPDLOCK, ROWLOCK)
SET Environment=0
WHERE ProductID=79
GO