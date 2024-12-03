/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20241018@Johnson
	Task: remove customer settings for bitcoin [redmine: #201396]
	DB: DBCUST/CUSTDB
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@srecommend INT	
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','DBSPARE','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','DBSPARE','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Member') = 0 RETURN
	
	CREATE TABLE #tblCust (custid INT PRIMARY KEY, roleid TINYINT)
	DECLARE @BatchCust TABLE (custid INT PRIMARY KEY)
	DECLARE @Sporttype INT = 175,
			@Bettype INT = 7901
			
	INSERT INTO #tblCust(custid,roleid)
	SELECT custid, roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend 
		AND Enabled = 1 
		AND custid <= @maxcustid 
	
	DELETE cs
	FROM CustPTGroupSetting3rd_Member cs WITH(ROWLOCK)
	WHERE AgentID IN (SELECT custid FROM #tblCust WHERE roleid = 2)
		AND Sporttype = @Sporttype
		AND Bettype = @Bettype
			
	WHILE (1=1)
	BEGIN
		DELETE TOP (5000) t
		OUTPUT DELETED.custid INTO @BatchCust(custid)
		FROM #tblCust t
		WHERE roleid > 1
		
		IF @@ROWCOUNT = 0
			BREAK;
		
		DELETE cs
		FROM CustPTSetting3rd_Agent cs WITH(ROWLOCK)
		WHERE custid IN (SELECT custid FROM @BatchCust)
			AND Sporttype = @Sporttype
			AND Bettype = @Bettype	
		
		DELETE cs
		FROM CustDiscount3rd_Agent cs WITH(ROWLOCK)
		WHERE custid IN (SELECT custid FROM @BatchCust)
			AND Sporttype = @Sporttype
			AND Bettype = @Bettype	
		
		DELETE @BatchCust	
	END
	
	WHILE (1=1)
	BEGIN
		DELETE TOP (5000) t
		OUTPUT DELETED.custid INTO @BatchCust(custid)
		FROM #tblCust t
		WHERE roleid = 1
		
		IF @@ROWCOUNT = 0
			BREAK;
			
		DELETE cs
		FROM CustPTSetting3rd_Member cs WITH(ROWLOCK)
		WHERE custid IN (SELECT custid FROM @BatchCust)
			AND Sporttype = @Sporttype
			AND Bettype = @Bettype	
		
		DELETE cs
		FROM CustDiscount3rd_Member cs WITH(ROWLOCK)
		WHERE custid IN (SELECT custid FROM @BatchCust)
			AND Sporttype = @Sporttype
			AND Bettype = @Bettype	
		
		DELETE @BatchCust	
	END
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;
	
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT, @Target VARCHAR(20)

SELECT @max_custid = xxx
IF @@SERVERNAME IN ('DBCUST','DBSPARE','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SELECT @Target = 'DBCUST'
ELSE 
	SELECT @Target = 'REPLICATED'
	
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
	

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = @target
			
			
	waitfor delay '00:00:0.280'
END
GO
