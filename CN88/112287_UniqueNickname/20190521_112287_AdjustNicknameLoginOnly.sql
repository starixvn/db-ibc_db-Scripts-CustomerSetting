/*
	Created: 20190514@Elodie
	DB: DBCUST/CustDB
	Task: Format nickname
*/
USE CustDB
GO
CREATE TABLE #CustList (ID INT IDENTITY(1,1), CustId INT)

INSERT INTO #CustList (CustId)
SELECT cs.subaccid
FROM dbo.customer c WITH (NOLOCK)
	INNER JOIN dbo.customer s ON c.srecommend = s.custid
	INNER JOIN dbo.custSub cs ON c.custid = cs.custid
WHERE s.roleid = 4 AND s.site = 'CN88' AND c.roleid IN(2,3,4)
	AND cs.username2 IS NOT NULL 
	AND cs.username2 <> ''
	AND cs.username2 LIKE 'CN88$%'

UPDATE c 
SET c.NicknameLoginOnly = 1
FROM dbo.custSub c WITH (ROWLOCK)	
	INNER JOIN #CustList m ON m.CustId = c.subaccid

DROP TABLE #CustList
