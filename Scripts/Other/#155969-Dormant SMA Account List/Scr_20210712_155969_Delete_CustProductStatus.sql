/*<info serverAlias="DBCUST-CustDB"></info>*/ 
/*
	Created: Eden@21210712
	Task: Delete data CustProductStatus table for customers who were archived on stage 4 [Redmine: #155969] 
		ONLY RUN THIS SCRIPT if current stage 4 will be run after Suspend/close feature released 
	DB: DBCUST/CustDB
*/

USE CustDB
GO
CREATE TABLE #Deleted_Cust(CustID INT, IsFinished BIT DEFAULT 0)
CREATE TABLE #Deleted_Cust_tmpBatch(CustID INT)

--Get customers who were deleted custinfo table but CustProductStatus table
INSERT INTO #Deleted_Cust(CustID)
SELECT p.custid
FROM Temp_Revert_CustProductStatus p WITH(NOLOCK) 
	LEFT JOIN custinfo c (NOLOCK)
		ON c.custid = p.CustID
WHERE c.custid IS NULL


--> Delete CustProductStatus
WHILE 1= 1
BEGIN
	UPDATE TOP (5000) t
	SET t.IsFinished = 1
	OUTPUT deleted.CustID INTO #Deleted_Cust_tmpBatch(CustID)
	FROM #Deleted_Cust t
	WHERE t.IsFinished = 0

	IF @@ROWCOUNT = 0
		BREAK;
	
	DELETE  p
	FROM #Deleted_Cust_tmpBatch t
		INNER JOIN dbo.CustProductStatus p WITH(ROWLOCK,UPDLOCK) 
			ON t.CustID = p.custid

	WAITFOR DELAY '00:00:00.200'
END

DROP TABLE #Deleted_Cust
DROP TABLE #Deleted_Cust_tmpBatch