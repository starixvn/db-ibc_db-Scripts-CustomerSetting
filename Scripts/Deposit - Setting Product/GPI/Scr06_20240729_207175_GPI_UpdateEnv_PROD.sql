/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20240729@Tacy
	Task: GPI - Update Products.Environment [#207175] 
	DB: DBPRO-bodb02
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
	UPDATE p 
		SET P.Environment = 0
		,RepUpdateTime=SYSDATETIME()
	FROM Products p WITH (ROWLOCK , UPDLOCK)
	WHERE P.ProductID = 48
