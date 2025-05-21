/*<info serverAlias="DBARCCUST-Bodb_Archive_Customer_Licensee"></info>*/
/*
	Created: 20250415@Tacy	
	Task: ARCHIVE - tbl [Customer] - Copy data 
	DB: DBARCCUST-Bodb_Archive_Customer_Licensee
	
	Revisions:
		- 20250415@Tacy: Created [RedmineID: #222339]
*/
USE Bodb_Archive_Customer_Licensee
GO

-- Step 2: Copy data from 'Currency' to 'newCurrency' in batches of 5000 rows
CREATE TABLE #tmpCustomer (CustID INT PRIMARY KEY CLUSTERED)
CREATE TABLE #tmpCustomer_batch (CustID INT PRIMARY KEY CLUSTERED)

INSERT INTO #tmpCustomer (CustID)
SELECT custid
FROM Customer WITH (NOLOCK)

-- Loop to copy data in batches
WHILE EXISTS (SELECT TOP 1 1 FROM #tmpCustomer)
BEGIN
	DELETE FROM #tmpCustomer_batch

	DELETE TOP (5000) C
	OUTPUT DELETED.CustID INTO #tmpCustomer_batch (CustID)
	FROM #tmpCustomer C

	IF @@ROWCOUNT=0
		BREAK;
	
	UPDATE c
    SET c.newCurrency = c.Currency
	FROM Customer c WITH (ROWLOCK, UPDLOCK)
	INNER JOIN #tmpCustomer_batch t ON t.CustID=c.custid
END
GO

DROP TABLE #tmpCustomer, #tmpCustomer_batch
GO