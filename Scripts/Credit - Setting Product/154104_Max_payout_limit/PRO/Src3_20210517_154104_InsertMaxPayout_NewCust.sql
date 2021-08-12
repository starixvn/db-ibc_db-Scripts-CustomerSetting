/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Winfred
	Date: 20210518
	Task: Delete redundant data of Parlay Max Payout [Redmine: 154104]
	DB: DBCUST/CustDB
	
	P/s : Step 3 Delete redundant data
*/ 
 
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
	USE CustDB
	GO

	PRINT N'Step 3: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

	DECLARE @SportType SMALLINT
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
		AND ci.currency IN (2,3,5,6,7,9,12,13,15,16,22,33,34,35,41,43,45,47,50,51,52,53,54,57,58,64,67,69,71,81,95) 
	
	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,Currency INT,isfinished BIT DEFAULT(0)
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		Currency INT
	)

	INSERT INTO #MemberTemp (CustID,currency)
	SELECT custid,currency
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 1  AND Enabled = 1 AND custid > @MaxCustID
	
	INSERT INTO #SMATemp (CustID, currency)
	SELECT custid, currency
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @MaxCustID 

	DELETE cg
	FROM dbo.CustMaxPayoutSetting_Member cg WITH(ROWLOCK)
		INNER JOIN #MemberTemp s ON cg.custid = s.custid			
	WHERE cg.BetType = 9 AND cg.SportType in (1,99)
	
	DELETE cg
	FROM dbo.CustMaxPayoutSetting_Agent cg WITH(ROWLOCK)
		INNER JOIN #SMATemp s ON cg.custid = s.custid			
	WHERE cg.BetType = 9 AND cg.SportType in (1,99)
	-- Insert data
	INSERT INTO dbo.CustMaxPayoutSetting_Agent  (CustID,SportType,BetType,
						SingleMatchParlay,Combo2,Combo35,ComboOver6)
	SELECT a.CustID,mps.SportType,mps.BetType,
				mps.SingleMatchParlay,mps.Combo2,mps.Combo35,mps.ComboOver6
	FROM #SMATemp a 
	INNER JOIN MaxPayoutGlobalSetting mps with(nolock) on mps.Currency = a.Currency

	DECLARE @Cust_Temp TABLE(CustID INT,Currency INT)
	DECLARE @BatchSize SMALLINT = 5000
	
	WHILE(1 =1)
	BEGIN
		UPDATE TOP (@BatchSize) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID,DELETED.Currency INTO @Cust_Temp(CustID,Currency)
		FROM #MemberTemp c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0
		BEGIN 
			BREAK
		END 	

		INSERT INTO dbo.CustMaxPayoutSetting_Member  (CustID,SportType,BetType,
		SingleMatchParlay,Combo2,Combo35,ComboOver6)
		SELECT a.CustID,mps.SportType,mps.BetType,
					mps.SingleMatchParlay,mps.Combo2,mps.Combo35,mps.ComboOver6
		FROM @Cust_Temp a 
		INNER JOIN MaxPayoutGlobalSetting mps with(nolock) on mps.Currency = a.Currency
		
		DELETE FROM @Cust_Temp
	END
	
	PRINT N'Step 3: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
