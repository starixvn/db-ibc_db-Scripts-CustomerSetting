/*
	Created: 20190515@Elodie	
	Task: Add CS_CustomerStatus table 
	DB: DBCUST/CustDB and all replicated server of CustDB_Customer_Info pub
*/
USE CustDB
GO

DELETE FROM CS_CustomerStatus

INSERT INTO CS_CustomerStatus  (CustId, InactiveInfo, SuspendedInfo, ViewOnlyInfo)
SELECT CustId, 0, 0, 0
FROM Customer c WITH (NOLOCK)
WHERE c.site = 'CN88' AND (c.roleid BETWEEN 2 AND 4 OR c.roleid = 0)

INSERT INTO CS_CustomerStatus  (CustId, InactiveInfo, SuspendedInfo, ViewOnlyInfo)
SELECT c.CustId, 0, 0, 0
FROM Customer c WITH (NOLOCK)
	INNER JOIN Customer a WITH (NOLOCK) ON c.recommend = a.custid
WHERE a.site = 'CN88' AND a.roleid = 2 AND c.roleid = 1

