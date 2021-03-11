/*
	Created: Eden
	Date: 20210309
	Task: Input initial data for Cust_TrackingLastBetDate (clone DB) [RM:#125823]
		- Step 1: Clone the following tables(include indexs) to Clone DB to get data for Cust_TrackingLastBetDate
			bodb02.dbo.customer
			bodb02.dbo.custInfo
			bodb02.dbo.Dep_Customer_Archived
			bodb02.dbo.bettrans
			bodb02.dbo.bettransRNG
			bodb02.dbo.bettransLC
			bodb02.dbo.translog
			bodb02.dbo.bettrans14
			bodb_Report.dbo.STATEMENT
			DBPTCS.bodb_PlaytechCS.dbo.bettrans_AGCasino
			DBPTCS.bodb_PlaytechCS.dbo.bettrans_GoldDeluxe

		--Step 2: Create new index for some tables 
			CREATE NONCLUSTERED INDEX ix_bettrans_transdate ON bettrans(custid,transdate,bettype)
			CREATE NONCLUSTERED INDEX ix_bettransRNG_transdate ON bettransRNG(custid,transdate)
			CREATE NONCLUSTERED INDEX ix_bettransLC_transdate ON bettransLC(custid,transdate)
			CREATE NONCLUSTERED INDEX ix_translog_transdate ON translog(custid,transdate)
			CREATE NONCLUSTERED INDEX ix_bettrans_AGCasino_transdate ON bettrans_AGCasino(custid,transdate)
			CREATE NONCLUSTERED INDEX ix_bettrans_GoldDeluxe_transdate ON bettrans_GoldDeluxe(custid,transdate)
			CREATE NONCLUSTERED INDEX ix_bettrans14_transdate ON bettrans14(custid,transdate)

		--Step 3 + 4 : Run script to update Cust_TrackingLastBetDate on DB clone
		--Step 5 : sync data of Cust_TrackingLastBetDate from DB clone to DBACC/bodb02

		
	DB: DBACC- Clone DB
*/
/*
-- Step 1: Clone the following tables(include indexs) to Clone DB to get data for Cust_TrackingLastBetDate
			bodb02.dbo.customer
			bodb02.dbo.custInfo
			bodb02.dbo.Dep_Customer_Archived
			bodb02.dbo.bettrans
			bodb02.dbo.bettransRNG
			bodb02.dbo.bettransLC
			bodb02.dbo.translog
			bodb02.dbo.bettrans14
			bodb_Report.dbo.STATEMENT
			DBPTCS.bodb_PlaytechCS.dbo.bettrans_AGCasino
			DBPTCS.bodb_PlaytechCS.dbo.bettrans_GoldDeluxe

--Step 2: Create new index for some tables - Run on DBACC - CLone DB
	CREATE NONCLUSTERED INDEX ix_bettrans_transdate ON bettrans(bettype,custid,transdate)
	CREATE NONCLUSTERED INDEX ix_bettransRNG_transdate ON bettransRNG(custid,transdate)
	CREATE NONCLUSTERED INDEX ix_bettransLC_transdate ON bettransLC(custid,transdate)
	CREATE NONCLUSTERED INDEX ix_translog_transdate ON translog(custid,transdate)
	CREATE NONCLUSTERED INDEX ix_bettrans_AGCasino_transdate ON bettrans_AGCasino(custid,transdate)
	CREATE NONCLUSTERED INDEX ix_bettrans_GoldDeluxe_transdate ON bettrans_GoldDeluxe(custid,transdate)
	CREATE NONCLUSTERED INDEX ix_bettrans14_transdate ON bettrans14(custid,transdate)
*/

---------------------Step 3 - Run on DBACC - CLone DB-----------------------
IF OBJECT_ID ('Acc_Dep_DynamicCustSetting_09_Archive') IS NOT NULL
    DROP PROC Acc_Dep_DynamicCustSetting_09_Archive
GO
CREATE PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09_Archive]
	@recommend INT 
