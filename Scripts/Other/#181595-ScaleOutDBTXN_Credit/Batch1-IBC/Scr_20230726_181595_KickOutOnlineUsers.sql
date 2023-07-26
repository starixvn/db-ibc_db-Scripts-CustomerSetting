/*<info serverAlias="DBONUSER-ON_USER"></info>*/
/*
	Created: 20230726@Eden
	Task: Kick out online Agent - IBC Sites [RedmineID:#181595]
	DB: DBONUSER/ON_USER
*/
USE ON_USER
GO
CREATE TABLE #tblSMA(CustID INT)
CREATE TABLE #On_User (On_userid INT, isfinished BIT DEFAULT(0))

INSERT INTO #tblSMA(custid)
SELECT custid
FROM bodb02.dbo.customer WITH(NOLOCK)
WHERE site IN( '76666B','IBCINDO')
	AND roleid IN (2,3,4)
					
INSERT INTO #On_User(On_Userid)					
SELECT On_UserID 
FROM  on_user_agent o WITH(NOLOCK)
WHERE custid IN (SELECT custid FROM #tblSMA)
	AND ServerID > 0 
	AND iskickedout = 0

DECLARE @tmp TABLE(On_userid INT)

WHILE (1=1)
BEGIN
	UPDATE TOP(5000) t
	SET isfinished = 1
	OUTPUT DELETED.On_UserID INTO @tmp(On_UserID)
	FROM #On_User t
	WHERE isfinished = 0
		AND On_Userid > 0
		
	IF @@ROWCOUNT = 0
		BREAK;
		
	UPDATE o
	SET iskickedout = 1, KickoutReason = 2 
	FROM on_user_agent o WITH(UPDLOCK,ROWLOCK)
		INNER JOIN @tmp t ON o.On_UserID = t.On_UserID
	WHERE o.iskickedout = 0
	
	DELETE @tmp
	WAITFOR DELAY '0:0:0.28'
END

DROP TABLE #tblSMA
DROP TABLE #On_User







