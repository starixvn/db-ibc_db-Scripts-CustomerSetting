/*
	Created by: Elodie
	Date: 20200216
	Task: Insert test data
	DB: DBCUST/CustDB
*/
USE CustDB
GO

INSERT INTO CustSuspendLockUpd (CustID)
SELECT custid 
FROM dbo.custInfo ci WITH (NOLOCK)
WHERE ci.custid IN (576313,23003341,23071808,23167462,23613135,14174238, 14167350)
