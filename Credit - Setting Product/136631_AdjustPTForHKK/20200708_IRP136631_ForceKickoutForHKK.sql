/*
	Created: 20200708@Johnson
	Task: force kickout for SMA under HKK currency
	DB: DBONUSER/ON_USER
*/

CREATE TABLE #tblSMA(CustID INT, On_userid INT, isfinished BIT DEFAULT(0))

INSERT INTO #tblSMA(custid)
SELECT custid
FROM bodb02.dbo.customer WITH(NOLOCK)
WHERE currency = 67
	AND roleid IN (2,3,4)
					
UPDATE	t
SET t.On_UserID = o.On_UserID
FROM #tblSMA t
	CROSS APPLY (SELECT TOP 1 On_UserID 
				FROM  on_user_agent o WITH(NOLOCK)
				WHERE t.custid = o.custid 
					AND ServerID > 0 
					AND iskickedout = 0
				ORDER BY o.on_userid DESC
				)o


DECLARE @tmp TABLE(On_userid INT)

WHILE (1=1)
BEGIN
	UPDATE TOP(5000) t
	SET isfinished = 1
	OUTPUT DELETED.On_UserID INTO @tmp(On_UserID)
	FROM #tblSMA t
	WHERE isfinished = 0
		AND On_Userid > 0
		
	IF @@ROWCOUNT = 0
		BREAK;
		
	UPDATE o
	SET iskickedout = 1
	FROM on_user_agent o WITH(UPDLOCK,ROWLOCK)
		INNER JOIN @tmp t ON o.On_UserID = t.On_UserID
	
	DELETE @tmp
	WAITFOR DELAY '0:0:0.28'
END

DROP TABLE #tblSMA

