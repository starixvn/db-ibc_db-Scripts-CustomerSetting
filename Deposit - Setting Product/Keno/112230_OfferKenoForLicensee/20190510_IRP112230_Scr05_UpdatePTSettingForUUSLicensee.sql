/*
	Created: 20190510@Johnson
	Task: update PT = 0.9 for all UUS licensee customers 
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
	IF dbo.f_CheckRepTable('CustSettingGame') = 0 RETURN
	
	CREATE TABLE #tblCust (custid INT, mrecommend INT, roleid TINYINT)
	DECLARE @tmpCust TABLE(Custid INT, roleid TINYINT)
	DECLARE @rowcount INT
	
	INSERT INTO #tblCust (custid,roleid,mrecommend)			
	SELECT custid,roleid,mrecommend
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
	
	WHILE(1=1)
	BEGIN			
		DELETE TOP (5000) t
		OUTPUT DELETED.custid, DELETED.roleid INTO @tmpCust
		FROM #tblCust t
		
		SELECT @rowcount = @@rowcount	
		
		UPDATE cs
		SET spositiontaking = CASE WHEN roleid = 4 THEN 0.9 ELSE spositiontaking END,
			mpositiontaking = CASE WHEN roleid IN (4,3) THEN 0.9 ELSE mpositiontaking END,
			apositiontaking = CASE WHEN roleid IN (4,2,1) THEN 0.9 ELSE apositiontaking END		
		FROM CustSettingGame cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN @tmpCust t ON cs.custid = t.custid
		WHERE sporttype = 202
			AND bettype = 1501
		
		IF @rowcount < 5000
			BREAK;
	END	
	
	DROP TABLE #tblCust
END
GO

-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 2: Run this SP at replicated DB -----
--------------------------------------------------------------------------------------

DECLARE @max_custid INT, @srecommend INT, @currency INT
SELECT  @max_custid= xxx ---input maxcustid
	
CREATE TABLE #Supers (custid INT,isFinished BIT DEFAULT(0))

INSERT INTO #Supers (custid)
SELECT custid
FROM Dep_custSuper WITH(NOLOCK)
WHERE currency = 20

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

DECLARE @max_custid INT, @srecommend INT, @currency INT
SELECT  @max_custid= xxx ---input maxcustid
	
CREATE TABLE #Supers (custid INT,isFinished BIT DEFAULT(0))

INSERT INTO #Supers (custid)
SELECT custid
FROM Dep_custSuper WITH(NOLOCK)
WHERE currency = 20

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
---
-- END STEP 3: Run this SP at DBCust -----
-------------------------------------------------

	