/*
	Created: Winfred	
	Task: Apply color for archived accounts [Redmine:145018 ]
	DB: DBCUST/CustDB
	Date: 20202311
	
	Explanation : CloseReason
			4: This account was closed by inactivity.
			3: This account was closed by false input of OTP/Security Code
			0: This account was closed by failed logins.
*/

USE CustDB
GO

CREATE TABLE #temp (custid INT, Level VARCHAR(100), CloseReason TINYINT)
INSERT INTO #temp (custid, Level, CloseReason)
VALUES  (45081835,'Super',4),
		(45081662,'Super',0),
		(45082719,'Master',4),
		(45133308,'Master',0),
		(45182984,'Master',4),
		(45083035,'Agent',4),
		(45133553,'Agent',0),
		(45181958,'Member',4),
		(45126890,'Member',4),
		(45127036,'Member',3),
		(45127647,'Member',0),
		(46750600,'Master',4),
		(46750620,'Agent',4),
		(46750638,'Member',4)


UPDATE m
	SET ClosedReason = t.CloseReason
FROM CustLoginInfo_Member m WITH (ROWLOCK, UPDLOCK) 	
	INNER JOIN custInfo ci WITH (NOLOCK) ON ci.custid = m.custid	
	INNER JOIN #temp t ON m.custid = t.custid
WHERE t.Level IN ('Member')	AND ci.currency = 20 AND ci.roleid =  1

UPDATE m
	SET ClosedReason = t.CloseReason
FROM CustLoginInfo m WITH (ROWLOCK, UPDLOCK) 
	INNER JOIN custInfo ci WITH (NOLOCK) ON ci.custid = m.custid	
	INNER JOIN #temp t ON m.custid = t.custid
WHERE t.Level IN ('Super','Master','Agent') AND ci.currency = 20  AND ci.roleid IN (2,3,4)