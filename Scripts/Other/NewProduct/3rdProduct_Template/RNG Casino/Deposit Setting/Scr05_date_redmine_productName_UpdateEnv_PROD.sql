/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created by: {Nickname}@{date}
	Task: Update Products.Environment [Redmine: #xxx] 
	DB: DBPRO-bodb02
*/
USE bodb02
GO

DECLARE  @ProductID	SMALLINT = {ProductID}

UPDATE p 
	SET P.Environment = 0
	,RepUpdateTime=dbo.f_GetDateTime2()
FROM Products p WITH (ROWLOCK , UPDLOCK)
WHERE P.ProductID = @ProductID
GO
