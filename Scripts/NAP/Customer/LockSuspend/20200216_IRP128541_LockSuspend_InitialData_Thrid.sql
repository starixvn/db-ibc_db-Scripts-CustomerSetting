/*
	Created by: Elodie
	Date: 20200216
	Task: Intial data
	DB: DBCUST/CustDB
*/
USE CustDB
GO

--8 affected rows
DELETE cs 
FROM dbo.custInfo ci WITH (NOLOCK)
	INNER JOIN CustSuspendLockUpd cs WITH (ROWLOCK) ON ci.custid = cs.custid
WHERE ci.username IN ('KJH0045','KJH002F','KAG05','KJH003N','KJH003O','KJH003P','KJH003U','2IE18')
