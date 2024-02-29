/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: Luke
	Date: 20231201
	Task:  WE Live Casino - Implement customer setting [RedmineID: #195886]
	DB: DBPRO/bodb02
*/

UPDATE p
SET p.Environment = 0
FROM Products p WITH (ROWLOCK, UPDLOCK)
WHERE p.ProductID = 80
