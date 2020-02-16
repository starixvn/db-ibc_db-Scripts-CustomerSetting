/*
	Created by: Elodie
	Date: 20200216
	Task: Intial data
	DB: DBCUST/CustDB
*/
USE CustDB
GO

--9 affected rows
INSERT INTO CustSuspendLockUpd (CustID)
SELECT custid
FROM dbo.custInfo ci WITH (NOLOCK)
WHERE ci.username IN ('KJH0045','KJH002F','KAG05','KJH003N','KJH003O','KJH003P','KJH003U','2IE18','SSFKS2')
