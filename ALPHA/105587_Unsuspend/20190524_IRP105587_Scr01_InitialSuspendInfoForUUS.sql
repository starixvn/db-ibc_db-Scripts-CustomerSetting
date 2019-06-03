/*
	Created: Johnson
	Date: 2019-05-24
	Task: initial suspendinfo for UUS customers
	DB: DBCust/CustDB
*/


 ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
	@srecommend INT		
	,@max_custid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('CustProductStatus') = 1	   
	   )
		RETURN
	
	CREATE TABLE #tblCust (CustID INT PRIMARY KEY, roleid TINYINT, suspend BIT, suspendSuper BIT, suspendMaster BIT, suspendAgent BIT, suspendInfo TINYINT)	
	DECLARE @tmpCust TABLE (custid INT PRIMARY KEY, suspendInfo TINYINT)
	
	INSERT INTO #tblCust(CustID,roleid,suspend,suspendSuper,suspendMaster,suspendAgent, suspendInfo)
	SELECT ci.custid, ci.roleid, ISNULL(ci.reject,0), ISNULL(s.reject,0), ISNULL(m.reject,0), ISNULL(a.reject,0),0
	FROM custinfo ci WITH(NOLOCK)
		LEFT JOIN custinfo s WITH(NOLOCK) on ci.srecommend = s.custid
		LEFT JOIN custinfo m WITH(NOLOCK) on ci.mrecommend = m.custid
		LEFT JOIN custinfo a WITH(NOLOCK) on ci.recommend = a.custid
	WHERE ci.srecommend = @srecommend
		AND ci.custid <= @max_custid
	
	DECLARE @suspendSuper TINYINT = 0,
			@suspendMaster TINYINT = 0,
			@suspendAgent TINYINT = 0,
			@SuspendMember TINYINT = 0,
			@rowcount INT
			
	UPDATE #tblCust
	SET @suspendSuper = 0,
		@suspendMaster =0,
		@suspendAgent = 0,
		@SuspendMember = 0,
		@suspendSuper = (SELECT suspendInfo FROM dbo.f_GenerateSuspendInfo_UAT1(4,suspendSuper,@suspendSuper)),
		@suspendMaster = CASE WHEN roleid < 4 AND suspendSuper =0  
								THEN (SELECT suspendInfo FROM dbo.f_GenerateSuspendInfo_UAT1(3,suspendMaster,@suspendSuper))
								ELSE @suspendSuper END,
		@suspendAgent = CASE WHEN roleid < 3 AND suspendSuper = 0 AND suspendMaster = 0 
								THEN (SELECT suspendInfo FROM dbo.f_GenerateSuspendInfo_UAT1(2,suspendAgent,@suspendMaster))
								ELSE @suspendMaster END,
		@suspendMember = CASE WHEN roleid < 2 AND suspendSuper = 0 AND suspendMaster = 0 AND suspendAgent = 0
								THEN (SELECT suspendInfo FROM dbo.f_GenerateSuspendInfo_UAT1(1,suspend,@suspendAgent))
								ELSE @suspendAgent END,
		suspendInfo = CASE WHEN roleid = 4 THEN @suspendSuper
							WHEN roleid = 3 THEN @suspendMaster
							WHEN roleid =2 THEN @suspendAgent							
							WHEN roleid =1 THEN @SuspendMember
							ELSE 0 END
							
	
	WHILE(1=1)
	BEGIN			
		DELETE TOP (5000) t
		OUTPUT DELETED.custid, DELETED.SuspendInfo
		INTO @tmpCust(custid, suspendInfo)
		FROM #tblCust t
		
		SELECT @rowcount = @@ROWCOUNT
		
		UPDATE cs
		SET suspendInfo = t.SuspendInfo
		FROM custProductStatus cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN @tmpCust t ON cs.custid = t.custid
		
		IF @rowcount < 5000
			BREAK;
		
		DELETE @tmpCust
		
		WAITFOR DELAY '0:0:0.01'
	END
	
	DROP TABLE #tblCust
END
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	


---
---
-- BEGIN STEP 2: Run this SP at replicated DB ----- -----
--------------------------------------------------------------------------------------
DECLARE @srecommend INT,
		@max_custid INT

CREATE TABLE #Super(CustID INT, isfinished BIT DEFAULT(0))

SELECT @max_custid = xxx

INSERT INTO #Super(custid)
SELECT ci.custid 
FROM dbo.customer c WITH (Nolock) 
	INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
WHERE ci.roleid = 4
	AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))	
	AND ci.custid NOT IN (SELECT custid FROM dbo.CustSuper WITH(NOLOCK) WHERE isInternal = 1)
	AND ci.Enabled = 1
	AND s.islicensee = 0
	AND c.username NOT LIKE '3rdSuper%'
	AND ci.currency = 20

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Super
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.[Acc_DynamicCustomerInfo_09] @srecommend = @srecommend	
			,@max_custid = @max_custid
			,@target = 'REPLICATED'
END			
GO	
-- END STEP 2:  Run this SP at replicated DB ----------
-----------------------------------------------------------------------------------	

------------------------------------------------------	
-- BEGIN STEP 3: Run this SP at DBCUST-----
--------------------------------------------------------------------------------------
DECLARE @srecommend INT,
		@max_custid INT

CREATE TABLE #Super(CustID INT, isfinished BIT DEFAULT(0))

SELECT @max_custid = xxx

INSERT INTO #Super(custid)
SELECT ci.custid 
FROM dbo.customer c WITH (Nolock) 
	INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
WHERE ci.roleid = 4
	AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))	
	AND ci.custid NOT IN (SELECT custid FROM dbo.CustSuper WITH(NOLOCK) WHERE isInternal = 1)
	AND ci.Enabled = 1
	AND s.islicensee = 0
	AND c.username NOT LIKE '3rdSuper%'
	AND ci.currency = 20

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Super
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.[Acc_DynamicCustomerInfo_09] @srecommend = @srecommend	
			,@max_custid = @max_custid
			,@target = 'REPLICATED'
END			
GO			
-- END STEP 3: RUN THIS SCRIPT AT DBCUST  -----
-----------------------------------------------------------------------------------	

		