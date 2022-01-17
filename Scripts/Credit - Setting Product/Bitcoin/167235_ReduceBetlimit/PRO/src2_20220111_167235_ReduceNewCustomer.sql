/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Winfred
	Date: 20220112
	Task: Bitcoin - Reduce bet limit setting [Redmine: 167235]
	DB: DBCUST/CustDB
	
	P/s : Step 2 Reduce bet limit for newly created customer
*/ 
 
 -- BEGIN STEP 2: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
	USE CustDB
	GO

	PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  


	DECLARE @MaxCustID INT
	SELECT @MaxCustID = xxx
	
	IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;
	
	CREATE TABLE #supers (custid INT)
	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM customer ci WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
		LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.islicensee = 0			
		AND ci.Site<>'CN88'
		AND ci.currency IN ( 2,3,5,6,7,9,12,13,15,16,22,33,34,35,41,42,43,45,47,50,51,52,53,54,57,58,64,67,69,71,81,95)
		--RM,US$,HK$,EURO,DON,AUD,GBP,RMB,IN,Yen,IND,IDD,IDR,$US,CHF,PE,THB,Won,DDD,CAN,INH,DKK,SEK,NOK,CZK,RON,UT,HKK,MMK,KHR,CY,USD

	DECLARE @Sporttype INT = 175  ,@Bettype INT  = 7901 

	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		Currency INT,
		InsBetSetting BIT DEFAULT 0
	)
	
	CREATE TABLE #MemberTempIns
	(
		CustID INT PRIMARY KEY CLUSTERED,
		Currency INT
	)
	
	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		Currency INT,
		roleid TINYINT
	)

	INSERT INTO #MemberTemp (CustID,Currency)
	SELECT custid,Currency
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 1  AND Enabled = 1 AND custid > @MaxCustID
	
	INSERT INTO #SMATemp (CustID,Currency, roleid)
	SELECT custid,Currency, roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @MaxCustID 
	

	CREATE TABLE #ProductBetSetting (Currency INT,MinBet	MONEY,MaxBet	MONEY,MaxPerMatch	MONEY,
									SuperMinBet	MONEY,SuperMaxBet	MONEY,SuperMaxPerMatch	MONEY,Sporttype INT DEFAULT(175), Bettype INT DEFAULT(7901))
					
	INSERT INTO #ProductBetSetting(Currency,MinBet,MaxBet,MaxPerMatch,SuperMinBet,SuperMaxBet,SuperMaxPerMatch)
	SELECT 2 AS Currency ,5 AS MinBet,1000 AS MaxBet,3000 AS MaxPerMatch,5 AS SuperMinBet,1000 AS SuperMaxBet,3000 AS SuperMaxPerMatch  Union ALL --RM
	SELECT 3 AS Currency ,3 AS MinBet,300 AS MaxBet,900 AS MaxPerMatch,3 AS SuperMinBet,300 AS SuperMaxBet,900 AS SuperMaxPerMatch  Union ALL --US$
	SELECT 5 AS Currency ,10 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,10 AS SuperMinBet,2000 AS SuperMaxBet,6000 AS SuperMaxPerMatch  Union ALL --HK$
	SELECT 6 AS Currency ,2 AS MinBet,200 AS MaxBet,600 AS MaxPerMatch,2 AS SuperMinBet,200 AS SuperMaxBet,600 AS SuperMaxPerMatch  Union ALL --EURO
	SELECT 7 AS Currency ,25000 AS MinBet,5000000 AS MaxBet,15000000 AS MaxPerMatch,25000 AS SuperMinBet,5000000 AS SuperMaxBet,15000000 AS SuperMaxPerMatch  Union ALL --DON
	SELECT 9 AS Currency ,3 AS MinBet,300 AS MaxBet,900 AS MaxPerMatch,3 AS SuperMinBet,300 AS SuperMaxBet,900 AS SuperMaxPerMatch  Union ALL --AUD
	SELECT 12 AS Currency ,2 AS MinBet,200 AS MaxBet,600 AS MaxPerMatch,2 AS SuperMinBet,200 AS SuperMaxBet,600 AS SuperMaxPerMatch  Union ALL --GBP
	SELECT 13 AS Currency ,10 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,10 AS SuperMinBet,2000 AS SuperMaxBet,6000 AS SuperMaxPerMatch  Union ALL --RMB
	SELECT 15 AS Currency ,25 AS MinBet,4000 AS MaxBet,12000 AS MaxPerMatch,25 AS SuperMinBet,4000 AS SuperMaxBet,12000 AS SuperMaxPerMatch  Union ALL --IN
	SELECT 16 AS Currency ,3 AS MinBet,300 AS MaxBet,900 AS MaxPerMatch,3 AS SuperMinBet,300 AS SuperMaxBet,900 AS SuperMaxPerMatch  Union ALL --Yen
	SELECT 22 AS Currency ,25 AS MinBet,4000 AS MaxBet,12000 AS MaxPerMatch,25 AS SuperMinBet,4000 AS SuperMaxBet,12000 AS SuperMaxPerMatch  Union ALL --IND
	SELECT 33 AS Currency ,25 AS MinBet,4000 AS MaxBet,12000 AS MaxPerMatch,25 AS SuperMinBet,4000 AS SuperMaxBet,12000 AS SuperMaxPerMatch  Union ALL --IDD
	SELECT 34 AS Currency ,25 AS MinBet,4000 AS MaxBet,12000 AS MaxPerMatch,25 AS SuperMinBet,4000 AS SuperMaxBet,12000 AS SuperMaxPerMatch  Union ALL --IDR
	SELECT 35 AS Currency ,3 AS MinBet,300 AS MaxBet,900 AS MaxPerMatch,3 AS SuperMinBet,300 AS SuperMaxBet,900 AS SuperMaxPerMatch  Union ALL --$US
	SELECT 41 AS Currency ,2 AS MinBet,200 AS MaxBet,600 AS MaxPerMatch,2 AS SuperMinBet,200 AS SuperMaxBet,600 AS SuperMaxPerMatch  Union ALL --CHF
	SELECT 42 AS Currency ,120 AS MinBet,12000 AS MaxBet,36000 AS MaxPerMatch,120 AS SuperMinBet,12000 AS SuperMaxBet,36000 AS SuperMaxPerMatch  Union ALL --PE
	SELECT 43 AS Currency ,100 AS MinBet,8000 AS MaxBet,24000 AS MaxPerMatch,100 AS SuperMinBet,8000 AS SuperMaxBet,24000 AS SuperMaxPerMatch  Union ALL --THB
	SELECT 45 AS Currency ,2500 AS MinBet,300000 AS MaxBet,900000 AS MaxPerMatch,2500 AS SuperMinBet,300000 AS SuperMaxBet,900000 AS SuperMaxPerMatch  Union ALL --Won
	SELECT 47 AS Currency ,25 AS MinBet,4000 AS MaxBet,12000 AS MaxPerMatch,25 AS SuperMinBet,4000 AS SuperMaxBet,12000 AS SuperMaxPerMatch  Union ALL --DDD
	SELECT 50 AS Currency ,3 AS MinBet,300 AS MaxBet,900 AS MaxPerMatch,3 AS SuperMinBet,300 AS SuperMaxBet,900 AS SuperMaxPerMatch  Union ALL --CAN
	SELECT 51 AS Currency ,25 AS MinBet,5000 AS MaxBet,15000 AS MaxPerMatch,25 AS SuperMinBet,5000 AS SuperMaxBet,15000 AS SuperMaxPerMatch  Union ALL --INH
	SELECT 52 AS Currency ,15 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,15 AS SuperMinBet,2000 AS SuperMaxBet,6000 AS SuperMaxPerMatch  Union ALL --DKK
	SELECT 53 AS Currency ,15 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,15 AS SuperMinBet,2000 AS SuperMaxBet,6000 AS SuperMaxPerMatch  Union ALL --SEK
	SELECT 54 AS Currency ,15 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,15 AS SuperMinBet,2000 AS SuperMaxBet,6000 AS SuperMaxPerMatch  Union ALL --NOK
	SELECT 57 AS Currency ,50 AS MinBet,5000 AS MaxBet,15000 AS MaxPerMatch,50 AS SuperMinBet,5000 AS SuperMaxBet,15000 AS SuperMaxPerMatch  Union ALL --CZK
	SELECT 58 AS Currency ,10 AS MinBet,1000 AS MaxBet,3000 AS MaxPerMatch,10 AS SuperMinBet,1000 AS SuperMaxBet,3000 AS SuperMaxPerMatch  Union ALL --RON
	SELECT 64 AS Currency ,3 AS MinBet,300 AS MaxBet,900 AS MaxPerMatch,3 AS SuperMinBet,300 AS SuperMaxBet,900 AS SuperMaxPerMatch  Union ALL --UT
	SELECT 67 AS Currency ,5 AS MinBet,1000 AS MaxBet,3000 AS MaxPerMatch,5 AS SuperMinBet,1000 AS SuperMaxBet,3000 AS SuperMaxPerMatch  Union ALL --HKK
	SELECT 69 AS Currency ,4 AS MinBet,360 AS MaxBet,1080 AS MaxPerMatch,4 AS SuperMinBet,360 AS SuperMaxBet,1080 AS SuperMaxPerMatch  Union ALL --MMK
	SELECT 71 AS Currency ,10 AS MinBet,1000 AS MaxBet,3000 AS MaxPerMatch,10 AS SuperMinBet,1000 AS SuperMaxBet,3000 AS SuperMaxPerMatch  Union ALL --KHR
	SELECT 81 AS Currency ,10 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,10 AS SuperMinBet,2000 AS SuperMaxBet,6000 AS SuperMaxPerMatch  Union ALL --CY
	SELECT 95 AS Currency ,3 AS MinBet,300 AS MaxBet,900 AS MaxPerMatch,3 AS SuperMinBet,300 AS SuperMaxBet,900 AS SuperMaxPerMatch			 --USD
		
