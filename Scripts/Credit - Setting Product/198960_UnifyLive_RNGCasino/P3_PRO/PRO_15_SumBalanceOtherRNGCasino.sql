/*<info serverAlias="DBSIC-bodb02"></info>*/
/*
	Created:20240422@Eden
	Task: Sum balance for Other RNG Casino Product (4601) from : [RM:#198960]
		4601 --> Virtual Games
		2101 --> Saba Casino
		3801 --> Vgaming
		1611 --> SABA.games
	DB: DBSIC/bodb02 --Credit SiteDB Only
*/
USE bodb02
GO

DECLARE @Scan_TranferDTS DATETIME = DATEADD(minute,-5,GETDATE()) -- Time before run script Insert update SportBetTypeSettingMatrix Table

DECLARE @Bettypes TABLE(bettype SMALLINT)
INSERT INTO @Bettypes(bettype)
		  SELECT	4601 --> Virtual Games
UNION ALL SELECT	2101 --> Saba Casino
UNION ALL SELECT	3801 --> Vgaming
UNION ALL SELECT	1611 --> SABA.games

--BACKUP DATA
--DROP TABLE BalanceDebitGame_BU_198960
--DROP TABLE BalanceCreditGame_BU_198960
IF OBJECT_ID('BalanceCreditGame_BU_198960') IS NULL
	CREATE TABLE BalanceCreditGame_BU_198960(
		 custid	int
		,winlostdate	smalldatetime
		,Balance	money
		,bettype	smallint
	PRIMARY KEY(custid, winlostdate, bettype)
	)

IF OBJECT_ID('BalanceDebitGame_BU_198960') IS NULL
	CREATE TABLE BalanceDebitGame_BU_198960(
		 custid	int
		,winlostdate	smalldatetime
		,Balance	money
		,bettype	smallint
		PRIMARY KEY(custid, winlostdate, bettype)
	)
TRUNCATE TABLE BalanceCreditGame_BU_198960
TRUNCATE TABLE BalanceDebitGame_BU_198960


INSERT INTO BalanceCreditGame_BU_198960(CustID,winlostdate,balance,bettype)
SELECT CustID,winlostdate,balance,bal.bettype 
FROM BalanceCreditGame bal WITH(NOLOCK) 
	INNER JOIN @Bettypes b ON bal.bettype = b.bettype

INSERT INTO BalanceDebitGame_BU_198960(CustID,winlostdate,balance,bettype)
SELECT CustID,winlostdate,balance,bal.bettype 
FROM BalanceDebitGame bal WITH(NOLOCK) 
	INNER JOIN @Bettypes b ON bal.bettype = b.bettype

--Step: Clear balance follow AutoReset  setting Rule of bettype 4601,2101,3801,1611
BEGIN
	DECLARE @SiteDBGroupID smallint
	SELECT @SiteDBGroupID = dbo.f_Get_SiteDBGroupID()
	IF @SiteDBGroupID <> 3
		RETURN -- wrong credit siteDB

	CREATE TABLE #WeeklyResetCustomer(custid INT, srecommend INT)
	INSERT INTO #WeeklyResetCustomer(custid, srecommend)
	SELECT c.custid, srecommend
	FROM CustDB.dbo.customer c WITH (NOLOCK)
		INNER JOIN CustDB.dbo.Site s WITH(NOLOCK) 
			ON c.site = s.Site
		INNER JOIN DBCUST.CustDB.dbo.CustWinLossLimit_Member cwl WITH (NOLOCK) 
			ON cwl.CustId = c.custid 
			AND cwl.sporttype = 9918 --Other RNG Casino
			AND cwl.bettype = 4601 
	WHERE c.roleid = 1 
		AND IsAutoReset = 0
		AND s.SiteDBGroupID = @SiteDBGroupID

	--delete balance for daily reset
	WHILE 1 = 1
	BEGIN
		DELETE TOP (50000) bal
		FROM dbo.BalanceCreditGame bal WITH (ROWLOCK)
			INNER JOIN @Bettypes b ON bal.bettype = b.bettype
			LEFT JOIN #WeeklyResetCustomer t ON bal.CustId = t.CustId
		WHERE t.CustId IS NULL
		OPTION (MAXDOP 4,RECOMPILE)
		
		IF @@ROWCOUNT < 50000
			BREAK
			
		WAITFOR DELAY '00:00:00.280'
	END

	WHILE 1 = 1
	BEGIN
		DELETE TOP (50000) bal
		FROM dbo.BalanceDebitGame bal WITH (ROWLOCK)
			INNER JOIN @Bettypes b ON bal.bettype = b.bettype
			LEFT JOIN #WeeklyResetCustomer t ON bal.CustId = t.CustId
		WHERE t.CustId IS NULL
		OPTION (MAXDOP 4,RECOMPILE)

		IF @@ROWCOUNT < 50000
			BREAK
			
		WAITFOR DELAY '00:00:00.280'
	END
