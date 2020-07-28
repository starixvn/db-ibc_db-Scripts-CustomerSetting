/*
	Created: 20200728@Johnson
	Task: update minbet for newly customer HKK's supers
	DB: DBCUST/CUSTDB
*/

DECLARE @maxcustid INT = xxx

CREATE TABLE #Supers(CustID INT, isfinished BIT DEFAULT(0))

INSERT INTO #Supers(custid)
SELECT custid
FROM vw_customer WITH(NOLOCK)
WHERE currency = 67
	AND roleid = 4
	AND site IN ('733333','222223','722222')

CREATE TABLE #Downlines (custid INT PRIMARY KEY, roleid TINYINT, isfinished BIT DEFAULT 0)
DECLARE @BatchMember TABLE(custid INT PRIMARY KEY, roleid TINYINT)
	
INSERT INTO #Downlines (custid,roleid)
SELECT custid, roleid
FROM custinfo WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM #Supers)
	AND Enabled = 1
	AND custid > @maxcustid
	
WHILE(1=1)
BEGIN
	DELETE @BatchMember
	
	;WITH T AS (
		SELECT TOP (500) custid
		FROM #Downlines t
		WHERE t.isfinished = 0
		ORDER BY t.roleid DESC
	)
	UPDATE t1
	SET isfinished = 1
	OUTPUT DELETED.custid, DELETED.roleid INTO @BatchMember(custid,roleid)
	FROM #Downlines t1
	WHERE t1.custid IN (SELECT custid FROM t)
	
	IF @@ROWCOUNT = 0
		BREAK;
		
	UPDATE cs
	SET MinBet = CASE WHEN MaxBet >= 10 THEN 10 ELSE MinBet END
	FROM CustSetting cs WITH(UPDLOCK,ROWLOCK)
	WHERE custid IN (SELECT custid FROM @BatchMember)
		AND minbet <> 0
	
	IF EXISTS(SELECT 1 FROM @BatchMember WHERE roleid > 1)
	BEGIN
		UPDATE cs
		SET cs.MinBet = CASE WHEN MaxBet >= 10 THEN 10 ELSE cs.MinBet END				
		FROM CustBetSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
		WHERE custid IN (SELECT custid FROM @BatchMember WHERE roleid > 1)
			AND minbet <> 0
			AND sporttype IN (43,44) 
	END
	
	IF EXISTS(SELECT 1 FROM @BatchMember WHERE roleid = 1)
	BEGIN
		UPDATE cs
		SET cs.MinBet = CASE WHEN MaxBet >= 10 THEN 10 ELSE cs.MinBet END				
		FROM CustBetSetting3rd_Member cs WITH(UPDLOCK,ROWLOCK)
		WHERE custid IN (SELECT custid FROM @BatchMember WHERE roleid = 1)
			AND minbet <> 0
			AND sporttype IN (43,44) 
	END
	
	WAITFOR DELAY '0:0:1'
END		
	