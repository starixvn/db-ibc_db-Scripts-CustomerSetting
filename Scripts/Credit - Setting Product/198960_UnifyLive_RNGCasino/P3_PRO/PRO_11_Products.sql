/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20240408@Helios
	Task: Update Products.CasinoType [#198960] 
	DB: DBPRO-bodb02
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
	UPDATE p 
		SET P.CasinoType = CASE 
						WHEN ProductID = 70 THEN 2
						ELSE 1
					 END
	FROM Products p WITH (ROWLOCK , UPDLOCK)
	WHERE P.ProductID IN (50,38,66,6,42,70)