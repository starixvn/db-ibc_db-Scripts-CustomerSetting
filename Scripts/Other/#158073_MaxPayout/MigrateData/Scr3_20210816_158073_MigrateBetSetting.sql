/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20210816
	Task: Migrate bet setting from custsetting table and custsetting3rd table 
			to CustBetSetting_Agent and CustBetSetting_Member tables [Redmine: #154048]   
	DB: DBCUST/CUSTDB and all subscribers of CustDB_CustSetting publication
*/

-- STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	 @srecommend INT	
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('custsetting') = 0 RETURN
	IF dbo.f_CheckRepTable('custsetting3rd') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting_Member') = 0 RETURN

	CREATE TABLE #SMAs(
		CustID				INT,
		maxpermatch			MONEY,
		MaxPerMatch1MP		MONEY,
		maxpermatch2		MONEY,
		maxpermatch3		MONEY,
		maxpermatch5		MONEY,
		maxpermatch8		MONEY,
		maxpermatch10		MONEY,
		maxpermatch11		MONEY,
		maxpermatch99		MONEY,
		MaxPerMatch99MP		MONEY,
		maxpermatch161		MONEY,
		maxpermatch164		MONEY,
		maxperball161		MONEY
	)
	CREATE TABLE #Members(
		CustID				INT,
		maxpermatch			MONEY,
		MaxPerMatch1MP		MONEY,
		maxpermatch2		MONEY,
		maxpermatch3		MONEY,
		maxpermatch5		MONEY,
		maxpermatch8		MONEY,
		maxpermatch10		MONEY,
		maxpermatch11		MONEY,
		maxpermatch99		MONEY,
		MaxPerMatch99MP		MONEY,
		maxpermatch161		MONEY,
		maxpermatch164		MONEY,
		maxperball161		MONEY
	)
	CREATE TABLE #Members_Batch(
		CustID				INT,
		maxpermatch			MONEY,
		MaxPerMatch1MP		MONEY,
		maxpermatch2		MONEY,
		maxpermatch3		MONEY,
		maxpermatch5		MONEY,
		maxpermatch8		MONEY,
		maxpermatch10		MONEY,
		maxpermatch11		MONEY,
		maxpermatch99		MONEY,
		MaxPerMatch99MP		MONEY,
		maxpermatch161		MONEY,
		maxpermatch164		MONEY,
		maxperball161		MONEY
	)

	INSERT INTO #SMAs (
		custid
		,maxpermatch		
		,MaxPerMatch1MP	
		,maxpermatch2	
		,maxpermatch3	
		,maxpermatch5	
		,maxpermatch8	
		,maxpermatch10	
		,maxpermatch11	
		,maxpermatch99	
		,MaxPerMatch99MP	
		,maxpermatch161	
		,maxpermatch164
		,maxperball161
	)
	SELECT custid
		,maxpermatch		
		,MaxPerMatch1MP	
		,maxpermatch2	
		,maxpermatch3	
		,maxpermatch5	
		,maxpermatch8	
		,maxpermatch10	
		,maxpermatch11	
		,maxpermatch99	
		,MaxPerMatch99MP	
		,maxpermatch161	
		,maxpermatch164	
		,maxperball161
	FROM custInfo WITH(NOLOCK)
	WHERE srecommend = @srecommend
		AND roleid IN(2,3,4)
		AND Enabled = 1
		AND custid <= @maxcustid

	INSERT INTO #Members (
		custid
		,maxpermatch		
		,MaxPerMatch1MP	
		,maxpermatch2	
		,maxpermatch3	
		,maxpermatch5	
		,maxpermatch8	
		,maxpermatch10	
		,maxpermatch11	
		,maxpermatch99	
		,MaxPerMatch99MP	
		,maxpermatch161	
		,maxpermatch164	
		,maxperball161
	)
	SELECT custid
		,maxpermatch		
		,MaxPerMatch1MP	
		,maxpermatch2	
		,maxpermatch3	
		,maxpermatch5	
		,maxpermatch8	
		,maxpermatch10	
		,maxpermatch11	
		,maxpermatch99	
		,MaxPerMatch99MP	
		,maxpermatch161	
		,maxpermatch164
		,maxperball161
	FROM custInfo WITH(NOLOCK)
	WHERE srecommend = @srecommend
		AND roleid = 1
		AND Enabled = 1
		AND custid <= @maxcustid

	------------------------------------------MIGRATE DATA---------------------------------------------------------------
	--> Migrate data for SMA level
	INSERT INTO CustBetSetting_Agent(CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch,MaxPayoutPerMatch,MaxPerNumber)
	SELECT t.custid,mm.sporttype,mm.bettype,mm.minbet,mm.maxbet,
			MaxPerMatch = CASE  WHEN mm.sporttype = 1 AND bettype = 1 THEN t.maxpermatch
								WHEN mm.sporttype = 1 AND bettype = 9 THEN t.MaxPerMatch1MP
								WHEN mm.sporttype = 2 AND bettype = 1 THEN t.maxpermatch2
								WHEN mm.sporttype = 3 AND bettype = 1 THEN t.maxpermatch3
								WHEN mm.sporttype = 5 AND bettype = 1 THEN t.maxpermatch5
								WHEN mm.sporttype = 8 AND bettype = 1 THEN t.maxpermatch8
								WHEN mm.sporttype = 10 AND bettype = 1 THEN t.maxpermatch10
								WHEN mm.sporttype = 11 AND bettype = 1 THEN t.maxpermatch11
								WHEN mm.sporttype = 99 AND bettype = 1 THEN t.maxpermatch99
								WHEN mm.sporttype = 99 AND bettype = 9 THEN t.MaxPerMatch99MP
								WHEN mm.sporttype = 161 THEN t.maxpermatch161
								WHEN mm.sporttype = 164 THEN t.maxpermatch164
							END,
			MaxPOPerMatch = CASE	WHEN mm.sporttype = 1 AND bettype = 1 AND t.maxpermatch >= 1 THEN t.maxpermatch*10
									--WHEN mm.sporttype = 1 AND bettype = 9 AND t.MaxPerMatch1MP >= 1 THEN t.MaxPerMatch1MP*10
									WHEN mm.sporttype = 2 AND bettype = 1 AND t.maxpermatch2 >= 1 THEN t.maxpermatch2*10
									WHEN mm.sporttype = 3 AND bettype = 1 AND t.maxpermatch3 >= 1 THEN t.maxpermatch3*10
									WHEN mm.sporttype = 5 AND bettype = 1 AND t.maxpermatch5 >= 1 THEN t.maxpermatch5*10
									WHEN mm.sporttype = 8 AND bettype = 1 AND t.maxpermatch8 >= 1 THEN t.maxpermatch8*10
									WHEN mm.sporttype = 10 AND bettype = 1 AND t.maxpermatch10 >= 1 THEN t.maxpermatch10*10
									WHEN mm.sporttype = 11 AND bettype = 1 AND t.maxpermatch11 >= 1 THEN t.maxpermatch11*10
									WHEN mm.sporttype = 99 AND bettype = 1 AND t.maxpermatch99 >= 1 THEN t.maxpermatch99*10
									--WHEN mm.sporttype = 99 AND bettype = 9 AND t.MaxPerMatch99MP >= 1 THEN t.MaxPerMatch99MP*10
									----------------Special value-----------------
									WHEN mm.sporttype = 1 AND bettype = 1 AND t.maxpermatch < 1 THEN t.maxpermatch
									--WHEN mm.sporttype = 1 AND bettype = 9 AND t.MaxPerMatch1MP < 1 THEN t.MaxPerMatch1MP
									WHEN mm.sporttype = 2 AND bettype = 1 AND t.maxpermatch2 < 1 THEN t.maxpermatch2
									WHEN mm.sporttype = 3 AND bettype = 1 AND t.maxpermatch3 < 1 THEN t.maxpermatch3
									WHEN mm.sporttype = 5 AND bettype = 1 AND t.maxpermatch5 < 1 THEN t.maxpermatch5
									WHEN mm.sporttype = 8 AND bettype = 1 AND t.maxpermatch8 < 1 THEN t.maxpermatch8
									WHEN mm.sporttype = 10 AND bettype = 1 AND t.maxpermatch10 < 1 THEN t.maxpermatch10
									WHEN mm.sporttype = 11 AND bettype = 1 AND t.maxpermatch11 < 1 THEN t.maxpermatch11
									WHEN mm.sporttype = 99 AND bettype = 1 AND t.maxpermatch99 < 1 THEN t.maxpermatch99
									--WHEN mm.sporttype = 99 AND bettype = 9 AND t.MaxPerMatch99MP < 1 THEN t.MaxPerMatch99MP
							END,
			MaxPerBall = CASE  WHEN mm.sporttype = 161 THEN t.MaxPerBall161
							END
	FROM #SMAs t
		CROSS APPLY( 
					SELECT sporttype,bettype,minbet,maxbet 
					FROM custSetting cs WITH(NOLOCK) 
					WHERE cs.custid = t.CustID
						AND cs.sporttype IN(1,99) 
						AND cs.bettype = 1
					UNION ALL
					SELECT sporttype,bettype,minbet,maxbet 
					FROM custSetting cs WITH(NOLOCK) 
					WHERE cs.custid = t.CustID
						AND cs.sporttype IN(1,99)
						AND cs.bettype = 9
					UNION ALL
					SELECT sporttype,bettype,minbet,maxbet 
					FROM custSetting cs WITH(NOLOCK) 
					WHERE cs.custid = t.CustID
						AND cs.sporttype IN(2,3,5,8,10,11) 
						AND bettype = 1
					UNION ALL
					SELECT sporttype,bettype,minbet,maxbet 
					FROM CustSetting3rd cs WITH(NOLOCK) 
					WHERE cs.custid = t.CustID
						AND cs.sporttype = 161
						AND bettype = 81
					UNION ALL
					SELECT sporttype,bettype,minbet,maxbet 
					FROM CustSetting3rd cs WITH(NOLOCK) 
					WHERE cs.custid = t.CustID
						AND cs.sporttype = 164
						AND bettype = 8101
				)mm

	--> Migrate data for member level
	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #Members_Batch
		DELETE TOP (1000) a
		OUTPUT   deleted.custid
				,deleted.maxpermatch		
				,deleted.MaxPerMatch1MP	
				,deleted.maxpermatch2	
				,deleted.maxpermatch3	
				,deleted.maxpermatch5	
				,deleted.maxpermatch8	
				,deleted.maxpermatch10	
				,deleted.maxpermatch11	
				,deleted.maxpermatch99	
				,deleted.MaxPerMatch99MP	
				,deleted.maxpermatch161	
				,deleted.maxpermatch164
				,deleted.maxperball161
		INTO #Members_Batch(
			 custid
			,maxpermatch		
			,MaxPerMatch1MP	
			,maxpermatch2	
			,maxpermatch3	
			,maxpermatch5	
			,maxpermatch8	
			,maxpermatch10	
			,maxpermatch11	
			,maxpermatch99	
			,MaxPerMatch99MP	
			,maxpermatch161	
			,maxpermatch164
			,maxperball161
			)
		FROM #Members a

		IF @@ROWCOUNT = 0 
			BREAK;

		INSERT INTO CustBetSetting_Member(CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch,MaxPayoutPerMatch,MaxPerNumber)
		SELECT t.custid,mm.sporttype,mm.bettype,mm.minbet,mm.maxbet,
				MaxPerMatch = CASE  WHEN mm.sporttype = 1 AND bettype = 1 THEN t.maxpermatch
									WHEN mm.sporttype = 1 AND bettype = 9 THEN t.MaxPerMatch1MP
									WHEN mm.sporttype = 2 AND bettype = 1 THEN t.maxpermatch2
									WHEN mm.sporttype = 3 AND bettype = 1 THEN t.maxpermatch3
									WHEN mm.sporttype = 5 AND bettype = 1 THEN t.maxpermatch5
									WHEN mm.sporttype = 8 AND bettype = 1 THEN t.maxpermatch8
									WHEN mm.sporttype = 10 AND bettype = 1 THEN t.maxpermatch10
									WHEN mm.sporttype = 11 AND bettype = 1 THEN t.maxpermatch11
									WHEN mm.sporttype = 99 AND bettype = 1 THEN t.maxpermatch99
									WHEN mm.sporttype = 99 AND bettype = 9 THEN t.MaxPerMatch99MP
									WHEN mm.sporttype = 161 THEN t.maxpermatch161
									WHEN mm.sporttype = 164 THEN t.maxpermatch164
								END,
				MaxPOPerMatch = CASE	WHEN mm.sporttype = 1 AND bettype = 1 AND t.maxpermatch >= 1 THEN t.maxpermatch*10
										--WHEN mm.sporttype = 1 AND bettype = 9 AND t.MaxPerMatch1MP >= 1 THEN t.MaxPerMatch1MP*10
										WHEN mm.sporttype = 2 AND bettype = 1 AND t.maxpermatch2 >= 1 THEN t.maxpermatch2*10
										WHEN mm.sporttype = 3 AND bettype = 1 AND t.maxpermatch3 >= 1 THEN t.maxpermatch3*10
										WHEN mm.sporttype = 5 AND bettype = 1 AND t.maxpermatch5 >= 1 THEN t.maxpermatch5*10
										WHEN mm.sporttype = 8 AND bettype = 1 AND t.maxpermatch8 >= 1 THEN t.maxpermatch8*10
										WHEN mm.sporttype = 10 AND bettype = 1 AND t.maxpermatch10 >= 1 THEN t.maxpermatch10*10
										WHEN mm.sporttype = 11 AND bettype = 1 AND t.maxpermatch11 >= 1 THEN t.maxpermatch11*10
										WHEN mm.sporttype = 99 AND bettype = 1 AND t.maxpermatch99 >= 1 THEN t.maxpermatch99*10
										--WHEN mm.sporttype = 99 AND bettype = 9 AND t.MaxPerMatch99MP >= 1 THEN t.MaxPerMatch99MP*10
										----------------Special value-----------------
										WHEN mm.sporttype = 1 AND bettype = 1 AND t.maxpermatch < 1 THEN t.maxpermatch
										--WHEN mm.sporttype = 1 AND bettype = 9 AND t.MaxPerMatch1MP < 1 THEN t.MaxPerMatch1MP
										WHEN mm.sporttype = 2 AND bettype = 1 AND t.maxpermatch2 < 1 THEN t.maxpermatch2
										WHEN mm.sporttype = 3 AND bettype = 1 AND t.maxpermatch3 < 1 THEN t.maxpermatch3
										WHEN mm.sporttype = 5 AND bettype = 1 AND t.maxpermatch5 < 1 THEN t.maxpermatch5
										WHEN mm.sporttype = 8 AND bettype = 1 AND t.maxpermatch8 < 1 THEN t.maxpermatch8
										WHEN mm.sporttype = 10 AND bettype = 1 AND t.maxpermatch10 < 1 THEN t.maxpermatch10
										WHEN mm.sporttype = 11 AND bettype = 1 AND t.maxpermatch11 < 1 THEN t.maxpermatch11
										WHEN mm.sporttype = 99 AND bettype = 1 AND t.maxpermatch99 < 1 THEN t.maxpermatch99
										--WHEN mm.sporttype = 99 AND bettype = 9 AND t.MaxPerMatch99MP < 1 THEN t.MaxPerMatch99MP
							END,
				MaxPerBall = CASE  WHEN mm.sporttype = 161 THEN t.MaxPerBall161
								END
		FROM #Members_Batch t
			CROSS APPLY( 
						SELECT sporttype,bettype,minbet,maxbet 
						FROM custSetting cs WITH(NOLOCK) 
						WHERE cs.custid = t.CustID
							AND cs.sporttype IN(1,99) 
							AND cs.bettype = 1
						UNION ALL
						SELECT sporttype,bettype,minbet,maxbet 
						FROM custSetting cs WITH(NOLOCK) 
						WHERE cs.custid = t.CustID
							AND cs.sporttype IN(1,99)
							AND cs.bettype = 9
						UNION ALL
						SELECT sporttype,bettype,minbet,maxbet 
						FROM custSetting cs WITH(NOLOCK) 
						WHERE cs.custid = t.CustID
							AND cs.sporttype IN(2,3,5,8,10,11) 
							AND bettype = 1
						UNION ALL
						SELECT sporttype,bettype,minbet,maxbet 
						FROM CustSetting3rd cs WITH(NOLOCK) 
						WHERE cs.custid = t.CustID
							AND cs.sporttype = 161
							AND bettype = 81
						UNION ALL
						SELECT sporttype,bettype,minbet,maxbet 
						FROM CustSetting3rd cs WITH(NOLOCK) 
						WHERE cs.custid = t.CustID
							AND cs.sporttype = 164
							AND bettype = 8101
					)mm
	END
	------------------------------------------MIGRATE DATA---------------------------------------------------------------

	DROP TABLE #Members
	DROP TABLE #SMAs
	DROP TABLE #Members_Batch
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS AND DBCUST(run finally)
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN custInfo c WITH (NOLOCK) ON ci.custid = c.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.custid <= @max_custid
	AND c.Enabled = 1

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
			
			
	WAITFOR DELAY '00:00:0.020'
END
DROP TABLE #supers
GO
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS AND DBCUST(run finally)
--------------------------------------------------------------------------------------