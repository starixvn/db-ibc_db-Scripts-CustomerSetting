/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tina
	Date: 2021-05-31
	Task: Adjust table CustProductStatus for real account [RedmineID: 148600]
	DB: DBCust/CustDB
*/
USE [CustDB]
GO

	CREATE TABLE #tblCust_Update (CustID INT PRIMARY KEY, Locked TINYINT, CloseInfo TINYINT, IsFinished BIT DEFAULT 0)	
	CREATE TABLE #tblCust_Batch (CustID INT PRIMARY KEY, Locked TINYINT, CloseInfo TINYINT)	
	CREATE TABLE #tmpAgent (CustID INT PRIMARY KEY, RoleID INT, mrecommend INT, srecommend INT, Locked TINYINT, CloseInfo TINYINT)

	INSERT INTO #tmpAgent(CustID, RoleID, mrecommend, srecommend, Locked, CloseInfo)
	SELECT ci.custid, ci.roleid, ci.mrecommend, ci.srecommend, 
			(CASE WHEN ci.closed = 1 AND ci.[Enabled] = 1 AND ISNULL(cl.ClosedReason,0) = 0 THEN 2
					WHEN ci.closed = 1 AND ci.[Enabled] = 1 AND cl.ClosedReason = 3 THEN 1 
					ELSE 0 END) AS Locked,
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
	
	;WITH tmpAgentCloseInfo AS
	(
		SELECT ps.custid, t.Locked,
		CASE WHEN t.RoleID = 2 THEN ISNULL(t.CloseInfo, 0) + ISNULL(M.CloseInfo, 0) + ISNULL(S.CloseInfo, 0)
								WHEN t.RoleID = 3 THEN ISNULL(t.CloseInfo, 0) + ISNULL(S.CloseInfo, 0)
								WHEN t.RoleID = 4 THEN t.CloseInfo END CloseInfo
		FROM custProductStatus ps WITH(NOLOCK)
			INNER JOIN #tmpAgent t ON ps.custid = t.custid
			INNER JOIN #tmpAgent S ON S.CustID = t.srecommend
			LEFT JOIN #tmpAgent M ON M.CustID = t.mrecommend
	)
	INSERT INTO #tblCust_Update(CustID, Locked, CloseInfo)
	SELECT ci.CustID, ci.Locked, ci.CloseInfo
	FROM tmpAgentCloseInfo ci
		INNER JOIN CustProductStatus cps WITH (NOLOCK) ON cps.CustID = ci.CustID
	WHERE ci.Locked <> ISNULL(cps.Locked,0) OR ci.CloseInfo <> ISNULL(cps.CloseInfo,0)

	;WITH tmpMember AS
	(
		SELECT ci.custid, ci.roleid, ci.recommend, ci.mrecommend, ci.srecommend, 
				(CASE WHEN ci.closed = 1 AND ci.[Enabled] = 1 AND ISNULL(cl.ClosedReason,0) = 0 THEN 2
					 WHEN ci.closed = 1 AND ci.[Enabled] = 1 AND cl.ClosedReason = 3 THEN 1 
					 ELSE 0 END) AS Locked,
				(CASE WHEN ci.closed = 1 AND ci.[Enabled] = 1 AND ISNULL(cl.ClosedReason,0) IN (0,3) THEN 0
					 ELSE ci.closed END) AS Closed,
				(CASE WHEN ci.closed = 1 AND ci.[Enabled] = 1 AND ISNULL(cl.ClosedReason,0) IN (0,3) THEN 0
					  ELSE CAST(ci.closed AS TINYINT) END
				) AS CloseInfo
		FROM CustProductStatus cps WITH(NOLOCK)
			INNER JOIN custInfo ci WITH(NOLOCK) ON ci.custid = cps.CustID
			LEFT JOIN CustLoginInfo_Member cl WITH (NOLOCK) ON ci.custid = cl.CustID
		WHERE ci.srecommend NOT IN (SELECT CustID FROM Dep_CustSuper WITH (NOLOCK))
			AND ci.roleid = 1
	), tmpMemberCloseInfo AS
	(
		SELECT ps.custid, t.Locked,
			ISNULL(t.CloseInfo, 0) + ISNULL(A.CloseInfo, 0) + ISNULL(M.CloseInfo, 0) + ISNULL(S.CloseInfo, 0) AS CloseInfo
		FROM custProductStatus ps WITH(NOLOCK)
			INNER JOIN tmpMember t ON ps.custid = t.custid
			INNER JOIN #tmpAgent S ON S.CustID = t.srecommend
			INNER JOIN #tmpAgent M ON M.CustID = t.mrecommend
			INNER JOIN #tmpAgent A ON A.CustID = t.recommend
	)
	INSERT INTO #tblCust_Update(CustID, Locked, CloseInfo)
	SELECT ci.CustID, ci.Locked, ci.CloseInfo
	FROM tmpMemberCloseInfo ci
		INNER JOIN CustProductStatus cps WITH (NOLOCK) ON cps.CustID = ci.CustID
	WHERE ci.Locked <> ISNULL(cps.Locked, 0) OR ci.CloseInfo <> ISNULL(cps.CloseInfo, 0)

	--Adjust data	
	WHILE (1=1)
	BEGIN			
		UPDATE TOP (2000) c SET c.IsFinished = 1
		OUTPUT deleted.CustID, deleted.Locked, deleted.CloseInfo
		INTO #tblCust_Batch(CustID, Locked, CloseInfo)
		FROM #tblCust_Update c
		WHERE c.IsFinished = 0
		
		IF @@ROWCOUNT = 0
			BREAK

		UPDATE ps
		SET ps.Locked = t.Locked,
			ps.CloseInfo = t.CloseInfo
		FROM custProductStatus ps WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tblCust_Batch t ON ps.custid = t.custid
			
		
		DELETE #tblCust_Batch

		RAISERROR ('Total of Agent: %d.', 0, 1, @@ROWCOUNT) WITH NOWAIT

		WAITFOR DELAY '0:0:1.00'
	END

	DROP TABLE #tblCust_Update
	DROP TABLE #tblCust_Batch
