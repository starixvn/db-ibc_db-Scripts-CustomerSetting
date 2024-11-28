/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20240708@Tacy
	Task: VS5 - Update Products.Environment [#207587] 
	DB: DBPRO-bodb02
*/

USE bodb02
GO

UPDATE p 
	SET P.Environment = 0
		,p.RepUpdateTime=dbo.f_GetDateTime2()
FROM Products p WITH (ROWLOCK, UPDLOCK)
WHERE P.ProductID = 88
GO
