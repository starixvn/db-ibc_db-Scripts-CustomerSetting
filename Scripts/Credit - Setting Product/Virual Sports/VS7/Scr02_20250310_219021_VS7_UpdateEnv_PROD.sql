/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20250310@Dave
	Task: Virtual Sports 7 - Kiron - Integrate new Product [RM:#219021]
	DB: DBPRO-bodb02
*/

USE bodb02
GO

UPDATE p 
	SET P.Environment = 0
		,p.RepUpdateTime=dbo.f_GetDateTime2()
FROM Products p WITH (ROWLOCK, UPDLOCK)
WHERE P.ProductID = 106
GO