--------------------------------------Bet Setting-------------------------------------------------
	--SMA level
	UPDATE cs
	SET cs.MaxBet = CASE WHEN ci.roleid  = 4 THEN (CASE WHEN cs.MaxBet >  ps.SuperMaxBet  THEN ps.SuperMaxBet ELSE cs.MaxBet END)
											 ELSE (CASE WHEN cs.MaxBet >  ps.MaxBet  THEN ps.MaxBet ELSE cs.MaxBet END) END,
		cs.MaxPerMatch = CASE WHEN ci.roleid  = 4 THEN (CASE WHEN cs.MaxPerMatch >  ps.SuperMaxPerMatch  THEN ps.SuperMaxPerMatch ELSE cs.MaxPerMatch END)
											 ELSE (CASE WHEN cs.MaxPerMatch >  ps.MaxPerMatch  THEN ps.MaxPerMatch ELSE cs.MaxPerMatch END) END		
	FROM dbo.CustBetSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #SMATemp ci ON cs.CustID = ci.CustID
	INNER JOIN #ProductBetSetting ps ON cs.SportType = ps.Sporttype AND cs.BetType = ps.Bettype AND ps.Currency = ci.Currency
	WHERE ((ci.roleid  = 4 AND (cs.MaxBet >  ps.SuperMaxBet OR cs.MaxPerMatch > PS.SuperMaxPerMatch)) OR 
		  (ci.roleid  IN (2,3) AND (cs.MaxBet >  ps.MaxBet OR cs.MaxPerMatch > PS.MaxPerMatch)) )
	
	--Member Level
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #MemberTempIns
		UPDATE TOP (3000)  t SET t.InsBetSetting = 1 OUTPUT DELETED.CustID,DELETED.Currency INTO #MemberTempIns(CustID,Currency) FROM #MemberTemp t WHERE t.InsBetSetting = 0
		
		IF @@ROWCOUNT=0
			BREAK
			
		--Member Level	
		UPDATE cs
		SET cs.MaxBet = CASE WHEN cs.MaxBet >  ps.MaxBet  THEN ps.MaxBet ELSE cs.MaxBet END,
			cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch >  ps.MaxPerMatch  THEN ps.MaxPerMatch ELSE cs.MaxPerMatch END	
		FROM dbo.CustBetSetting3rd_Member cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #MemberTempIns ci ON cs.CustID = ci.CustID
		INNER JOIN #ProductBetSetting ps ON cs.SportType = ps.Sporttype AND cs.BetType = ps.Bettype AND ps.Currency = ci.Currency
		WHERE cs.MaxBet >  ps.MaxBet OR cs.MaxPerMatch > PS.MaxPerMatch 
		
	END

	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
	DROP TABLE #ProductBetSetting
	
	PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
