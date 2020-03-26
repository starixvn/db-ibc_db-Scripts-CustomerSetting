/*
	Created: Johnson
	Task: adjust bet setting Esports & Muay Thai for newly customers of 789y [RedmineID: #131163]
	DB: DBCUST/CustDB
	Date: 20200326
*/ 

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 	
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	and s.site = '789y'
	
CREATE TABLE #tblCust(custid INT,roleid TINYINT)
	DECLARE @tmpCust TABLE(custid INT)
	
	INSERT INTO #tblCust (custid,roleid)
	SELECT custid, roleid
	FROM custinfo WITH(NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers)
		AND custid > @max_custid
	
	--update bet setting for SMA
	UPDATE cs
	SET cs.MinBet = 3,
		cs.MaxBet = 50,
		cs.MaxPerMatch = 250
	FROM dbo.CustBetSetting3rd_Agent cs WITH (UPDLOCK,ROWLOCK) 		
	WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid IN(2,3,4))
		AND sporttype IN (43,44)
		AND ((cs.MaxBet < 1 OR cs.MaxPerMatch < 1) 
			OR
			(cs.MinBet = cs.MaxBet AND cs.MinBet = cs.MaxPerMatch AND cs.MinBet <3)
		)
	
	DELETE #tblCust WHERE roleid > 1
	
	DELETE t
	FROM #tblCust t
	WHERE NOT EXISTS(
		SELECT 1
		FROM dbo.CustBetSetting3rd_Member cs WITH(NOLOCK) 
		WHERE sporttype IN(43,44)
			AND cs.custid = t.custid
			AND ((cs.MaxBet < 1 OR cs.MaxPerMatch < 1) 
				OR
				(cs.MinBet = cs.MaxBet AND cs.MinBet = cs.MaxPerMatch AND cs.MinBet <3)
			)	
	)	

	WHILE(1=1)
	BEGIN
		DELETE TOP(1000) FROM #tblCust
		OUTPUT DELETED.custid
		INTO @tmpCust
		
		IF @@ROWCOUNT = 0
			BREAK;
			
		UPDATE cs
		SET cs.MinBet = 3,
			cs.MaxBet = 50,
			cs.MaxPerMatch = 250
		FROM dbo.CustBetSetting3rd_Member cs WITH (UPDLOCK,ROWLOCK) 		
		WHERE custid IN (SELECT custid FROM @tmpCust)
			AND sporttype IN (43,44)
			AND ((cs.MaxBet < 1 OR cs.MaxPerMatch < 1) 
				OR
				(cs.MinBet = cs.MaxBet AND cs.MinBet = cs.MaxPerMatch AND cs.MinBet <3)
			)
		
		DELETE @tmpCust
		
		WAITFOR DELAY '00:00:00.28'
	END		
	