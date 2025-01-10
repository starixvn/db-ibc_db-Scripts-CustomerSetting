/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created by: 20241217@Virgil
	Task: PLAY STAR - Implement setting and initial data [RedmineID: #208021]
	DB: DBPRO-bodb02
*/
USE bodb02
GO

UPDATE P
SET P.Environment = 0,
	P.RepUpdateTime = SYSDATETIME()
FROM Products P WITH (ROWLOCK, UPDLOCK)
WHERE P.ProductID = 91

GO
