/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created by: Tacy@20250827
	Task: Update Products.Environment [Redmine: #236998] 
	DB: DBPRO-bodb02
*/
USE bodb02

DECLARE  @ProductID	SMALLINT = 114

UPDATE p 
	SET P.Environment = 0
	,RepUpdateTime=dbo.f_GetDateTime2()
FROM Products p WITH (ROWLOCK , UPDLOCK)
WHERE P.ProductID = @ProductID
GO