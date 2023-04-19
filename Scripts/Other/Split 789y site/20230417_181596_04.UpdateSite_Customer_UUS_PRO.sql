/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230417@Tacy
	Task: Update new sites (yUT, y789, y889, yOther) for customers on PRO - UUS account
		 https://nexdev.net/issues/181596 [RedmineID: #181596]
	Database: DBCUST/CustDB
*/
----------------------------
--UDPATE Site: UUS account--
----------------------------
CREATE TABLE #Cust_UUS (
		custid		INT, 
		roleid		TINYINT,
		isfinished	BIT DEFAULT(0))

CREATE TABLE #Cust_UUS_batch (
		custid		INT, 
		roleid		TINYINT,
		newSite		VARCHAR(50) DEFAULT('yOther'))

INSERT INTO #Cust_UUS (custid, roleid)
SELECT c.custid, c.roleid
FROM customer c WITH (NOLOCK)				
WHERE c.site='789y'					
AND c.currency=20				

WHILE (1 = 1)
BEGIN
	TRUNCATE TABLE #Cust_UUS_batch

	UPDATE TOP (2000) T
	SET isfinished = 1
	OUTPUT inserted.custid, inserted.roleid INTO #Cust_UUS_batch (custid, roleid)
	FROM #Cust_UUS T
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	IF EXISTS (SELECT 1 FROM #Cust_UUS_batch WHERE roleid=2)
	BEGIN
		UPDATE c
		SET site = t.newSite
		FROM CustAgent c WITH(UPDLOCK, ROWLOCK)
		INNER JOIN #Cust_UUS_batch t ON t.custid=c.custid
		WHERE t.roleid=2
	END

	UPDATE c
	SET site = t.newSite
	FROM Customer c WITH(UPDLOCK, ROWLOCK)
	INNER JOIN #Cust_UUS_batch t ON t.custid=c.custid
	
	WAITFOR DELAY '00:00:0.100'
END

DROP TABLE #Cust_UUS, #Cust_UUS_batch
GO