/*
	Created: Eden
	Date: 20200218
	Task: Input initial data for Cust_TrackingLastBetDate [RM:#125823]
	DB: DBACC/bodb02
*/
USE bodb02
GO
---------------------Step 1 - Run on DBACC/bodb02-----------------------
IF OBJECT_ID ('Acc_Dep_DynamicCustSetting_09_Archive') IS NOT NULL
    DROP PROC Acc_Dep_DynamicCustSetting_09_Archive
GO
CREATE PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09_Archive]
	@recommend INT 
AS
BEGIN
	DECLARE @EffectDays                  INT = 1095, -- the days which get data from STATEMENT to input #Member
			@CheckStatement_DaysPerBatch INT = 10,
			@CheckBettrans_CustPerBatch  INT = 2000

	DECLARE @MinBettingDate DATETIME
	SET @MinBettingDate = DATEADD(dd, -@EffectDays, CAST(GETDATE() AS DATE))

	CREATE TABLE #Member 
		(
			  custid int PRIMARY KEY
			, LastBetDate DATETIME
			, isProcessed BIT default 0
		)

	CREATE TABLE #BettingMember 
		(
			custid INT PRIMARY KEY
			,LastBetDate DATETIME 
		)

	CREATE TABLE #tmpMember 
		(
			custid INT PRIMARY KEY
		)

	-- 1.Get infor of all customer in Customer and custinfo table
	INSERT INTO #Member (custid)
	SELECT cust.custid
	FROM customer cust WITH (NOLOCK)
		INNER JOIN custInfo ci (NOLOCK) ON cust.custid = ci.custid
	WHERE cust.roleid = 1
		AND cust.recommend = @recommend
		AND ci.username NOT LIKE '%BetTrade%' 
		AND ci.username NOT LIKE '%CashOut%' 
		AND ci.username NOT LIKE '%ClearBal%'
		AND ci.username NOT LIKE '%01OddsAdj%'

	DELETE 
	FROM #Member 
	WHERE custid IN (SELECT CustID FROM bodb02.dbo.Dep_Customer_Archived WITH (NOLOCK) WHERE status IN ('archived','completed') )
	
	DELETE FROM #Member
	WHERE custid IN (SELECT custid FROM DBCUST.CustDB.dbo.Dep_Customer_Archived_Exception WITH (NOLOCK))

	WHILE ( 1 = 1 )
	BEGIN
		TRUNCATE TABLE #tmpMember

		UPDATE TOP (@CheckBettrans_CustPerBatch) t
		SET  isProcessed = 1
		OUTPUT deleted.custid INTO #tmpMember(custid)
		FROM #Member t
		WHERE isProcessed = 0
		
		IF (@@ROWCOUNT = 0) 
			BREAK

		--> scan ticket from bettrans
		TRUNCATE TABLE #BettingMember
		INSERT INTO #BettingMember(custid,LastBetDate)
		SELECT custid, MAX(b.transdate) AS transdate
		FROM bettrans b with (NOLOCK)
		WHERE bettype <> 20000 
			AND b.custid IN (SELECT CustID FROM #tmpMember b )
		GROUP BY b.custid

		UPDATE a
		SET a.LastBetDate = b.LastBetDate
		FROM #Member a
			INNER JOIN #BettingMember b  ON a.custID = b.custid
		WHERE ISNULL(a.LastBetDate,'1900/01/01') < b.LastBetDate

		--> scan ticket from bettransRNG
		TRUNCATE TABLE #BettingMember
		INSERT INTO #BettingMember(custid,LastBetDate)
		SELECT custid, MAX(b.transdate) AS transdate
		FROM bettransRNG b with (NOLOCK)
		WHERE b.custid IN (SELECT CustID FROM #tmpMember b  )
		GROUP BY b.custid

		UPDATE a
		SET a.LastBetDate = b.LastBetDate
		FROM #Member a
			INNER JOIN #BettingMember b  ON a.custID = b.custid
		WHERE ISNULL(a.LastBetDate,'1900/01/01') < b.LastBetDate

		--> scan ticket from bettransLC
		TRUNCATE TABLE #BettingMember
		INSERT INTO #BettingMember(custid,LastBetDate)
		SELECT custid, MAX(b.transdate) AS transdate
		FROM bettransLC b with (NOLOCK)
		WHERE b.custid IN (SELECT CustID FROM #tmpMember b  )
		GROUP BY b.custid

		UPDATE a
		SET a.LastBetDate = b.LastBetDate
		FROM #Member a
			INNER JOIN #BettingMember b  ON a.custID = b.custid
		WHERE ISNULL(a.LastBetDate,'1900/01/01') < b.LastBetDate

		--> scan ticket from translog
		TRUNCATE TABLE #BettingMember
		INSERT INTO #BettingMember(custid,LastBetDate)
		SELECT custid, MAX(b.transdate) AS transdate
		FROM translog b with (NOLOCK)
		WHERE b.custid IN (SELECT CustID FROM #tmpMember b  )
		GROUP BY b.custid

		UPDATE a
		SET a.LastBetDate = b.LastBetDate
		FROM #Member a
			INNER JOIN #BettingMember b  ON a.custID = b.custid
		WHERE ISNULL(a.LastBetDate,'1900/01/01') < b.LastBetDate

		--> scan ticket from DBPTCS.bodb_PlaytechCS.dbo.bettrans_AGCasino
		TRUNCATE TABLE #BettingMember
		INSERT INTO #BettingMember(custid,LastBetDate)
		SELECT custid, MAX(b.transdate) AS transdate
		FROM DBPTCS.bodb_PlaytechCS.dbo.bettrans_AGCasino b with (NOLOCK)
		WHERE b.custid IN (SELECT CustID FROM #tmpMember b  )
		GROUP BY b.custid

		UPDATE a
		SET a.LastBetDate = b.LastBetDate
		FROM #Member a
			INNER JOIN #BettingMember b  ON a.custID = b.custid
		WHERE ISNULL(a.LastBetDate,'1900/01/01') < b.LastBetDate

		--> scan ticket from DBPTCS.bodb_PlaytechCS.dbo.bettrans_GoldDeluxe
		TRUNCATE TABLE #BettingMember
		INSERT INTO #BettingMember(custid,LastBetDate)
		SELECT custid, MAX(b.transdate) AS transdate
		FROM DBPTCS.bodb_PlaytechCS.dbo.bettrans_GoldDeluxe b with (NOLOCK)
		WHERE b.custid IN (SELECT CustID FROM #tmpMember b  )
		GROUP BY b.custid

		UPDATE a
		SET a.LastBetDate = b.LastBetDate
		FROM #Member a
			INNER JOIN #BettingMember b  ON a.custID = b.custid
		WHERE ISNULL(a.LastBetDate,'1900/01/01') < b.LastBetDate
	END

	DELETE t
	OUTPUT deleted.custid,deleted.LastBetDate INTO Cust_TrackingLastBetDate(custid,LastBetDate)
	FROM #Member t
	WHERE LastBetDate IS NOT NULL

	UPDATE #Member SET isProcessed = 0

	--Scan bettrans14
	IF EXISTS(SELECT 1 FROM #Member)
	BEGIN
		WHILE ( 1 = 1 )
		BEGIN
			TRUNCATE TABLE #tmpMember

			UPDATE TOP (@CheckBettrans_CustPerBatch) t
			SET  isProcessed = 1
			OUTPUT deleted.custid INTO #tmpMember(custid)
			FROM #Member t
			WHERE isProcessed = 0
		
			IF (@@ROWCOUNT = 0) 
				BREAK

			--> scan ticket from DBPTCS.bodb_PlaytechCS.dbo.bettrans_GoldDeluxe
			TRUNCATE TABLE #BettingMember
			INSERT INTO #BettingMember(custid,LastBetDate)
			SELECT custid, MAX(b.transdate) AS transdate
			FROM bettrans14 b with (NOLOCK)
			WHERE b.custid IN (SELECT CustID FROM #tmpMember b  )
			GROUP BY b.custid

			UPDATE a
			SET a.LastBetDate = b.LastBetDate
			FROM #Member a
				INNER JOIN #BettingMember b  ON a.custID = b.custid
			WHERE ISNULL(a.LastBetDate,'1900/01/01') < b.LastBetDate
		END

		DELETE t
		OUTPUT deleted.custid,deleted.LastBetDate INTO Cust_TrackingLastBetDate(custid,LastBetDate)
		FROM #Member t
		WHERE LastBetDate IS NOT NULL

	END

	IF EXISTS(SELECT 1 FROM #Member)
	BEGIN
		-- 2. Get List Member have bet ticket in #Member table (can apply batch processing)
		-- Apply loop by date for bodb_Report.dbo.STATEMENT table
		DECLARE @fromDate_e DATETIME, @toDate_e DATETIME, @FromDate DATETIME

		SET @toDate_e = CAST(GETDATE() AS DATE)
		SET @fromDate_e = DATEADD(DAY, - @CheckStatement_DaysPerBatch, @toDate_e)

		SET @FromDate = @MinBettingDate

		IF @fromDate_e < @FromDate 
			SELECT @fromDate_e = @FromDate
			
		WHILE @fromDate_e < @toDate_e	
		BEGIN
			TRUNCATE TABLE #BettingMember

			INSERT INTO #BettingMember(custid,LastBetDate)	
			SELECT  custid, MAX(accDate) AS accDate
			FROM bodb_Report.dbo.STATEMENT st WITH  (NOLOCK)
			WHERE accDate >= @fromDate_e AND accDate < @toDate_e
				AND TransType <> N'bal' 
				AND st.custid IN ( SELECT custid FROM #Member m)
			GROUP BY custid

			INSERT INTO Cust_TrackingLastBetDate (custid,LastBetDate)
			SELECT custid,LastBetDate FROM #BettingMember
					
			DELETE a
			FROM #Member a 
				INNER JOIN  #BettingMember b ON a.CustID = b.custid

			SELECT @toDate_e = @fromDate_e  
			SELECT @fromDate_e = DATEADD(DAY, -@CheckStatement_DaysPerBatch, @fromDate_e)

			IF @fromDate_e < @FromDate 
				SELECT @fromDate_e = @FromDate
		END
	END

	INSERT INTO Cust_TrackingLastBetDate (custid,LastBetDate)
	SELECT custid,LastBetDate FROM #Member

	DROP TABLE #Member
	DROP TABLE #BettingMember
	DROP TABLE #tmpMember
END
GO
---------------------END step 1-----------------------------------------------------
---------------------step 2 Run on DBACC/bodb02 ------------------------------------

PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
DECLARE @recommend INT

-- For deployer info
DECLARE @agent_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, AgentID : %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of Agents: %d.'

SET @agent_cnt = (SELECT COUNT(*) FROM TmpAgent_Cust_TrackingLastBetDate WITH(NOLOCK) WHERE isProcessed = 0 )
RAISERROR (@msg_total, 0, 1, @agent_cnt) WITH NOWAIT

--TRUNCATE TABLE Cust_TrackingLastBetDate

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) TmpAgent_Cust_TrackingLastBetDate 
	SET isProcessed = 1
		,@recommend = AgentID	
	WHERE isProcessed = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @recommend) WITH NOWAIT

	EXEC dbo.Acc_Dep_DynamicCustSetting_09_Archive @recommend = @recommend
						
	waitfor delay '00:00:0.100'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

GO
---------------------END step 2-----------------------------------------------------