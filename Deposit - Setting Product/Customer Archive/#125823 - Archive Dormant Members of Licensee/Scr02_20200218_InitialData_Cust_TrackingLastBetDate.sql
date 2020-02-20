/*
	Created: Eden
	Date: 20200218
	Task: Input initial data for Cust_TrackingLastBetDate [RM:#125823]
	DB: DBACC/bodb02
*/
USE bodb02
GO
---------------------Step 1 - Run on DBACC/bodb02-----------------------
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
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
		AND cust.srecommend IN (SELECT custid FROM Dep_CustSuper (NOLOCK))
		AND ci.username NOT LIKE '%BetTrade%' 
		AND ci.username NOT LIKE '%CashOut%' 
		AND ci.username NOT LIKE '%ClearBal%'

	DELETE FROM #Member
	WHERE custid IN (SELECT custid FROM DBCUST.CustDB.dbo.Dep_Customer_Archived_Exception WITH (NOLOCK))

	DELETE FROM #Member
	WHERE custid IN (SELECT custid FROM bodb02.dbo.Dep_Customer_Archived WITH (NOLOCK))

	TRUNCATE TABLE Cust_TrackingLastBetDate

	WHILE ( 1 = 1 )
	BEGIN
		TRUNCATE TABLE #tmpMember

		INSERT INTO #tmpMember
		SELECT TOP (@CheckBettrans_CustPerBatch) custid
		FROM #Member 
		WHERE isProcessed = 0
		
		IF (@@ROWCOUNT = 0) 
			BREAK

		--> scan ticket from bettrans
		TRUNCATE TABLE #BettingMember
		INSERT INTO #BettingMember(custid,LastBetDate)
		SELECT custid, MAX(b.transdate) AS transdate
		FROM bettrans b with (NOLOCK)
		WHERE bettype <> 20000 
			AND b.custid IN (SELECT CustID FROM #tmpMember b WITH(NOLOCK) )
		GROUP BY b.custid

		UPDATE a
		SET a.LastBetDate = b.LastBetDate
		FROM #Member a
			INNER JOIN #BettingMember b with (NOLOCK) ON a.custID = b.custid
		WHERE ISNULL(a.LastBetDate,'1900/01/01') < b.LastBetDate

		--> scan ticket from bettransRNG
		TRUNCATE TABLE #BettingMember
		INSERT INTO #BettingMember(custid,LastBetDate)
		SELECT custid, MAX(b.transdate) AS transdate
		FROM bettransRNG b with (NOLOCK)
		WHERE b.custid IN (SELECT CustID FROM #tmpMember b WITH(NOLOCK) )
		GROUP BY b.custid

		UPDATE a
		SET a.LastBetDate = b.LastBetDate
		FROM #Member a
			INNER JOIN #BettingMember b with (NOLOCK) ON a.custID = b.custid
		WHERE ISNULL(a.LastBetDate,'1900/01/01') < b.LastBetDate

		--> scan ticket from bettransLC
		TRUNCATE TABLE #BettingMember
		INSERT INTO #BettingMember(custid,LastBetDate)
		SELECT custid, MAX(b.transdate) AS transdate
		FROM bettransLC b with (NOLOCK)
		WHERE b.custid IN (SELECT CustID FROM #tmpMember b WITH(NOLOCK) )
		GROUP BY b.custid

		UPDATE a
		SET a.LastBetDate = b.LastBetDate
		FROM #Member a
			INNER JOIN #BettingMember b with (NOLOCK) ON a.custID = b.custid
		WHERE ISNULL(a.LastBetDate,'1900/01/01') < b.LastBetDate

		--> scan ticket from translog
		TRUNCATE TABLE #BettingMember
		INSERT INTO #BettingMember(custid,LastBetDate)
		SELECT custid, MAX(b.transdate) AS transdate
		FROM translog b with (NOLOCK)
		WHERE b.custid IN (SELECT CustID FROM #tmpMember b WITH(NOLOCK) )
		GROUP BY b.custid

		UPDATE a
		SET a.LastBetDate = b.LastBetDate
		FROM #Member a
			INNER JOIN #BettingMember b with (NOLOCK) ON a.custID = b.custid
		WHERE ISNULL(a.LastBetDate,'1900/01/01') < b.LastBetDate

		UPDATE #Member
		SET isProcessed = 1
		WHERE custid IN (SELECT custid FROM #tmpMember)
	END

	INSERT INTO Cust_TrackingLastBetDate (custid,LastBetDate)
	SELECT custid,LastBetDate FROM #Member WHERE LastBetDate IS NOT NULL

	DELETE FROM #Member WHERE LastBetDate IS NOT NULL

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
			
		WHILE @fromDate_e <= @toDate_e	
		BEGIN
			TRUNCATE TABLE #BettingMember

			INSERT INTO #BettingMember(custid,LastBetDate)	
			SELECT  custid, MAX(accDate) AS accDate
			FROM bodb_Report.dbo.STATEMENT st WITH  (NOLOCK, FORCESEEK)
			WHERE accDate >= @fromDate_e AND accDate <= @toDate_e
				AND TransType <> N'bal' 
				AND st.custid IN ( SELECT custid FROM #Member m)
			GROUP BY custid

			INSERT INTO Cust_TrackingLastBetDate (custid,LastBetDate)
			SELECT custid,LastBetDate FROM #BettingMember
					
			DELETE a
			FROM #Member a 
				INNER JOIN  #BettingMember b ON a.CustID = b.custid

			IF @FromDate = @fromDate_e
				BREAK;

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

CREATE TABLE #Agent (AgentID int PRIMARY KEY , isProcessed BIT DEFAULT 0)

INSERT INTO #Agent (AgentID)
SELECT cust.custid
FROM customer cust WITH (NOLOCK)
INNER JOIN custInfo ci (NOLOCK) ON cust.custid = ci.custid
WHERE cust.roleid = 2
	AND cust.srecommend IN (SELECT custid FROM Dep_CustSuper (NOLOCK))

-- For deployer info
DECLARE @agent_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, AgentID : %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of Agents: %d.'

SET @agent_cnt = (SELECT COUNT(*) FROM #Agent )
RAISERROR (@msg_total, 0, 1, @agent_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Agent
	SET isProcessed = 1
		,@recommend = AgentID	
	WHERE isProcessed = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @recommend) WITH NOWAIT

	EXEC dbo.Acc_Dep_DynamicCustSetting_09 @recommend = @recommend
						
	waitfor delay '00:00:0.100'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DROP TABLE #Agent
GO
---------------------END step 2-----------------------------------------------------