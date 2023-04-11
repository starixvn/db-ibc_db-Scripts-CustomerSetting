/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 20221020
	Task: Non Offer - Update value Status [#RM:174744]
	DB: DBCUST/CustDB 
*/
	IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
		DROP TABLE	#supers;
	CREATE TABLE #supers (custid INT, Rule_RNGKeno	INT,isfinished BIT DEFAULT(0))
	CREATE TABLE #supers_missHiden (custid INT PRIMARY KEY) --update disabled=0 miss update hideKeno=0
	CREATE TABLE #supers_missDis (custid INT PRIMARY KEY) --update hideKeno=1, miss update disabled=1
	CREATE TABLE #Member (CustID INT PRIMARY KEY CLUSTERED , Rule_RNGKeno INT)
	CREATE TABLE #MemberTemp (CustID INT PRIMARY KEY, Rule_RNGKeno INT)
	CREATE TABLE #SMATemp (	CustID INT PRIMARY KEY CLUSTERED, Rule_RNGKeno INT)
	CREATE TABLE #SMATempNew (CustID INT PRIMARY KEY, Rule_RNGKeno INT)

	DECLARE @srecommend INT , @Rule_RNGKeno INT, @max_custid INT
	SELECT @max_custid = xxx

	INSERT INTO #supers_missHiden(custid)
	SELECT ci.custid
	FROM customer ci WITH(NOLOCK) 
		INNER JOIN custinfo c WITH(NOLOCK) ON ci.custid = c.custid
		INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site	
		LEFT JOIN custAccount ca WITH(NOLOCK) ON ca.custid = ci.custid
	WHERE ISNULL(ca.groupid,0) NOT IN (
		SELECT 	groupID 
		FROM custAccount WITH(NOLOCK)
		WHERE custid IN (SELECT custid 
						FROM custinfo WITH (NOLOCK) 
						WHERE username IN ('SDRMB', '266HK', 'M863HK', 'SBSR', 'YKH', 'S188RM', 'PYY', 'POT', 'SF8', 'S80R',
										--list 20 previous headlines
										'CLM','S79RM','PHRM','KJH','MMMRM','M50RM','DDS','M789H','SFB','MTRE','MQRM','S59BR','S27A','VVG','S63H','S70RMB','S90R','WWR','XCN','M606HK'
									))
			   )
		AND ci.roleid = 4
		AND s.isLicensee = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND ci.custid NOT IN (SELECT DISTINCT srecommend 
							FROM customer WITH(NOLOCK)
							WHERE username IN (SELECT username 
												FROM PhoneBettingCustomerList WITH(NOLOCK)
											)
							)
		AND NOT EXISTS (SELECT 1 FROM CustSuper s WITH(NOLOCK) WHERE ci.custid = s.custid AND isInternal = 1)					
		AND c.enabled = 1
		AND ci.site NOT IN ('789y')
		AND ci.currency IN (2,3,5,6,9,12,13,15,16,22,33,34,42,43,45,47,53,64,67,69)
		AND ci.custid NOT IN (SELECT custid FROM Acc_CustDirect WITH(NOLOCK) WHERE roleid = 4) --super not dummy account
		AND ci.username not like '3rdSuper%'  

	INSERT INTO #supers_missDis(custid)
	SELECT ci.custid
	FROM customer ci WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
		LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.roleid = 4  
			AND ci.username NOT LIKE '3rdSuper%'
			AND cs.isinternal = 0
			AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
			AND s.islicensee = 0
			AND (  ( ci.Site IN ('611111') AND ci.currency IN (2,42))
				OR ( ci.Site IN ('722222','733333') AND ci.currency IN (13))
				OR ( ci.Site IN ('789y') AND ci.currency IN (2,6))
				OR ( ci.Site IN ('7aa666') AND ci.currency IN (2))
				OR ( ci.Site IN ('BEST-ODDS') AND ci.currency IN (42)))

	INSERT INTO #supers(custid,Rule_RNGKeno)
	SELECT custid, 2 AS Rule_RNGKeno from #supers_missHiden --update disabled=0 miss update hideKeno=0
	UNION 
	SELECT custid, 1 AS Rule_RNGKeno from #supers_missDis --update hideKeno=1, miss update disabled=1
	UNION 
	SELECT ci.custid, 3 AS Rule_RNGKeno --update hideKeno=0
	FROM customer ci WITH (NOLOCK) 
		INNER JOIN custInfo C WITH (NOLOCK) ON C.custid = ci.custid
		INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
		INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'
		AND ci.site IN ('789y')
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.islicensee = 0
		AND Enabled = 1 
		
	INSERT INTO #Member (CustID , Rule_RNGKeno)
	SELECT c.custid , s.Rule_RNGKeno
	FROM Custinfo c WITH (NOLOCK)
		INNER JOIN #supers s ON c.srecommend = s.custid AND s.Rule_RNGKeno IN (1,2)
	WHERE roleid = 1  AND Enabled = 1 AND c.custid > @max_custid
	UNION
	SELECT c.custid , s.Rule_RNGKeno
	FROM Custinfo c WITH (NOLOCK)
		INNER JOIN #supers s ON c.srecommend = s.custid AND s.Rule_RNGKeno =3
		INNER JOIN dbo.CustGameType cs WITH (NOLOCK) ON cs.CustID = c.custid
	WHERE roleid = 1  AND Enabled = 1 AND c.custid > @max_custid
		AND c.HideKeno = 1
		AND Enabled = 1 
		AND cs.IsDisabled = 0
		AND cs.GameTypeID BETWEEN 1 AND 99


	INSERT INTO #SMATemp (CustID, Rule_RNGKeno)
	SELECT c.custid, s.Rule_RNGKeno
	FROM Custinfo c WITH (NOLOCK)
		INNER JOIN #supers s ON c.srecommend = s.custid AND s.Rule_RNGKeno IN (1,2)
	WHERE c.roleid IN (2,3,4) AND Enabled = 1 AND c.custid > @max_custid 
	UNION
	SELECT c.custid, s.Rule_RNGKeno
	FROM Custinfo c WITH (NOLOCK)
		INNER JOIN #supers s ON c.srecommend = s.custid AND s.Rule_RNGKeno IN (3)
		INNER JOIN dbo.CustGameType cs WITH (NOLOCK) ON cs.CustID = c.custid
	WHERE c.roleid IN (2,3,4) AND Enabled = 1 AND c.custid > @max_custid 
		AND c.HideKeno = 1
		AND Enabled = 1 
		AND cs.IsDisabled = 0
		AND cs.GameTypeID BETWEEN 1 AND 99

	DECLARE @batch int = 3000

	WHILE EXISTS(SELECT TOP 1 1 FROM #SMATemp)
	BEGIN
		DELETE TOP (@batch) #SMATemp OUTPUT DELETED.CustID, DELETED.Rule_RNGKeno
		INTO #SMATempNew(CustID, Rule_RNGKeno)

		IF @@ROWCOUNT=0
			BREAK		

		--update hideKeno=1, miss update disabled=1 
		UPDATE cs
		SET cs.isDisabled = CASE WHEN @Rule_RNGKeno = 1 THEN 1 ELSE isDisabled END
		FROM CustGameType cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #SMATempNew b ON cs.CustID = b.CustID
		WHERE  GameTypeID BETWEEN 1 AND 31AND isDisabled = 0
		--update disabled=0 miss update hideKeno=0 
		UPDATE g 
		SET HideKeno = CASE WHEN @Rule_RNGKeno IN (2,3) THEN 0 ELSE HideKeno END 
		FROM dbo.CustInfo g WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #SMATempNew b ON g.CustID = b.CustID 

		TRUNCATE TABLE #SMATempNew
	END

	WHILE EXISTS(SELECT TOP 1 1 FROM #SMATemp)
	BEGIN
		DELETE TOP (@batch) #Member OUTPUT DELETED.CustID, DELETED.Rule_RNGKeno
		INTO #MemberTemp(CustID, Rule_RNGKeno)

		IF @@ROWCOUNT=0
			BREAK		

		--update hideKeno=1, miss update disabled=1 
		UPDATE cs
		SET cs.isDisabled = CASE WHEN @Rule_RNGKeno = 1 THEN 1 ELSE isDisabled END
		FROM CustGameType cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #MemberTemp b ON cs.CustID = b.CustID
		WHERE  GameTypeID BETWEEN 1 AND 31 AND isDisabled = 0
		--update disabled=0 miss update hideKeno=0 
		UPDATE g 
		SET HideKeno = CASE WHEN @Rule_RNGKeno  IN (2,3) THEN 0 ELSE HideKeno END 
		FROM dbo.CustInfo g WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #MemberTemp b ON g.CustID = b.CustID 

		TRUNCATE TABLE #MemberTemp
	END
	
	DROP TABLE #Member
	DROP TABLE #SMATemp
	DROP TABLE #supers
	DROP TABLE #MemberTemp
	DROP TABLE #SMATempNew
	DROP TABLE #supers_missHiden
	DROP TABLE #supers_missDis