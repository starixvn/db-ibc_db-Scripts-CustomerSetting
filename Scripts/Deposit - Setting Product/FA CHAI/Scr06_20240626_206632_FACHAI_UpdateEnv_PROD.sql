/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20240626@Tacy
	Task: FA CHAI - Update Products.Environment [#206632] 
	DB: DBPRO-bodb02
*/

USE bodb02
GO

UPDATE p 
	SET P.Environment = 0
FROM Products p WITH (ROWLOCK, UPDLOCK)
WHERE P.ProductID = 89
GO