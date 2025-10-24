/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250611@Elodie
	Task: Intial data for ServiceType [223896]  
	DB: DBCUST/CustDB
*/
USE CustDB
GO 

CREATE TABLE #tblCust (custid INT PRIMARY KEY)
DECLARE @tmp TABLE (custid INT PRIMARY KEY)
	
INSERT INTO #tblCust(custid)
SELECT custid
FROM CustProductStatus ci WITH(NOLOCK) 
WHERE ServiceType IS NULL
		
WHILE(1=1)
BEGIN
	DELETE TOP (2000) t
	OUTPUT DELETED.custid INTO @tmp(custid)
	FROM #tblCust t
		
	IF @@ROWCOUNT = 0
		BREAK;
			
	UPDATE cs
	SET cs.ServiceType = 0,
		RepUpdateTime = dbo.f_GetDateTime2()
	FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK)
	WHERE custid IN (SELECT custid FROM @tmp)
		AND ServiceType IS NULL
			
	DELETE @tmp		
	WAITFOR DELAY '00:00:00.300'
END
		
DROP TABLE #tblCust	