AS
BEGIN
	DECLARE @EffectDays                  INT = 1095 -- the days which get data from STATEMENT to input #Member
	DECLARE	@CheckBettrans_CustPerBatch  INT = 2000

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
			custid INT --PRIMARY KEY
			,LastBetDate DATETIME 
		)

	CREATE TABLE #tmpMember 
		(
			custid INT PRIMARY KEY
		)

	-- 1.Get infor of all customer in Customer and custinfo table
	INSERT INTO #Member (custid)
	SELECT DISTINCT cust.custid
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
	WHERE custid IN (SELECT CustID FROM dbo.Dep_Customer_Archived WITH (NOLOCK) WHERE status IN ('archived','completed') )
	
	DELETE FROM #Member
	WHERE custid IN (SELECT custid FROM KBTDBCUST.CustDB.dbo.Dep_Customer_Archived_Exception WITH (NOLOCK))

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

		--scan ticket from bettrans
		TRUNCATE TABLE #BettingMember
		INSERT INTO #BettingMember(custid,LastBetDate)
		SELECT t.custid, a.transdate
		FROM #tmpMember t 
		CROSS APPLY(	SELECT TOP 1 transdate
						FROM bettrans b with (NOLOCK)
						WHERE b.custid = t.custid
							AND bettype NOT IN(19999, 20000)
						ORDER BY transdate DESC
			) a

		UPDATE a
		SET a.LastBetDate = b.LastBetDate
		FROM #Member a
			INNER JOIN #BettingMember b  ON a.custID = b.custid
		WHERE ISNULL(a.LastBetDate,'1900/01/01') < b.LastBetDate

		--> scan ticket from bettransRNG
		TRUNCATE TABLE #BettingMember
		INSERT INTO #BettingMember(custid,LastBetDate)
		SELECT t.custid, a.transdate
		FROM #tmpMember t 
		CROSS APPLY(	SELECT TOP 1 transdate
						FROM bettransRNG b with (NOLOCK)
						WHERE b.custid = t.custid
						ORDER BY transdate DESC
			) a

		UPDATE a
		SET a.LastBetDate = b.LastBetDate
		FROM #Member a
			INNER JOIN #BettingMember b  ON a.custID = b.custid
		WHERE ISNULL(a.LastBetDate,'1900/01/01') < b.LastBetDate

		--> scan ticket from bettransLC
		TRUNCATE TABLE #BettingMember
		INSERT INTO #BettingMember(custid,LastBetDate)
		SELECT t.custid, a.transdate
		FROM #tmpMember t 
		CROSS APPLY(	SELECT TOP 1 transdate
						FROM bettransLC b with (NOLOCK)
						WHERE b.custid = t.custid
						ORDER BY transdate DESC
			) a

		UPDATE a
		SET a.LastBetDate = b.LastBetDate
		FROM #Member a
			INNER JOIN #BettingMember b  ON a.custID = b.custid
		WHERE ISNULL(a.LastBetDate,'1900/01/01') < b.LastBetDate

		--> scan ticket from translog
		TRUNCATE TABLE #BettingMember
		INSERT INTO #BettingMember(custid,LastBetDate)
		SELECT t.custid, a.transdate
		FROM #tmpMember t 
		CROSS APPLY(	SELECT TOP 1 transdate
						FROM translog b with (NOLOCK)
						WHERE b.custid = t.custid
						ORDER BY transdate DESC
			) a

		UPDATE a
		SET a.LastBetDate = b.LastBetDate
		FROM #Member a
			INNER JOIN #BettingMember b  ON a.custID = b.custid
		WHERE ISNULL(a.LastBetDate,'1900/01/01') < b.LastBetDate

		--> scan ticket from DBPTCS.bodb_PlaytechCS.dbo.bettrans_AGCasino
		TRUNCATE TABLE #BettingMember
		INSERT INTO #BettingMember(custid,LastBetDate)
		SELECT t.custid, a.transdate
		FROM #tmpMember t 
		CROSS APPLY(	SELECT TOP 1 transdate
						FROM bettrans_AGCasino b with (NOLOCK)
						WHERE b.custid = t.custid
						ORDER BY transdate DESC
			) a

		UPDATE a
		SET a.LastBetDate = b.LastBetDate
		FROM #Member a
			INNER JOIN #BettingMember b  ON a.custID = b.custid
		WHERE ISNULL(a.LastBetDate,'1900/01/01') < b.LastBetDate

		--> scan ticket from DBPTCS.bodb_PlaytechCS.dbo.bettrans_GoldDeluxe
		TRUNCATE TABLE #BettingMember
		INSERT INTO #BettingMember(custid,LastBetDate)
		SELECT t.custid, a.transdate
		FROM #tmpMember t 
		CROSS APPLY(	SELECT TOP 1 transdate
						FROM bettrans_GoldDeluxe b with (NOLOCK)
						WHERE b.custid = t.custid
						ORDER BY transdate DESC
			) a

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

			--> scan ticket from bettrans14
			TRUNCATE TABLE #BettingMember
			INSERT INTO #BettingMember(custid,LastBetDate)
			SELECT t.custid, a.transdate
			FROM #tmpMember t 
			CROSS APPLY(	SELECT TOP 1 transdate
							FROM bettrans14 b with (NOLOCK)
							WHERE b.custid = t.custid
							ORDER BY transdate DESC
				) a

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
	END

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
			SELECT t.custid, a.transdate
			FROM #tmpMember t 
			CROSS APPLY( SELECT TOP 1 accdate AS transdate
						FROM bodb_Report.dbo.STATEMENT b with (NOLOCK)
						WHERE b.custid = t.custid
							AND TransType <> N'bal' 
							AND b.accdate >= @MinBettingDate
						ORDER BY transdate DESC
				) a

			UPDATE a
			SET a.LastBetDate = b.LastBetDate
			FROM #Member a
				INNER JOIN #BettingMember b  ON a.custID = b.custid
			WHERE ISNULL(a.LastBetDate,'1900/01/01') < b.LastBetDate
		END
	END

	INSERT INTO Cust_TrackingLastBetDate (custid,LastBetDate)
	SELECT custid,LastBetDate FROM #Member

	DROP TABLE #Member
	DROP TABLE #BettingMember
	DROP TABLE #tmpMember
END
GO
---------------------END step 3-----------------------------------------------------
---------------------step 4 Run on DBACC - Clone DB ------------------------------------

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
---------------------END step 4-----------------------------------------------------

--Step 5 : sync data of Cust_TrackingLastBetDate from DB clone to DBACC/bodb02