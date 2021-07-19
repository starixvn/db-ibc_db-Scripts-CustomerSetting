/*
	Created: Elodie
	Task: Correct Dangerous value 
	DB: DBCUST/CustDB
	Date: 20171208
*/ 
USE CustDB
GO 
CREATE TABLE #TmpList (CustID INT, Danger TINYINT, Danger2 TINYINT, Danger3 TINYINT)

WHILE (1=1)
BEGIN
	INSERT INTO #TmpList (CustID, Danger, Danger2, Danger3)
	SELECT TOP 5000 CustID, Danger, Danger2, Danger3
	FROM DataHistory_danielTmp

	IF @@ROWCOUNT = 0
		BREAK

	UPDATE c
	SET c.danger = tmp.Danger,
		c.danger2 = tmp.Danger2,
		c.danger3 = tmp.Danger3
	FROM dbo.custInfo c WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #TmpList tmp ON c.custid = tmp.CustID

	DELETE h
	FROM DataHistory_danielTmp h
		INNER JOIN #TmpList tmp ON tmp.CustID = h.CustID
	
	DELETE FROM #TmpList

	WAITFOR DELAY '00:00:0.300'
END