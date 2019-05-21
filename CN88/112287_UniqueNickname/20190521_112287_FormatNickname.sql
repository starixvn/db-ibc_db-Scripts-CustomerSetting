/*
	Created: 20190514@Elodie
	DB: DBCUST/CustDB
	Task: Update site of member
*/
USE CustDB
GO
CREATE TABLE #CustList (ID INT IDENTITY(1,1), CustId INT)

INSERT INTO #CustList (CustId)
SELECT c.custid
FROM dbo.customer c WITH (NOLOCK)
	INNER JOIN dbo.customer s ON c.srecommend = s.custid
WHERE s.roleid = 4 AND s.site = 'CN88' AND (c.username2 IS NOT NULL OR c.username2 <> '')

UPDATE c 
SET c.username2 = NickName
FROM dbo.customer c WITH (ROWLOCK)	
	INNER JOIN #CustList m ON m.CustId = c.custid
	CROSS APPLY dbo.f_CS_GetNickName(UserName2,1)

DROP TABLE #CustList