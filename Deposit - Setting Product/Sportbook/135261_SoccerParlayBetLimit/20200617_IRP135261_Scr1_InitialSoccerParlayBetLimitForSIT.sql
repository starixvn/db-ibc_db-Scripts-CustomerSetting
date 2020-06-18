/*
	Created: 20200617@Johnson
	Task: copy bet limit from soccer hdp for soccer parlay 
	DB: DBCUST/CustDB
*/

-- BEGIN STEP 1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
------------------------------------------------------

ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
	@srecommend INT		
	,@max_custid INT	
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN -- run at dbcust only
		
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_CustSetting') = 0 RETURN	
	
	CREATE TABLE #tblCust (custid INT PRIMARY KEY, mrecommend INT)
	DECLARE @tmpCust TABLE(Custid INT PRIMARY KEY)
		
	INSERT INTO #tblCust (custid,mrecommend)			
	SELECT custid,mrecommend
	FROM dbo.Customer WITH(NOLOCK)
	WHERE srecommend =@srecommend
		AND custid <= @max_custid
	OPTION( optimize for (@srecommend = 0))
	
	DELETE #tblCust 
	WHERE mrecommend IN (SELECT custid 
						FROM dbo.custinfo WITH(NOLOCK)
						WHERE srecommend=@srecommend 
						AND(username like '%Acc%'  OR username like '%AFF%' OR username like '%LocalBank%')
						AND roleid=3)
	OPTION( optimize for (@srecommend = 0))	
	
	DECLARE @rowcount INT 
	
	WHILE(1=1)
	BEGIN		
		DELETE TOP (5000) t
		OUTPUT DELETED.custid INTO @tmpCust
		FROM #tblCust t
		
		SELECT @rowcount = @@rowcount
		
		UPDATE cs
		SET cs.MinBet = cs2.MinBet,
			cs.MaxBet = cs2.MaxBet
		FROM Dep_CustSetting cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN Dep_CustSetting cs2 WITH(NOLOCK) ON cs.custid = cs2.custid 
															AND cs.sporttype = 1 AND cs.bettype = 9 AND cs.islive = 0
															AND cs2.sporttype = 1 AND cs2.bettype = 1 AND cs2.islive = 0
		WHERE cs.custid IN (SELECT custid FROM @tmpCust)													
		
		IF @rowcount < 5000 
			BREAK;
		
		DELETE @tmpCust
		
		WAITFOR DELAY '0:0:0.01'
	END	
END	
GO
-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 2: Run this SP at replicated DB -----
--------------------------------------------------------------------------------------
DECLARE @max_custid INT, @srecommend INT
SELECT  @max_custid= xxx ---input maxcustid
	
CREATE TABLE #Supers (custid INT, isFinished BIT DEFAULT(0))

INSERT INTO #supers(custid)
SELECT s.custid
FROM Dep_CustSuper s WITH(NOLOCK)
WHERE site IN ('spondemo','Athena000') 
	AND currency = 20

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_CustSetting3rd_19] 
			@srecommend = @srecommend, 			
			@max_custid=@max_custid,			
			@target = 'REPLICATED' 	
				
	--WAITFOR DELAY '00:00:00.280'			
END			
GO	
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
-----------------------------------------------------------------------------------	

---
-- BEGIN STEP 3: Run this SP at DBCust -----
-------------------------------------------------
DECLARE @max_custid INT, @srecommend INT
SELECT  @max_custid= xxx ---input maxcustid
	
CREATE TABLE #Supers (custid INT, isFinished BIT DEFAULT(0))

INSERT INTO #supers(custid)
SELECT s.custid
FROM Dep_CustSuper s WITH(NOLOCK)
WHERE site IN ('spondemo','Athena000') 
	AND currency = 20

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_CustSetting3rd_19] 
			@srecommend = @srecommend, 			
			@max_custid=@max_custid,			
			@target = 'DBCUST' 	
				
	--WAITFOR DELAY '00:00:00.280'			
END			
GO	