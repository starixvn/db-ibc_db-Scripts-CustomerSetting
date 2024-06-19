/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240619@Elodie
	Task: Delete redundant data of CustDateLimit
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @Temp TABLE (CustID INT)
DECLARE @TempBatch TABLE (CustID INT)

INSERT INTO @Temp (CustID)
SELECT d.custid
FROM Age_CustDateLimit d (NOLOCK)
	LEFT JOIN custInfo c (NOLOCK) ON d.CustId = c.custid
WHERE c.custid IS NULL OR c.Enabled = 0

WHILE (1=1)
BEGIN
	DELETE TOP (4000) t OUTPUT deleted.custid INTO @TempBatch (CustID)
	FROM @Temp t

	IF @@ROWCOUNT = 0 BREAK

	DELETE d
	FROM Age_CustDateLimit d (ROWLOCK)
		INNER JOIN @TempBatch t ON d.custid = t.custid

	DELETE FROM @TempBatch
END
