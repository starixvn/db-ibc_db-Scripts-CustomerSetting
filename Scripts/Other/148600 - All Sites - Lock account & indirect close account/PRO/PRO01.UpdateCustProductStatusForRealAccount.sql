/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tina
	Date: 2021-05-31
	Task: update table CustProductStatus for real account [RedmineID: 148600]
	DB: DBCust/CustDB
*/
USE [CustDB]
GO
	DECLARE @max_custid INT = xxx 


	CREATE TABLE #tblCust_Agent (CustID INT PRIMARY KEY, RoleID TINYINT, mrecommend INT, srecommend INT, Locked TINYINT, Closed BIT, ClosedInfo TINYINT, IsFinished BIT DEFAULT 0)	
	CREATE TABLE #tblCust_Member (CustID INT PRIMARY KEY, RoleID TINYINT, recommend INT, mrecommend INT, srecommend INT, Locked TINYINT, Closed BIT, ClosedInfo TINYINT, IsFinished BIT DEFAULT 0)

	CREATE TABLE #tblCust_AgentBatch (CustID INT PRIMARY KEY, RoleID TINYINT, mrecommend INT, srecommend INT, Locked TINYINT, Closed BIT, ClosedInfo TINYINT)	
	CREATE TABLE #tblCust_MemberBatch (CustID INT PRIMARY KEY, RoleID TINYINT, recommend INT, mrecommend INT, srecommend INT, Locked TINYINT, Closed BIT, ClosedInfo TINYINT)	

	INSERT INTO #tblCust_Agent(CustID, Roleid, mrecommend, srecommend, Locked, Closed, ClosedInfo)
	SELECT ci.custid, ci.roleid, ci.mrecommend, ci.srecommend, 
			(CASE WHEN ci.closed = 1 AND ci.[Enabled] = 1 AND ISNULL(cl.ClosedReason,0) = 0 THEN 2
				 WHEN ci.closed = 1 AND ci.[Enabled] = 1 AND cl.ClosedReason = 3 THEN 1 
				 ELSE 0 END) AS Locked,
			(CASE WHEN ci.closed = 1 AND ci.[Enabled] = 1 AND ISNULL(cl.ClosedReason,0) IN (0,3) THEN 0
				 ELSE ci.closed END) AS Closed,
			(CASE WHEN ci.closed = 1 AND ci.[Enabled] = 1 AND ISNULL(cl.ClosedReason,0) IN (0,3) THEN 0
				  WHEN ci.closed = 1 AND ci.RoleID = 4 THEN 8 
				  WHEN ci.closed = 1 AND ci.RoleID = 3 THEN 4
				  WHEN ci.closed = 1 AND ci.RoleID = 2 THEN 2 
				  ELSE CAST(ci.closed AS TINYINT) END
			) AS CloseInfo
	FROM CustProductStatus cps WITH(NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) ON ci.custid = cps.CustID
		LEFT JOIN CustLoginInfo cl WITH (NOLOCK) ON ci.custid = cl.CustID
	WHERE ci.srecommend NOT IN (SELECT CustID FROM Dep_CustSuper WITH (NOLOCK))
		AND ci.roleid IN (2,3,4)
		AND 1 = CASE WHEN ci.currency <> 20 AND ci.custid <= @max_custid  THEN 1
					 WHEN ci.currency = 20 AND ci.srecommend NOT IN (52786885,52786933,52786934,52786948,52786949,52786954,52786956,52786961,38268801,47447605,46337216,45080424,52786964,34027396,25659077) 
						AND ci.custid <= @max_custid THEN 1
					 ELSE 0
				END


	INSERT INTO #tblCust_Member(CustID, Roleid, recommend, mrecommend, srecommend, Locked, Closed, ClosedInfo)
	SELECT ci.custid, ci.roleid, ci.recommend, ci.mrecommend, ci.srecommend,
			(CASE WHEN ci.closed = 1 AND ci.[Enabled] = 1 AND ISNULL(cl.ClosedReason,0) = 0 THEN 2
				 WHEN ci.closed = 1 AND ci.[Enabled] = 1 AND cl.ClosedReason = 3 THEN 1 
				 ELSE 0 END) AS Locked,
			(CASE WHEN ci.closed = 1 AND ci.[Enabled] = 1 AND ISNULL(cl.ClosedReason,0) IN (0,3) THEN 0
				 ELSE ci.closed END) AS Closed,
			(CASE WHEN ci.closed = 1 AND ci.[Enabled] = 1 AND ISNULL(cl.ClosedReason,0) IN (0,3) THEN 0
				 ELSE CAST(ci.closed AS TINYINT) END) AS ClosedInfo
	FROM CustProductStatus cps WITH(NOLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK) ON ci.custid = cps.CustID
		LEFT JOIN CustLoginInfo_Member cl WITH (NOLOCK) ON ci.custid = cl.CustID
	WHERE ci.srecommend NOT IN (SELECT CustID FROM Dep_CustSuper WITH (NOLOCK))
		AND ci.roleid = 1
		AND 1 = CASE WHEN ci.currency <> 20 AND ci.custid <= @max_custid  THEN 1
					 WHEN ci.currency = 20 AND ci.srecommend NOT IN (52786885,52786933,52786934,52786948,52786949,52786954,52786956,52786961,38268801,47447605,46337216,45080424,52786964,34027396,25659077) 
						AND ci.custid <= @max_custid THEN 1
					 ELSE 0
				END
	
	--UPDATE Agent	
	WHILE (1=1)
	BEGIN			
		
		UPDATE TOP (2000) c SET c.IsFinished = 1
		OUTPUT deleted.CustID, deleted.RoleID, deleted.mrecommend, deleted.srecommend, deleted.Locked, deleted.Closed, deleted.ClosedInfo
		INTO #tblCust_AgentBatch(CustID, RoleID, mrecommend, srecommend, Locked, Closed, ClosedInfo)
		FROM #tblCust_Agent c
		WHERE c.IsFinished = 0
		
		IF @@ROWCOUNT = 0
			BREAK

		UPDATE ps
		SET ps.Locked = t.Locked,
			ps.CloseInfo = CASE WHEN t.RoleID = 2 THEN ISNULL(t.ClosedInfo, 0) + ISNULL(M.ClosedInfo, 0) + ISNULL(S.ClosedInfo, 0)
								WHEN t.RoleID = 3 THEN ISNULL(t.ClosedInfo, 0) + ISNULL(S.ClosedInfo, 0)
								WHEN t.RoleID = 4 THEN t.ClosedInfo END
		FROM custProductStatus ps WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tblCust_AgentBatch t ON ps.custid = t.custid
			INNER JOIN #tblCust_Agent S ON S.CustID = t.srecommend
			LEFT JOIN #tblCust_Agent M ON M.CustID = t.mrecommend
		
		DELETE #tblCust_AgentBatch

		RAISERROR ('Total of Agent: %d.', 0, 1, @@ROWCOUNT) WITH NOWAIT

		WAITFOR DELAY '0:0:1.00'
	END

	--UPDATE member

	WHILE (1=1)
	BEGIN			
		
		UPDATE TOP (2000) c SET c.IsFinished = 1
		OUTPUT deleted.CustID, deleted.RoleID, deleted.recommend, deleted.mrecommend, deleted.srecommend, deleted.Locked, deleted.Closed, deleted.ClosedInfo
		INTO #tblCust_MemberBatch(CustID, RoleID, recommend, mrecommend, srecommend, Locked, Closed, ClosedInfo)
		FROM #tblCust_Member c
		WHERE c.IsFinished = 0
		
		IF @@ROWCOUNT = 0
			BREAK

		UPDATE ps
		SET ps.Locked = t.Locked,
			ps.CloseInfo = ISNULL(t.ClosedInfo, 0) + ISNULL(A.ClosedInfo, 0) + ISNULL(M.ClosedInfo, 0) + ISNULL(S.ClosedInfo, 0)
		FROM custProductStatus ps WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tblCust_MemberBatch t ON ps.custid = t.custid
			INNER JOIN #tblCust_Agent A ON A.CustID = t.recommend
			INNER JOIN #tblCust_Agent M ON M.CustID = t.mrecommend
			INNER JOIN #tblCust_Agent S ON S.CustID = t.srecommend

		DELETE #tblCust_MemberBatch
		RAISERROR ('Total of members: %d.', 0, 1, @@ROWCOUNT) WITH NOWAIT
		WAITFOR DELAY '0:0:1.00'
	END
	
	DROP TABLE #tblCust_Agent
	DROP TABLE #tblCust_AgentBatch
	DROP TABLE #tblCust_Member
	DROP TABLE #tblCust_MemberBatch
