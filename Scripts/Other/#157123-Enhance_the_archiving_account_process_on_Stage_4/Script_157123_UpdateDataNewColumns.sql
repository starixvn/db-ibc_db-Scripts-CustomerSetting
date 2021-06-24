/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20210617
	Task: update data Stage 3 for new columns of Cust_ArchiveAccount [Redmine: #157123]   
	DB: DBCUST/CustDB
*/

USE CustDB
GO
CREATE TABLE #S3_cust(custid INT, username VARCHAR(30),Lastlogged  DATETIME)
CREATE TABLE #S3_cust_batch(custid INT, username VARCHAR(30),Lastlogged  DATETIME)

INSERT INTO #S3_cust(custid,username,Lastlogged)
SELECT c.CustID,ci.username,ci.lastlogged
FROM Cust_ArchiveAccount c WITH(NOLOCK)
	INNER JOIN customer ci WITH(NOLOCK) ON c.CustID = ci.custid
WHERE c.StageID = 3

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #S3_cust_batch

	DELETE TOP(5000) t
	OUTPUT deleted.custid ,deleted.username,deleted.Lastlogged
	INTO #S3_cust_batch(custid,username,Lastlogged)
	FROM #S3_cust t

	IF @@ROWCOUNT = 0
		BREAK;

	UPDATE c
	SET c.Username = t.username,
		c.Lastlogged = t.Lastlogged
	FROM Cust_ArchiveAccount c WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #S3_cust_batch t ON c.CustID = t.custid

END

DROP TABLE #S3_cust
DROP TABLE #S3_cust_batch
GO