END
-----------------Step : Sum balance bettype 4601,2101,3801,1611 to 4601 -----------
BEGIN
	--BalanceCreditGame
	;WITH Temp AS(
		SELECT bal.custid, bal.winlostdate, SUM(balance) AS balance, bettype = 4601
		FROM dbo.BalanceCreditGame bal WITH (NOLOCK)
				INNER JOIN @Bettypes b ON bal.bettype = b.bettype
		GROUP BY bal.custid, bal.winlostdate
	)
	MERGE BalanceCreditGame b
	USING Temp t 
		ON  b.custid = t.custID
		AND b.winlostdate = t.winlostdate
		AND b.bettype = t.bettype
	WHEN MATCHED THEN
		UPDATE SET b.balance = t.balance
	WHEN NOT MATCHED THEN
		INSERT (CustID,winlostdate,balance,bettype) 
		VALUES (t.CustID,t.winlostdate,t.balance,t.bettype);

	--BalanceDebitGame
	;WITH Temp AS(
		SELECT bal.custid, bal.winlostdate, SUM(balance) AS balance, bettype = 4601
		FROM dbo.BalanceDebitGame bal WITH (NOLOCK)
				INNER JOIN @Bettypes b ON bal.bettype = b.bettype
		GROUP BY bal.custid, bal.winlostdate
	)
	MERGE BalanceDebitGame b
	USING Temp t 
		ON  b.custid = t.custID
		AND b.winlostdate = t.winlostdate
		AND b.bettype = t.bettype
	WHEN MATCHED THEN
		UPDATE SET b.balance = t.balance
	WHEN NOT MATCHED THEN
		INSERT (CustID,winlostdate,balance,bettype) 
		VALUES (t.CustID,t.winlostdate,t.balance,t.bettype);
END
----------------Step : Delete record balance of bettype : 2101,3801,1611
BEGIN
	WHILE 1 = 1
	BEGIN
		DELETE TOP (50000) bal
		FROM dbo.BalanceCreditGame bal WITH (ROWLOCK)
		WHERE bettype IN(2101,3801,1611)
		OPTION (MAXDOP 4,RECOMPILE)
		
		IF @@ROWCOUNT < 50000
			BREAK
			
		WAITFOR DELAY '00:00:00.280'
	END

	WHILE 1 = 1
	BEGIN
		DELETE TOP (50000) bal
		FROM dbo.BalanceDebitGame bal WITH (ROWLOCK)
		WHERE bettype IN(2101,3801,1611)
		OPTION (MAXDOP 4,RECOMPILE)

		IF @@ROWCOUNT < 50000
			BREAK
			
		WAITFOR DELAY '00:00:00.280'
	END
END
---------------Step : Delete record balance bettype 4601 if customers have transfer ticket
BEGIN
	CREATE TABLE #TempCust_transfer(CustID INT)

	INSERT INTO #TempCust_transfer(CustID)
	SELECT custID
	FROM Transfer ts WITH(NOLOCK) 
	WHERE TransDate >= @Scan_TranferDTS

	WHILE 1 = 1
	BEGIN
		DELETE TOP (50000) bal
		FROM dbo.BalanceCreditGame bal WITH (ROWLOCK)
			INNER JOIN #TempCust_transfer ts ON bal.custid = ts.CustID
		WHERE bettype IN (4601)
		OPTION (MAXDOP 4,RECOMPILE)
		
		IF @@ROWCOUNT < 50000
			BREAK
			
		WAITFOR DELAY '00:00:00.280'
	END

	WHILE 1 = 1
	BEGIN
		DELETE TOP (50000) bal
		FROM dbo.BalanceDebitGame bal WITH (ROWLOCK)
			INNER JOIN #TempCust_transfer ts ON bal.custid = ts.CustID
		WHERE bettype IN (4601)
		OPTION (MAXDOP 4,RECOMPILE)

		IF @@ROWCOUNT < 50000
			BREAK
			
		WAITFOR DELAY '00:00:00.280'
	END
END

DROP TABLE #WeeklyResetCustomer
DROP TABLE #TempCust_transfer

GO