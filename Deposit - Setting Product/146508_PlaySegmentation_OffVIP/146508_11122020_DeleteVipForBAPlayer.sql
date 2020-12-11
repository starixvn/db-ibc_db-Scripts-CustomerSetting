/*
	Created by: Winfred
	Date: 20201211
	Task: Turn off VIP For BA player  [RedmineID:#146508]
	DB: DBCust/CustDB
*/

USE CustDB
GO

-- Check vip delete

--SELECT COUNT(a.custid)
--FROM Customer a WITH(NOLOCK)
--INNER JOIN Dep_CustVIP b  WITH(NOLOCK) on a.custid = b.CustID
--INNER JOIN Dep_CustBAActive c  WITH(NOLOCK) on a.custid = c.CustID

--- delete vip
DELETE V
FROM Dep_CustVIP V 
WHERE EXISTS (SELECT 1 FROM Dep_CustBAActive b WITH(NOLOCK) WHERE b.custid = v.custid)