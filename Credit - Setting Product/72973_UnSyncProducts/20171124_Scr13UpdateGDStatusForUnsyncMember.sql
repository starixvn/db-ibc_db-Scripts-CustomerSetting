/*
	Created: Johnson
	Date: 2017-11-24
	Task: update hideGoldDeluxe = 0, syncCasino =1 for un-sync Members
	DBCust/CustDB
*/


 ALTER PROCEDURE [dbo].[Acc_ExecRep_Cust_09]
	@srecommend INT		
	,@max_custid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbtrans only
	
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 )
		RETURN
		
	UPDATE dbo.custinfo WITH(UPDLOCK,ROWLOCK)
	SET HideGoldDeluxe = CASE WHEN HideGoldDeluxe = 1 AND currency NOT IN (44,45,62) THEN 0 ELSE HideGoldDeluxe END,
		DisableGoldDeluxe = CASE WHEN HideGoldDeluxe = 1 AND currency NOT IN (44,45,62) THEN 1 ELSE DisableGoldDeluxe END,
		SyncCasino = CASE WHEN SyncCasino = 0 THEN 1 ELSE SyncCasino END,
		DisableCasino = CASE WHEN SyncCasino = 0 THEN 1 ELSE DisableCasino END
	WHERE srecommend = @srecommend
		AND custid <= @max_custid
		AND roleid = 1
		AND enabled = 1
		AND (HideGoldDeluxe = 1 OR SyncCasino = 0)
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	


---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT DBTRANS.CustDB -----
--------------------------------------------------------------------------------------
DECLARE @srecommend INT,
		@max_custid INT

CREATE TABLE #Super(CustID INT, isfinished BIT DEFAULT(0))

SELECT @max_custid = xxx

INSERT INTO #Super(custid)
SELECT ci.custid 
FROM dbo.customer c WITH (Nolock) 
	INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	INNER JOIN DB06.bodb02.dbo.site s WITH(NOLOCK) ON c.site = s.site
WHERE ci.roleid = 4
	AND ci.custid NOT IN (SELECT custid FROM DB06.bodb02.dbo.Dep_CustSuper WITH(NOLOCK))	
	AND ci.custid NOT IN (SELECT custid FROM DB06.bodb02.dbo.CustSuper WITH(NOLOCK) WHERE isInternal = 1)
	AND ci.Enabled = 1
	AND s.islicensee = 0
	AND c.username NOT LIKE '3rdSuper%'

SELECT DISTINCT ci.srecommend
INTO #tmp
FROM dbo.CustInfo ci WITH(NOLOCK)	 	
WHERE srecommend IN (SELECT custid FROM #super)
	AND ci.custid <= @max_custid
	AND roleid = 1
	AND enabled = 1
	AND (HideGoldDeluxe = 1 OR SyncCasino = 0)

DELETE #Super
WHERE custid NOT IN (SELECT srecommend FROM #tmp)
	
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Super
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.[Acc_ExecRep_Cust_09] @srecommend = @srecommend	
			,@max_custid = @max_custid
			,@target = 'REPLICATED'
	
	waitfor delay '00:00:0.280'
END			
GO	
-- END STEP 2: RUN THIS SCRIPT AT DBTRANS.CustDB -----
-----------------------------------------------------------------------------------	

---
---
-- BEGIN STEP 3: RUN THIS SCRIPT AT OTHER REPLICATED SERVERS -----
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

SELECT DISTINCT ci.srecommend
INTO #tmp
FROM dbo.CustInfo ci WITH(NOLOCK)	 	
WHERE srecommend IN (SELECT custid FROM #super)
	AND ci.custid <= @max_custid
	AND roleid = 1
	AND enabled = 1
	AND (HideGoldDeluxe = 1 OR SyncCasino = 0)

DELETE #Super
WHERE custid NOT IN (SELECT srecommend FROM #tmp)
	
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Super
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.[Acc_ExecRep_Cust_09] @srecommend = @srecommend	
			,@max_custid = @max_custid
			,@target = 'REPLICATED'
	
	waitfor delay '00:00:0.280'
END			
GO	
-- END STEP 3: RUN THIS SCRIPT AT OTHER REPLICATED SERVERS -----
-----------------------------------------------------------------------------------	

---
---
-- BEGIN STEP 4: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
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

SELECT DISTINCT ci.srecommend
INTO #tmp
FROM dbo.CustInfo ci WITH(NOLOCK)	 	
WHERE srecommend IN (SELECT custid FROM #super)
	AND ci.custid <= @max_custid
	AND roleid = 1
	AND enabled = 1
	AND (HideGoldDeluxe = 1 OR SyncCasino = 0)

DELETE #Super
WHERE custid NOT IN (SELECT srecommend FROM #tmp)
	
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Super
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.[Acc_ExecRep_Cust_09] @srecommend = @srecommend
			,@max_custid = @max_custid
			,@target = 'DBCUST'
	
	waitfor delay '00:00:0.280'
END			
GO	
-- END STEP 4: RUN THIS SCRIPT AT DBCUST -----
-----------------------------------------------------------------------------------

	
	