/*
	Created: 20210429@Johnson
	Task: migrate data from ProblemAccount to new source
	DB: DBCUST-CustDB
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

ALTER PROCEDURE [dbo].[Acc_Custsetting3rd_19]
	@target VARCHAR(20) = null	
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustSuper') = 0 RETURN
	IF dbo.f_CheckRepTable('ProblemAccountClassification') = 0 RETURN
	IF dbo.f_CheckRepTable('ProblemAccount') = 0 RETURN
	
	DELETE ProblemAccountClassification WITH(ROWLOCK)
	
	--Import from ProblemAccount table 
	--70695 rows affects
	INSERT INTO ProblemAccountClassification(custid,IsReviewed,ModifiedDate)
	SELECT p.custid, p.IsReviewed, p.CreatedDate
	FROM ProblemAccount p WITH (NOLOCK)
		INNER JOIN custinfo ci WITH (NOLOCK) on p.CustId = ci.custid	
	WHERE enabled = 1
		AND srecommend NOT IN (SELECT custid FROM dep_custsuper WITH(NOLOCK)))	
		AND CustomerClass IN (8,9,10,11,13)
		AND NOT EXISTS (SELECT 1 FROM ProblemAccountClassification pc WITH(NOLOCK) WHERE pc.custid = ci.custid)
	
	--import PA from CTS & RobotUsers which not have in ProblemAccount table
	--will get lastest when release
	;WITH t AS (
		--List PA not robot users
		SELECT 38398482 as custid, '2021-05-03 22:35:52.580' as CreatedDate--TP087
		--List robot users
		UNION ALL SELECT 48567454,	'2021-02-28 12:17:00'--	RW010610J00
	)
	INSERT INTO ProblemAccountClassification(custid,IsReviewed,ModifiedDate)
	SELECT custid, 0, CreatedDate
	FROM t
	WHERE NOT EXISTS (SELECT 1 FROM ProblemAccountClassification pc WITH(NOLOCK) WHERE pc.custid = t.custid)
	
END	
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
EXEC Acc_Custsetting3rd_19 @target = 'REPLICATED' 

-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------


-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST/CustDB -----
--------------------------------------------------------------------------------------
EXEC Acc_Custsetting3rd_19 @target = 'DBCUST' 

-- END STEP 3: RUN THIS SCRIPT AT DBCUST/CustDB -----
--------------------------------------------------------------------------------------


