/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created by: Virgil@20251010
	Task: Update Products.Environment [Redmine: #241271] 
	DB: DBPRO-bodb02
*/
USE bodb02
GO

DECLARE  @ProductID	SMALLINT = 116

UPDATE p 
	SET P.Environment = 0
	,RepUpdateTime=dbo.f_GetDateTime2()
FROM Products p WITH (ROWLOCK , UPDLOCK)
WHERE P.ProductID = @ProductID
GO
