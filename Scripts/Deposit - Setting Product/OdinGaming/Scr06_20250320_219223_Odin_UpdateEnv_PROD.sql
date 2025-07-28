/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20250320@Tacy
	Task: Update Products.Environment [#219223] 
	DB: DBPRO-bodb02
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
	UPDATE p 
		SET P.Environment = 0
		,RepUpdateTime=dbo.f_GetDateTime2()
	FROM Products p WITH (ROWLOCK , UPDLOCK)
	WHERE P.ProductID = 105
