/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created by: Johnson@20250929
	Task: Update Products.Environment [Redmine: #239527] 
	DB: DBPRO-bodb02
*/
USE bodb02
GO

DECLARE  @ProductID	SMALLINT = 115

UPDATE p 
	SET P.Environment = 0
	,RepUpdateTime=dbo.f_GetDateTime2()
FROM Products p WITH (ROWLOCK , UPDLOCK)
WHERE P.ProductID = @ProductID
GO
