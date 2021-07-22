/*
	Created: 20210610@Johnson
	Task: Migrate problem account from TVS to new source
	DB: DBCUST/CustDB
*/
		
	--initial data at DBCUST then sync data to replicated servers
	;WITH T AS (
			SELECT c.custid, tv.CreatedDate, tv.SubIssueTypeID
			FROM custinfo c WITH(NOLOCK)
				INNER JOIN DBACC.bodb02.dbo.TicketVoiding_VoidedTransaction tv WITH (NOLOCK) ON c.CustId = tv.custid			
			WHERE IssueTypeId = 11
				AND c.srecommend IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
				AND c.CustomerClass BETWEEN 8 AND 13
				AND c.Enabled = 1
			UNION 
			SELECT c.custid, tv.CreatedDate, tv.SubIssueTypeID
			FROM custinfo c WITH(NOLOCK)
				INNER JOIN DBACC.bodb_Archive.dbo.TicketVoiding_VoidedTransaction_bk tv WITH (NOLOCK) ON c.CustId = tv.custid			
			WHERE IssueTypeId = 11
				AND c.srecommend IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
				AND c.CustomerClass BETWEEN 8 AND 13
				AND c.Enabled = 1
		)
	SELECT *, 0 isFinished 
	INTO #tmpCust
	FROM t	
	WHERE CreatedDate < '2021-07-22 02:41:55.970'--mindate Dep_CustCategoryHistory
	ORDER BY CreatedDate asc

	CREATE TABLE #tmpMappingReason(CustomerClass INT, SubIssueTypeID INT, CategoryID INT)

	INSERT INTO #tmpMappingReason(CustomerClass,SubIssueTypeID,CategoryID)
	SELECT 	8	,	28	,	52	--	Group Betting
	UNION SELECT 	10	,	29	,	53	--	Hedging
	UNION SELECT 	9	,	30	,	54	--	Arbitrage
	UNION SELECT 	10	,	31	,	55	--	Fixed Game
	UNION SELECT 	11	,	32	,	56	--	AB Bet
	UNION SELECT 	13	,	36	,	57	--	Robot Betting
	UNION SELECT 	9	,	37	,	58	--	Irrigation Bet
	UNION SELECT 	10	,	38	,	59	--	System Formula Bet
	
	DECLARE @tmp TABLE (custid INT, SubIssueTypeID INT, CreatedDate DATETIME)
	
	--142203 row(s) affected
	WHILE(1=1)
	BEGIN
		DELETE @tmp
		
		UPDATE TOP(500) t
		SET isFinished = 1
		OUTPUT DELETED.custid,DELETED.SubIssueTypeID,DELETED.CreatedDate INTO @tmp(custid,SubIssueTypeID,CreatedDate)
		FROM #tmpCust t
		WHERE isFinished = 0
			
		IF @@ROWCOUNT = 0 
			RETURN;
			
		INSERT INTO Dep_CustCategoryHistory (custid,CategoryID,CustomerClass,CreatedDate)
		SELECT t.CustID, r.CategoryID, r.CustomerClass, t.CreatedDate
		FROM @tmp t
			INNER JOIN #tmpMappingReason r ON t.SubIssueTypeID = r.SubIssueTypeID
		
		WAITFOR DELAY '0:0:0.5'
	END