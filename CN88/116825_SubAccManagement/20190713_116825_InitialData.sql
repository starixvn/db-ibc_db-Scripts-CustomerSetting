/*
	Created: 20190715@Elodie
	Task: Initial data
	DB: DBCUST/CustDB 
*/

USE CustDB
GO

UPDATE cs 
SET IsDeleted = 0, IsAllDownline = 0,
	cs.PageAccess = REPLACE((REPLACE(cs.PageAccess, '[H]','')),'[B]','')
FROM dbo.custSub cs WITH (ROWLOCK)
	INNER JOIN dbo.Customer c WITH (NOLOCK) ON c.custid = cs.custid
WHERE c.site = 'CN88'