/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Winfred
	Date: 20210223
	Task: Delete redundant data of Sports Lottery [Redmine: 147361]
	DB: DBCUST/CustDB
	
	P/s : Step 5 Delete redundant data
*/ 
 
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
	USE CustDB
	GO

	PRINT N'Step 5: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

	DECLARE @SportType SMALLINT
	DECLARE @MaxCustID INT
		
	SELECT @MaxCustID = xxx
	
	IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;
	
	CREATE TABLE #supers (custid INT)
	SELECT @Sporttype = 169

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
		AND ci.currency NOT IN (20,72) -- UUS, YNG

	DELETE cg
	FROM dbo.CustPTSetting3rd_Agent cg WITH(ROWLOCK)	
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid		
	WHERE SportType = @SportType
		AND cg.custid > @maxcustID

	DELETE cg
	FROM dbo.CustPTSetting3rd_Member cg WITH(ROWLOCK)
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid			
	WHERE SportType = @SportType
		AND cg.custid > @maxcustID

	DELETE cg
	FROM dbo.CustPTGroupSetting3rd_Member cg WITH(ROWLOCK)
		INNER JOIN Customer c WITH (NOLOCK) ON cg.AgentID= c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid			
	WHERE SportType = @SportType
		AND cg.AgentID > @maxcustID
	
	DELETE cg
	FROM dbo.CustBetSetting3rd_Member cg WITH(ROWLOCK)	
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid		
	WHERE SportType = @SportType
		AND cg.custid > @maxcustID

	DELETE cg
	FROM dbo.CustBetSetting3rd_Agent cg WITH(ROWLOCK)
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid			
	WHERE SportType = @SportType
		AND cg.custid > @maxcustID

	DELETE cg
	FROM dbo.CustWinLossLimit_Agent cg WITH(ROWLOCK)	
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid		
	WHERE SportType = @SportType
		AND cg.custid > @maxcustID

	DELETE cg
	FROM dbo.CustWinLossLimit_Member cg WITH(ROWLOCK)	
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid		
	WHERE SportType = @SportType
		AND cg.custid > @maxcustID
	
	PRINT N'Step 5: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
