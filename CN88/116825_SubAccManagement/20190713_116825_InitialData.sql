/*
	Created: 20190715@Elodie
	Task: Initial data
	DB: DBCUST/CustDB 
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