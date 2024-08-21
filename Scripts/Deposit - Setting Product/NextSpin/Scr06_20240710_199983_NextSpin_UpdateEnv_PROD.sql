/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20240710@Tacy
	Task: Nextspin - Update Products.Environment [#199983] 
	DB: DBPRO-bodb02
*/

USE bodb02
GO

UPDATE p 
	SET P.Environment = 0
FROM Products p WITH (ROWLOCK, UPDLOCK)
WHERE P.ProductID = 85
GO