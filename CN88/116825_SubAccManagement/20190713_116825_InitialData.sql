/*
	Created: 20190422@Elodie
	Task: Add username2 column into CustSub
	DB: DBCUST/CustDB and all replicated server of CustDB_Customer_Info pub
*/

USE CustDB
GO

UPDATE cs 
SET IsDeleted = 0, IsAllDownline = 0
FROM dbo.custSub cs WITH (ROWLOCK)
	INNER JOIN dbo.Customer c WITH (NOLOCK) ON c.custid = cs.custid
WHERE c.site = 'CN88'

UPDATE cs 
SET PageAccessControl = ''
FROM dbo.CustSuper cs WITH (ROWLOCK)
	INNER JOIN dbo.Customer c WITH (NOLOCK) ON c.custid = cs.custid
WHERE c.site = 'CN88'