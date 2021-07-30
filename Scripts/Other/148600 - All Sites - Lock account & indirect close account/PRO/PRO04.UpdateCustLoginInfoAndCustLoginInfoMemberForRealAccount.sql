/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tina
	Date: 2021-05-19
	Task: update table CustLoginInfo and CustLoginInfo_Member for real account [RedmineID: 148600]
	DB: DBCust/CustDB
*/
USE [CustDB]
GO
	DECLARE @max_custid INT = 53582916 --get from Daniel on 22 July,2021

	CREATE TABLE #tblCust_Agent (CustID INT PRIMARY KEY, ClosedReason TINYINT NULL, IsFinished BIT DEFAULT 0)	
	CREATE TABLE #tblCust_Member (CustID INT PRIMARY KEY, ClosedReason TINYINT NULL, IsFinished BIT DEFAULT 0)

	CREATE TABLE #tblCust_AgentBatch (CustID INT PRIMARY KEY)	
	CREATE TABLE #tblCust_MemberBatch (CustID INT PRIMARY KEY)	

	
	INSERT INTO #tblCust_Agent(CustID, ClosedReason)
	SELECT ci.custid, cl.ClosedReason
	FROM CustLoginInfo cl WITH (NOLOCK)
		INNER JOIN custInfo ci WITH (NOLOCK) ON cl.CustID = ci.custid
		INNER JOIN CustProductStatus cps WITH (NOLOCK) ON ci.custid = cps.CustID
	WHERE ci.srecommend NOT IN (SELECT CustID FROM Dep_CustSuper WITH (NOLOCK))
		AND ci.roleid IN (2,3,4)
		AND cl.ClosedReason IN (0,3)
		AND cps.CloseInfo = 0
		AND ci.[Enabled] = 1
		AND 1 = CASE WHEN ci.currency <> 20 AND ci.custid <= @max_custid  THEN 1
					 WHEN ci.currency = 20 AND ci.srecommend NOT IN (52786885,52786933,52786934,52786948,52786949,52786954,52786956,52786961,38268801,47447605,46337216,45080424,52786964,34027396,25659077) AND ci.custid <= @max_custid THEN 1
					 ELSE 0
				END

	INSERT INTO #tblCust_Member(CustID, ClosedReason)
	SELECT ci.custid, cl.ClosedReason
	FROM CustLoginInfo_Member cl WITH (NOLOCK)
		INNER JOIN custInfo ci WITH (NOLOCK) ON cl.CustID = ci.custid
		INNER JOIN CustProductStatus cps WITH (NOLOCK) ON cps.custid = ci.CustID
	WHERE ci.srecommend NOT IN (SELECT CustID FROM Dep_CustSuper WITH (NOLOCK))
		AND ci.roleid = 1
		AND cl.ClosedReason IN (0,3)
		AND cps.CloseInfo = 0
		AND ci.[Enabled] = 1
		AND 1 = CASE WHEN ci.currency <> 20 AND ci.custid <= @max_custid  THEN 1
					 WHEN ci.currency = 20 AND ci.srecommend NOT IN (52786885,52786933,52786934,52786948,52786949,52786954,52786956,52786961,38268801,47447605,46337216,45080424,52786964,34027396,25659077) AND ci.custid <= @max_custid THEN 1
					 ELSE 0
				END
	
	--Backup data before updating
	INSERT INTO CustLoginInfo_BackupCloseReason(CustID, ClosedReason)
	SELECT CustID, ClosedReason
	FROM #tblCust_Agent

	INSERT INTO CustLoginInfoMember_BackupCloseReason(CustID, ClosedReason)
	SELECT CustID, ClosedReason
	FROM #tblCust_Member

	--UPDATE Agent	
	WHILE (1=1)
	BEGIN			
		
		UPDATE TOP (2000) c SET c.IsFinished = 1
		OUTPUT deleted.CustID
		INTO #tblCust_AgentBatch(CustID)
		FROM #tblCust_Agent c
		WHERE c.IsFinished = 0
		
		IF @@ROWCOUNT = 0
			BREAK

		UPDATE cl
		SET cl.ClosedReason = NULL
		FROM CustLoginInfo cl WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tblCust_AgentBatch t ON cl.custid = t.custid

		DELETE #tblCust_AgentBatch

		RAISERROR ('Total of Agent: %d.', 0, 1, @@ROWCOUNT) WITH NOWAIT
		WAITFOR DELAY '0:0:1.00'
	END

	--UPDATE member

	WHILE (1=1)
	BEGIN			
		
		UPDATE TOP (2000) c SET c.IsFinished = 1
		OUTPUT deleted.CustID
		INTO #tblCust_MemberBatch(CustID)
		FROM #tblCust_Member c
		WHERE c.IsFinished = 0
		
		IF @@ROWCOUNT = 0
			BREAK

		UPDATE cl
		SET cl.ClosedReason = NULL
		FROM CustLoginInfo_Member cl WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tblCust_MemberBatch t ON cl.custid = t.custid

		DELETE #tblCust_MemberBatch

		RAISERROR ('Total of Member: %d.', 0, 1, @@ROWCOUNT) WITH NOWAIT
		WAITFOR DELAY '0:0:1.00'
	END
	
	DROP TABLE #tblCust_Agent
	DROP TABLE #tblCust_AgentBatch
	DROP TABLE #tblCust_Member
	DROP TABLE #tblCust_MemberBatch
