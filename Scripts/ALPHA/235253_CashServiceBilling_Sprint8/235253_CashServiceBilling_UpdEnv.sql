/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created by: 20250819@Virgil
	Task: Cash Service Billing - Update Environment [RedmineID: #235253]
	DB: DBPRO-bodb02
*/
USE bodb02
GO

UPDATE P
SET P.Environment = 0,
	P.RepUpdateTime = SYSDATETIME()
FROM Products P WITH (ROWLOCK, UPDLOCK)
WHERE P.ProductID = 111

GO
