/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Winfred
	Date: 20210806
	Task: Delete redundant data of Bitcoin [Redmine: 159039]
	DB: DBCUST/CustDB
	
	P/s : Step 6 Delete redundant data
*/ 
 
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
	USE CustDB
	GO

	PRINT N'Step 6: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

	DECLARE @SportType SMALLINT,@betType SMALLINT
	DECLARE @MaxCustID INT
		
	SELECT @MaxCustID = xxx
	
	IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;
	
	CREATE TABLE #supers (custid INT)
	SELECT @Sporttype = 175 , @betType = 7901 

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

	DELETE cg
	FROM dbo.CustPTSetting3rd_Agent cg WITH(ROWLOCK)	
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid		
	WHERE SportType = @SportType AND BetType = @betType
		AND cg.custid > @maxcustID

	DELETE cg
	FROM dbo.CustPTSetting3rd_Member cg WITH(ROWLOCK)
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid			
	WHERE SportType = @SportType AND BetType = @betType
		AND cg.custid > @maxcustID

	DELETE cg
	FROM dbo.CustPTGroupSetting3rd_Member cg WITH(ROWLOCK)
		INNER JOIN Customer c WITH (NOLOCK) ON cg.AgentID= c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid			
	WHERE SportType = @SportType AND BetType = @betType
		AND cg.AgentID > @maxcustID
	
	DELETE cg
	FROM CustDiscount3rd_Member cg WITH(ROWLOCK)	
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid		
	WHERE SportType = @SportType AND BetType = @betType
		AND cg.custid > @maxcustID

	DELETE cg
	FROM dbo.CustDiscount3rd_Agent cg WITH(ROWLOCK)
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid			
	WHERE SportType = @SportType AND BetType = @betType
		AND cg.custid > @maxcustID
		
	DELETE cg
	FROM dbo.CustBetSetting3rd_Member cg WITH(ROWLOCK)	
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid		
	WHERE SportType = @SportType AND BetType = @betType
		AND cg.custid > @maxcustID

	DELETE cg
	FROM dbo.CustBetSetting3rd_Agent cg WITH(ROWLOCK)
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid			
	WHERE SportType = @SportType AND BetType = @betType
		AND cg.custid > @maxcustID

	DELETE cg
	FROM dbo.CustWinLossLimit_Agent cg WITH(ROWLOCK)	
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid		
	WHERE SportType = @SportType AND BetType = @betType
		AND cg.custid > @maxcustID

	DELETE cg
	FROM dbo.CustWinLossLimit_Member cg WITH(ROWLOCK)	
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid		
	WHERE SportType = @SportType AND BetType = @betType
		AND cg.custid > @maxcustID
	
	PRINT N'Step 6: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
