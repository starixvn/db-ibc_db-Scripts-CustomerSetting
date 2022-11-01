/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Johnson
	Date: 20221021
	Task: Update bet limit for NG2  [RedmineID:#179334]
	DB: DBCust/CustDB
*/

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]	
	@srecommend INT	
	, @maxcustid INT
	, @target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB-60\DEVDBCUST','TESTDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB-60\DEVDBCUST','TESTDBCUST')) RETURN -- run at dbtrans only
		
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
		
	CREATE TABLE #tblCust (custid INT PRIMARY KEY, roleid TINYINT)
	CREATE TABLE #tblCustUpdated (custid INT PRIMARY KEY)
	DECLARE @tmpCustBetSetting_History TABLE(
				[CustID] [int] NOT NULL,
				[SportType] [smallint] NOT NULL,
				[BetType] [int] NOT NULL,
				[OldMaxBet] [money] NULL,
				[OldMaxPerMatch] [money] NULL,
				PRIMARY KEY 
					(
						[CustID] ASC,
						[SportType] ASC,
						[BetType] ASC
					)
				)
	
	DECLARE @tmpCust TABLE (custid INT PRIMARY KEY)
	
	INSERT INTO #tblCust(custid, roleid)
	SELECT custid, roleid
	FROM custinfo WITH(NOLOCK)
	WHERE srecommend = @srecommend
		AND custid <= @maxcustid
		AND enabled = 1
	
	SELECT 	2502 bettype	,	1 minbet	,	250	maxbet,	2500 MaxPerMatch
	INTO #tmpSetting
	UNION SELECT 	2503	,	1	,	250	,	2500
	UNION SELECT 	2504	,	1	,	250	,	2500
	UNION SELECT 	2505	,	1	,	250	,	2500
	/*UNION SELECT 	2506	,	1	,	250	,	1000
	UNION SELECT 	2507	,	1	,	250	,	1250
	UNION SELECT 	2508	,	1	,	250	,	1250
	UNION SELECT 	2509	,	1	,	250	,	1250
	UNION SELECT 	2510	,	1	,	250	,	1250
	UNION SELECT 	2511	,	1	,	250	,	1250*/
	UNION SELECT 	2512	,	1	,	250	,	1250
	UNION SELECT 	2513	,	1	,	250	,	1250
	UNION SELECT 	2514	,	1	,	250	,	1250
	UNION SELECT 	2515	,	1	,	135	,	675
	UNION SELECT 	2516	,	1	,	100	,	500
	UNION SELECT 	2517	,	1	,	200	,	1000
	UNION SELECT 	2518	,	1	,	250	,	1250
	UNION SELECT 	2519	,	1	,	250	,	1250
	UNION SELECT 	2520	,	1	,	250	,	1250
	UNION SELECT 	2521	,	1	,	250	,	1250
	UNION SELECT 	2522	,	1	,	250	,	1250	
	
	INSERT INTO #tblCustUpdated(custid)
	SELECT DISTINCT custid
	FROM CustBetSetting3rd_Agent cs WITH(NOLOCK)
		INNER JOIN #tmpSetting t ON cs.bettype = t.bettype AND cs.sporttype = 213
	WHERE cs.custid IN (SELECT custid FROM #tblCust WHERE roleid IN (2,3,4))
		AND (cs.MaxBet > t.MaxBet OR cs.MaxPerMatch > t.MaxPerMatch)
	
	WHILE(1=1)
	BEGIN
		DELETE TOP (250) t
		OUTPUT DELETED.custid INTO @tmpCust(custid)
		FROM #tblCustUpdated t
		
		IF @@ROWCOUNT = 0
			BREAK;
			
		UPDATE cs
		SET cs.MaxBet = CASE WHEN cs.MaxBet > t.MaxBet THEN t.MaxBet ELSE cs.MaxBet END,
			cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch > t.MaxPerMatch THEN t.MaxPerMatch ELSE cs.MaxPerMatch END
		FROM CustBetSetting3rd_Agent cs WITH(ROWLOCK)
			INNER JOIN #tmpSetting t ON cs.bettype = t.bettype AND cs.sporttype = 213
		WHERE cs.custid IN (SELECT custid FROM @tmpCust)
			AND (cs.MaxBet > t.MaxBet OR cs.MaxPerMatch > t.MaxPerMatch)	
		
		DELETE @tmpCust	
	END
	
	DELETE #tblCustUpdated
	
	INSERT INTO #tblCustUpdated(custid)
	SELECT DISTINCT custid
	FROM CustBetSetting3rd_Member cs WITH(NOLOCK)
		INNER JOIN #tmpSetting t ON cs.bettype = t.bettype AND cs.sporttype = 213
	WHERE cs.custid IN (SELECT custid FROM #tblCust WHERE roleid IN (1))
		AND (cs.MaxBet > t.MaxBet OR cs.MaxPerMatch > t.MaxPerMatch)
	
	WHILE(1=1)
	BEGIN
		DELETE TOP (250) t
		OUTPUT DELETED.custid INTO @tmpCust(custid)
		FROM #tblCustUpdated t
		
		IF @@ROWCOUNT = 0
			BREAK;
		
		IF (@target = 'DBCUST' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB-60\DEVDBCUST','TESTDBCUST'))
		BEGIN
			UPDATE cs
			SET cs.MaxBet = CASE WHEN cs.MaxBet > t.MaxBet THEN t.MaxBet ELSE cs.MaxBet END,
				cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch > t.MaxPerMatch THEN t.MaxPerMatch ELSE cs.MaxPerMatch END
				OUTPUT DELETED.custid, DELETED.sporttype, DELETED.bettype,DELETED.MaxBet,DELETED.MaxPerMatch
				INTO @tmpCustBetSetting_History(custid,sporttype,bettype,OldMaxBet,OldMaxPerMatch)
			FROM CustBetSetting3rd_Member cs WITH(ROWLOCK)
				INNER JOIN #tmpSetting t ON cs.bettype = t.bettype AND cs.sporttype = 213
			WHERE cs.custid IN (SELECT custid FROM @tmpCust)
				AND (cs.MaxBet > t.MaxBet OR cs.MaxPerMatch > t.MaxPerMatch)	
						
			INSERT INTO [dbo].[CustMaxBetSetting_History]
					   ([CustID]
					   ,[SportType]
					   ,[BetType]
					   ,[OldMaxBet]
					   ,[OldMaxPerMatch]
					   ,[OldStakeLevelList]
					   ,[UpdateTime])
			SELECT custid,sporttype,bettype,OldMaxBet,OldMaxPerMatch,NULL,GETDATE()
			FROM @tmpCustBetSetting_History
			
			DELETE @tmpCustBetSetting_History
		END
		ELSE 
		BEGIN
			UPDATE cs
			SET cs.MaxBet = CASE WHEN cs.MaxBet > t.MaxBet THEN t.MaxBet ELSE cs.MaxBet END,
				cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch > t.MaxPerMatch THEN t.MaxPerMatch ELSE cs.MaxPerMatch END				
			FROM CustBetSetting3rd_Member cs WITH(ROWLOCK)
				INNER JOIN #tmpSetting t ON cs.bettype = t.bettype AND cs.sporttype = 213
			WHERE cs.custid IN (SELECT custid FROM @tmpCust)
				AND (cs.MaxBet > t.MaxBet OR cs.MaxPerMatch > t.MaxPerMatch)	
		END
				
		DELETE @tmpCust	
	END
	
	DROP TABLE #tblCustUpdated
	DROP TABLE #tblCust
	DROP TABLE #tmpSetting
END	
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS AND DBCUST(run finally)
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB-60\DEVDBCUST','TESTDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

CREATE TABLE #supers (custid int PRIMARY KEY ,isfinished bit default(0))
CREATE TABLE #tmpSupers (custid int PRIMARY KEY)

SELECT 	2502 bettype	,	1 minbet	,	250	maxbet,	2500 MaxPerMatch
INTO #tmpSetting2
UNION SELECT 	2503	,	1	,	250	,	2500
UNION SELECT 	2504	,	1	,	250	,	2500
UNION SELECT 	2505	,	1	,	250	,	2500
/*
UNION SELECT 	2506	,	1	,	250	,	1000
UNION SELECT 	2507	,	1	,	250	,	1250
UNION SELECT 	2508	,	1	,	250	,	1250
UNION SELECT 	2509	,	1	,	250	,	1250
UNION SELECT 	2510	,	1	,	250	,	1250
UNION SELECT 	2511	,	1	,	250	,	1250
*/
UNION SELECT 	2512	,	1	,	250	,	1250
UNION SELECT 	2513	,	1	,	250	,	1250
UNION SELECT 	2514	,	1	,	250	,	1250
UNION SELECT 	2515	,	1	,	135	,	675
UNION SELECT 	2516	,	1	,	100	,	500
UNION SELECT 	2517	,	1	,	200	,	1000
UNION SELECT 	2518	,	1	,	250	,	1250
UNION SELECT 	2519	,	1	,	250	,	1250
UNION SELECT 	2520	,	1	,	250	,	1250
UNION SELECT 	2521	,	1	,	250	,	1250
UNION SELECT 	2522	,	1	,	250	,	1250	

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #tmpSupers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid	
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0	
	AND s.islicensee = 0
	AND ci.site = '789y'
	AND ci.currency <> 20 

INSERT INTO #Supers(custid)			
SELECT DISTINCT cs.custid 
FROM CustBetSetting3rd_Agent cs WITH(NOLOCK)
	INNER JOIN #tmpSupers s ON cs.custid = s.custid
	INNER JOIN #tmpSetting2 t ON cs.sporttype = 213 AND cs.bettype = t.bettype
WHERE (cs.MaxBet > t.MaxBet OR cs.MaxPerMatch > t.MaxPerMatch)	

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@maxcustid = @max_custid			
			,@target = @target
			
			
	waitfor delay '00:00:0.200'
END

DROP TABLE #supers
DROP TABLE #tmpSupers
DROP TABLE #tmpSetting2
GO