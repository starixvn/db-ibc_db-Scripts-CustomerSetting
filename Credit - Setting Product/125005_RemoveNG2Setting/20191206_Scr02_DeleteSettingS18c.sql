/*
	Created: Johnson
	Date: 2019-12-06
	Task: delete settings for sport 18C of NG2	
	DB: DBCUST/CUSTDB
*/
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@srecommend INT		
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN		
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
	
	CREATE TABLE #tblCust(custid INT PRIMARY KEY, roleid TINYINT)
	DECLARE @tmpCust TABLE (custid INT PRIMARY KEY)
	DECLARE @count INT 
	
	INSERT INTO #tblCust(custid,roleid)
	SELECT custid, roleid 	
	FROM dbo.custInfo WITH(NOLOCK)
	WHERE srecommend = @srecommend
		AND custid <= @maxcustid
	
	DELETE CustPTGroupSetting3rd_Member WITH(UPDLOCK,ROWLOCK)
	WHERE AgentID IN (SELECT custid FROM #tblCust WHERE roleid = 2)
		AND sporttype = 216
		
	WHILE(1=1)
	BEGIN
		DELETE TOP (500) t
		OUTPUT DELETED.custid INTO @tmpCust
		FROM #tblCust t
		WHERE roleid IN (2,3,4)
		
		SELECT @count = @@ROWCOUNT
		
		DELETE CustPTSetting3rd_Agent WITH(UPDLOCK,ROWLOCK)
		WHERE custid IN (SELECT custid FROM @tmpCust)
			AND sporttype = 216
		
		DELETE CustBetSetting3rd_Agent WITH(UPDLOCK,ROWLOCK)
		WHERE custid IN (SELECT custid FROM @tmpCust)
			AND sporttype = 216 
			
		IF @count < 500
			BREAK;
		
		DELETE @tmpCust
	END
	
	DELETE @tmpCust
	
	WHILE(1=1)
	BEGIN
		DELETE TOP (500) t
		OUTPUT DELETED.custid INTO @tmpCust
		FROM #tblCust t
		WHERE roleid = 1
		
		SELECT @count = @@ROWCOUNT
		
		--2 rows setting for each customer
		DELETE CustPTSetting3rd_Member WITH(UPDLOCK,ROWLOCK)
		WHERE custid IN (SELECT custid FROM @tmpCust)
			AND sporttype = 216
		
		--11 rows setting for each customer
		DELETE CustBetSetting3rd_Member WITH(UPDLOCK,ROWLOCK)
		WHERE custid IN (SELECT custid FROM @tmpCust)
			AND sporttype = 216 
			
		IF @count < 500
			BREAK;
		
		DELETE @tmpCust
	END
END
GO
-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 2: Run this SP at replicated DB -----
--------------------------------------------------------------------------------------

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))

DECLARE @max_custid INT, @srecommend INT
SELECT  @max_custid= xxx ---input maxcustid

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4 	
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.custid <= @max_custid
	AND EXISTS(SELECT TOP 1 1 
			FROM CustPTSetting3rd_Agent WITH(NOLOCK) 
			WHERE custid = ci.custid AND sporttype = 216
			)
	
	
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
	
	EXEC dbo.[Acc_DynamicCustSetting3rd_09] 
			@srecommend = @srecommend,
			@maxcustid = @max_custid,
			@target = 'REPLICATED' 	
				
	WAITFOR DELAY '00:00:00.280'			
END			
GO		
-- END STEP 2: Run this SP at replicated DB -----
--------------------------------------------------------------------------------------


-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))

DECLARE @max_custid INT, @srecommend INT
SELECT  @max_custid= xxx ---input maxcustid

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4 	
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.custid <= @max_custid
	AND EXISTS(SELECT TOP 1 1 
			FROM CustPTSetting3rd_Agent WITH(NOLOCK) 
			WHERE custid = ci.custid AND sporttype = 216
			)
	
	
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
	
	EXEC dbo.[Acc_DynamicCustSetting3rd_09] 
			@srecommend = @srecommend,
			@maxcustid = @max_custid,
			@target = 'DBCUST' 	
				
	WAITFOR DELAY '00:00:00.280'			
END			
GO	
-- END STEP 3: Run this SP at DBCust -----
-------------------------------------------------