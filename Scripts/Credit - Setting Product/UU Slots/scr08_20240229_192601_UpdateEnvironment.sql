/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: Luke
	Date: 20240222
	Task: UUSlots - Integrate New Product - Implement Customer setting , Initial Setting [Redmine: #192601]
	DB: DBPRO/bodb02
*/

UPDATE p
SET p.Environment = 0
FROM Products p WITH (ROWLOCK, UPDLOCK)
WHERE p.ProductID = 78