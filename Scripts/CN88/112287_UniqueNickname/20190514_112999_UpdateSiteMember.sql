/*
	Created: 20190514@Elodie
	DB: DBCUST/CustDB
	Task: Update site of member
*/
USE CustDB
GO
CREATE TABLE #MemberList (ID INT IDENTITY(1,1), CustId INT)

INSERT INTO #MemberList (CustId)
SELECT c.custid
FROM dbo.customer c WITH (NOLOCK)
	INNER JOIN dbo.customer s ON c.srecommend = s.custid
WHERE s.roleid = 4 AND s.site = 'CN88' AND c.roleid = 1

UPDATE c 
SET c.site = 'CN88'
FROM dbo.customer c WITH (ROWLOCK)
	INNER JOIN #MemberList m ON m.CustId = c.custid

DROP TABLE #MemberList