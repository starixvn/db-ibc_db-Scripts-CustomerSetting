/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@21210712
	Task: Revert data CustProductStatus table for customers who were archived on stage 3 [Redmine: #155969]  
		1. Backup data to table Temp_Revert_CustProductStatus
		2. Revert CustProductStatus
	DB: DBCUST/CustDB
*/

USE CustDB
GO
CREATE TABLE #Revert_Cust(CustID INT, IsFinished BIT DEFAULT 0)
CREATE TABLE #Revert_Cust_tmpBatch(CustID INT)

--Get Revert Cust List
INSERT INTO #Revert_Cust(CustID)
SELECT c.custid
FROM custinfo c WITH(NOLOCK) 
	LEFT JOIN CustProductStatus p (NOLOCK)
		ON c.custid = p.CustID
WHERE Enabled = 0	   
	AND c.srecommend NOT IN ( SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND p.CustID IS NULL

--Insert Revert Cust List to temptable use for future purpose 
SELECT t.CustID
INTO Temp_Revert_CustProductStatus
FROM #Revert_Cust t
	INNER JOIN DBARCCUST.bodb_Customer.dbo.CustProductStatus_old  old WITH(NOLOCK) 
		ON t.CustID = old.custid

--> Revert CustProductStatus
WHILE 1= 1
BEGIN
	UPDATE TOP (10000) t
	SET t.IsFinished = 1
	OUTPUT deleted.CustID INTO #Revert_Cust_tmpBatch(CustID)
	FROM #Revert_Cust t
	WHERE t.IsFinished = 0

	IF @@ROWCOUNT = 0
		BREAK;
	
	INSERT INTO dbo.CustProductStatus( 	
		CustID
		,bitmapHasSynced
		,bitmapIsHidden
		,bitmapIsDisabled
		,SuspendInfo
		,Locked
		,CloseInfo
	)
	SELECT old.CustID
		,old.bitmapHasSynced
		,old.bitmapIsHidden
		,old.bitmapIsDisabled
		,old.SuspendInfo
		,old.Locked
		,old.CloseInfo
	FROM #Revert_Cust_tmpBatch t
		INNER JOIN DBARCCUST.bodb_Customer.dbo.CustProductStatus_old  old WITH(NOLOCK) 
			ON t.CustID = old.custid
		LEFT JOIN dbo.CustProductStatus c2 WITH(NOLOCK) 
			ON t.CustID = c2.CustID
	WHERE c2.CustID IS NULL

	WAITFOR DELAY '00:00:00.200'
END

DROP TABLE #Revert_Cust
DROP TABLE #Revert_Cust_tmpBatch