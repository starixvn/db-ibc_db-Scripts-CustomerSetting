/*
	Created: 20200728@Johnson
	Task: update minbet for HKK's supers
	DB: DBCUST/CUSTDB
*/

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

ALTER PROCEDURE [dbo].[Acc_CustSetting_19]
    @custid INT,		
	@maxcustid INT,
    @Target VARCHAR(20) = ''
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF NOT(dbo.f_CheckRepTable('custinfo') = 1 
		AND dbo.f_CheckRepTable('CustSetting') = 1
		AND dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 1
		AND dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 1	
		)
	RETURN
	
	CREATE TABLE #Downlines (custid INT PRIMARY KEY, roleid TINYINT, isfinished BIT DEFAULT 0)
	DECLARE @BatchMember TABLE(custid INT PRIMARY KEY, roleid TINYINT)
		
	INSERT INTO #Downlines (custid,roleid)
	SELECT custid, roleid
	FROM custinfo WITH(NOLOCK)
	WHERE srecommend = @custid
		AND Enabled = 1
		AND custid <= @maxcustid
			
	WHILE(1=1)
	BEGIN
		DELETE @BatchMember
		
		;WITH T AS (
			SELECT TOP (500) custid
			FROM #Downlines t
			WHERE t.isfinished = 0
			ORDER BY t.roleid DESC
		)
		UPDATE t1
		SET isfinished = 1
		OUTPUT DELETED.custid, DELETED.roleid INTO @BatchMember(custid,roleid)
		FROM #Downlines t1
		WHERE t1.custid IN (SELECT custid FROM t)
		
		IF @@ROWCOUNT = 0
			BREAK;
			
		UPDATE cs
		SET MinBet = CASE WHEN MaxBet >= 10 THEN 10 ELSE MinBet END
		FROM CustSetting cs WITH(UPDLOCK,ROWLOCK)
		WHERE custid IN (SELECT custid FROM @BatchMember)
			AND minbet <> 0
		
		IF EXISTS(SELECT 1 FROM @BatchMember WHERE roleid > 1)
		BEGIN
			UPDATE cs
			SET cs.MinBet = CASE WHEN MaxBet >= 10 THEN 10 ELSE cs.MinBet END				
			FROM CustBetSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
			WHERE custid IN (SELECT custid FROM @BatchMember WHERE roleid > 1)
				AND minbet <> 0
				AND sporttype IN (43,44) 
		END
		
		IF EXISTS(SELECT 1 FROM @BatchMember WHERE roleid = 1)
		BEGIN
			UPDATE cs
			SET cs.MinBet = CASE WHEN MaxBet >= 10 THEN 10 ELSE cs.MinBet END				
			FROM CustBetSetting3rd_Member cs WITH(UPDLOCK,ROWLOCK)
			WHERE custid IN (SELECT custid FROM @BatchMember WHERE roleid = 1)
				AND minbet <> 0
				AND sporttype IN (43,44) 
		END
	END	
	
	DROP TABLE #Downlines
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	


---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @custid INT,		
		@maxcustid INT = xxx

CREATE TABLE #Supers(CustID INT, isfinished BIT DEFAULT(0))

INSERT INTO #Supers(custid)
SELECT custid
FROM vw_customer WITH(NOLOCK)
WHERE currency = 67
	AND roleid = 4
	AND site IN ('733333','222223','722222')

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #Supers )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of SMA: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@custid = custid			
	WHERE isfinished = 0
			
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @custid) WITH NOWAIT
	
	EXEC dbo.[Acc_CustSetting_19] 
			@custid = @custid, 			
			@maxcustid = @maxcustid,			
			@target = 'REPLICATED' 	
				
	WAITFOR DELAY '00:00:00.280'			
END			
GO	
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
-----------------------------------------------------------------------------------	


---
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST/CUSTDB -----
--------------------------------------------------------------------------------------
DECLARE @custid INT,		
		@maxcustid INT = xxx

CREATE TABLE #Supers(CustID INT, isfinished BIT DEFAULT(0))

INSERT INTO #Supers(custid)
SELECT custid
FROM vw_customer WITH(NOLOCK)
WHERE currency = 67
	AND roleid = 4
	AND site IN ('733333','222223','722222')

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #Supers )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of SMA: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@custid = custid			
	WHERE isfinished = 0
			
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @custid) WITH NOWAIT
	
	EXEC dbo.[Acc_CustSetting_19] 
			@custid = @custid, 			
			@maxcustid = @maxcustid,			
			@target = 'DBCUST' 	
				
	WAITFOR DELAY '00:00:00.280'			
END			
GO	
-- END STEP 3: RUN THIS SCRIPT AT DBCUST/CUSTDB -----
-----------------------------------------------------------------------------------	
				