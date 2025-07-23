/*<info serverAlias="DBPRO-bodb02"></info>*/

/*
	Created: 20250627@Tacy
	DB: DBPRO.bodb02
	Task: SportBetTypeMatrix - Clean unused data
*/

USE bodb02
GO

DELETE TOP (51) b
FROM dbo.SportBettypeMatrix b WITH (ROWLOCK)
WHERE  b.sporttype=189 and b.ProductID=84
GO
