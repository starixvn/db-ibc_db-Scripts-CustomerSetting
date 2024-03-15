/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: Luke@20240315
	Task: Yolo Play - Implement customer setting - initial setting [Redmine: #201447]
	DB: DBPRO/bodb02
*/

UPDATE p
SET p.Environment = 0
FROM Products p WITH (ROWLOCK, UPDLOCK)
WHERE p.ProductID = 84