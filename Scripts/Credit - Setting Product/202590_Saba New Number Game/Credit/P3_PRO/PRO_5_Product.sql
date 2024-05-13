/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20240408@Helios
	Task: Update Products.Environment [#202590] 
	DB: DBPRO-bodb02
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
	UPDATE p 
		SET P.Environment = 0
	FROM Products p WITH (ROWLOCK , UPDLOCK)
	WHERE P.ProductID = 86