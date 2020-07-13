/*
	Created: 20200702@Johnson
	Task: update maxpermatch for NG, Happy 5 for HKK's supers
	DB: DBCUST/CUSTDB
*/

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_09]
    @custid INT,		
	@maxcustid INT,
    @Target VARCHAR(20) = ''
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF dbo.f_CheckRepTable('custinfo') = 0 RETURN
	
	--update maxpermatch
	CREATE TABLE #Downlines (custid INT PRIMARY KEY, roleid TINYINT, isfinished BIT DEFAULT 0)
	
	INSERT INTO #Downlines (custid,roleid)
	SELECT custid, roleid
	FROM custinfo WITH(NOLOCK)
	WHERE srecommend = @custid
		AND Enabled = 1
		AND custid <= @maxcustid
		
	DECLARE @BatchMember TABLE(custid INT PRIMARY KEY, roleid TINYINT)
	
	DECLARE @MaxPerMatch161 MONEY= 180000,
			@MaxPerBall161 MONEY = 60000,
			@MaxPerMatch164 MONEY = 120000
	
	WHILE(1=1)
	BEGIN
		DELETE @BatchMember
		
		UPDATE TOP (5000) t
		SET isfinished = 1
		OUTPUT DELETED.custid INTO @BatchMember(custid)
		FROM #Downlines t
		WHERE isfinished = 0		
	
		IF @@ROWCOUNT = 0 
			BREAK;
		
		UPDATE ci
		SET maxpermatch161 = CASE WHEN maxpermatch161 > @maxpermatch161 THEN @maxpermatch161 ELSE maxpermatch161 END,
			MaxPerBall161 = CASE WHEN maxPerBall161 > @maxPerBall161 THEN @maxPerBall161 ELSE maxPerBall161 END,
			maxpermatch164 = CASE WHEN maxpermatch164 > @maxpermatch164	THEN @maxpermatch164 ELSE maxpermatch164 END
		FROM custinfo ci WITH(UPDLOCK,ROWLOCK)
		WHERE custid IN (SELECT custid FROM @BatchMember)
			AND (maxpermatch161 > @maxpermatch161
				OR MaxPerBall161 > @maxPerBall161
				OR maxpermatch164 > @maxpermatch164				
				)		
	END
	
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
	
	EXEC dbo.[Acc_CustomerInfo_Execrep_09] 
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
	
	EXEC dbo.[Acc_CustomerInfo_Execrep_09] 
			@custid = @custid, 		
			@maxcustid = @maxcustid,	
			@target = 'DBCUST' 	
				
	WAITFOR DELAY '00:00:00.280'			
END			
GO	
-- END STEP 2: RUN THIS SCRIPT AT DBCUST/CUSTDB -----
-----------------------------------------------------------------------------------	
		