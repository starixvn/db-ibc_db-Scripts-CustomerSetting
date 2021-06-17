/*
	Created: 20210610@Johnson
	Task: Migrate problem account from TVS to new source
	DB: DBCUST/CustDB
*/
		
	--initial data at DBCUST then sync data to replicated servers
	;WITH T AS (
			SELECT c.custid, tv.CreatedDate, tv.SubIssueTypeID
			FROM custinfo c WITH(NOLOCK)
				INNER JOIN DBACC.bod02.dbo.TicketVoiding_VoidedTransaction tv WITH (NOLOCK) ON c.CustId = tv.custid			
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
	SELECT * 
	INTO #tmp
	FROM t	

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

	--142203 row(s) affected
	INSERT INTO Dep_CustCategoryHistory (custid,CategoryID,CustomerClass,CreatedDate)
	SELECT t.CustID, r.CategoryID, r.CustomerClass, t.CreatedDate
	FROM #tmp t
		INNER JOIN #tmpMappingReason r ON t.SubIssueTypeID = r.SubIssueTypeID
	ORDER BY CreatedDate ASC
