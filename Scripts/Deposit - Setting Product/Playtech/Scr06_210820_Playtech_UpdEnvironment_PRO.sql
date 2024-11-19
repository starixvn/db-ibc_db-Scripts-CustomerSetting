/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created by: 20240919@Virgil
	Task: Playtech - Implement customer setting [RedmineID: #210552]
	DB: DBPRO-bodb02
*/
USE bodb02
GO

UPDATE P
SET P.Environment = 0,
	P.RepUpdateTime = SYSDATETIME()
FROM Products P WITH (ROWLOCK, UPDLOCK)
WHERE P.ProductID = 100

GO
