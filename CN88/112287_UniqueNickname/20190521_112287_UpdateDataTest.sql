/*
	Created: 20190514@Elodie
	DB: DBCUST/CustDB
	Task: Format nickname
*/
USE CustDB
GO
CREATE TABLE #CustList (ID INT IDENTITY(1,1), CustId INT, SubId INT)
CREATE TABLE #CustListCN88 (ID INT IDENTITY(1,1), CustId INT, SubId INT)
DECLARE @MaxID INT, @i INT

INSERT INTO #CustList (CustId, SubId)
SELECT cs.custid, cs.subaccid
FROM dbo.vw_customer c WITH (NOLOCK)
	INNER JOIN dbo.vw_customer s ON c.srecommend = s.custid
	INNER JOIN dbo.custSub cs ON c.custid = cs.custid
WHERE s.username = 'SuperTest4'

INSERT INTO #CustListCN88 (CustId, SubId)
SELECT cs.custid, cs.subaccid
FROM dbo.vw_customer c WITH (NOLOCK)
	INNER JOIN dbo.vw_customer s ON c.srecommend = s.custid
	INNER JOIN dbo.custSub cs ON c.custid = cs.custid
WHERE s.username = 'SUPERTESTCN02'

INSERT INTO #CustListCN88 (CustId, SubId)
SELECT c.custid, NULL
FROM dbo.vw_customer c WITH (NOLOCK)
	INNER JOIN dbo.vw_customer s ON c.srecommend = s.custid
WHERE s.username = 'SUPERTESTCN02'

SELECT * FROM #CustList
SELECT * FROM #CustListCN88

SELECT @MaxID = MAX(ID), @i = 1 FROM #CustList

WHILE (@i <= @MaxID)
BEGIN
	UPDATE c 
	SET c.username2 = 'SubNick0' + CONVERT(VARCHAR(50), @i)
	FROM dbo.custSub c WITH (ROWLOCK)	
		INNER JOIN #CustList m ON m.CustId = c.custid AND m.SubId = c.subaccid
	WHERE ID = @i

	SELECT @i = @i + 1
END

SELECT @MaxID = MAX(ID), @i = 1 FROM #CustListCN88

WHILE (@i <= @MaxID)
BEGIN
	UPDATE c 
	SET c.username2 = 'CN88$NickSub0' + CONVERT(VARCHAR(50), @i)
	FROM dbo.custSub c WITH (ROWLOCK)	
		INNER JOIN #CustListCN88 m ON m.CustId = c.custid AND m.SubId = c.subaccid
	WHERE ID = @i

	UPDATE c 
	SET c.username2 = 'CN88$' + username2
	FROM dbo.customer c WITH (ROWLOCK)	
		INNER JOIN #CustListCN88 m ON m.CustId = c.custid
	WHERE ID = @i AND m.SubId IS NULL

	SELECT @i = @i + 1
END

DROP TABLE #CustListCN88
DROP TABLE #CustList




