/*
	Created: Johnson
	Task: adjust bet setting Esports & Muay Thai for customers of 789y [RedmineID: #131163]
	DB: DBCUST/CustDB
	Date: 20200326
*/ 

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@srecommend INT	
	,@maxcustid INT	
	,@target VARCHAR(20)
AS
BEGIN	
	SET NOCOUNT ON
		
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbtrans only
		
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	
	CREATE TABLE #tblCust(custid INT,roleid TINYINT)
	DECLARE @tmpCust TABLE(custid INT)
	
	INSERT INTO #tblCust (custid,roleid)
	SELECT custid, roleid
	FROM custinfo WITH(NOLOCK)
	WHERE srecommend = @srecommend
		AND custid <= @maxcustid
	
	UPDATE cs
	SET cs.MinBet = 3,
		cs.MaxBet = 50,
		cs.MaxPerMatch = 250
	FROM dbo.CustBetSetting3rd_Agent cs WITH (UPDLOCK,ROWLOCK) 		
	WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid IN(2,3,4))
		AND sporttype IN (43,44)
		AND ((cs.MaxBet < 1 OR cs.MaxPerMatch < 1) 
			OR
			(cs.MinBet = cs.MaxBet AND cs.MinBet = cs.MaxPerMatch AND cs.MinBet <3)
		)
	
	DELETE #tblCust WHERE roleid > 1
	
	DELETE t
	FROM #tblCust t
	WHERE NOT EXISTS(
		SELECT 1
		FROM dbo.CustBetSetting3rd_Member cs WITH(NOLOCK) 
		WHERE sporttype IN(43,44)
			AND cs.custid = t.custid
			AND ((cs.MaxBet < 1 OR cs.MaxPerMatch < 1) 
				OR
				(cs.MinBet = cs.MaxBet AND cs.MinBet = cs.MaxPerMatch AND cs.MinBet <3)
			)	
	) 
	
	WHILE(1=1)
	BEGIN
		DELETE TOP(3000) FROM #tblCust
		OUTPUT DELETED.custid
		INTO @tmpCust
		
		IF @@ROWCOUNT = 0
			BREAK;
			
		UPDATE cs
		SET cs.MinBet = 3,
			cs.MaxBet = 50,
			cs.MaxPerMatch = 250
		FROM dbo.CustBetSetting3rd_Member cs WITH (UPDLOCK,ROWLOCK) 		
		WHERE custid IN (SELECT custid FROM @tmpCust)
			AND sporttype IN(43,44)
			AND ((cs.MaxBet < 1 OR cs.MaxPerMatch < 1) 
				OR
				(cs.MinBet = cs.MaxBet AND cs.MinBet = cs.MaxPerMatch AND cs.MinBet <3)
			)
		
		DELETE @tmpCust
		
		WAITFOR DELAY '00:00:00.1'
	END	
END
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	


-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 	
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND s.site = '789y'
	
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #Supers)

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid		
	WHERE isfinished = 0
			
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_DynamicCustSetting3rd_09] 
			@srecommend = @srecommend, 			
			@maxcustid = @max_custid,
			@target = 'REPLICATED' 					
END			
GO	
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
-----------------------------------------------------------------------------------	


---
---
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST/CUSTDB -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 	
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND s.site = '789y'
	
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #Supers)

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid		
	WHERE isfinished = 0
			
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_DynamicCustSetting3rd_09] 
			@srecommend = @srecommend, 			
			@maxcustid = @max_custid,
			@target = 'DBCUST' 							
END			
GO	
-- END STEP 3: RUN THIS SCRIPT AT DBCUST/CUSTDB -----
-----------------------------------------------------------------------------------	





