/*
	Created: 20171124@Johnson
	Task : Update sync status for un-sync members for VB,AB
	DB:  DBCUST/CustDB
*/
 
 ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
	@srecommend INT, 
	@max_custid INT,
	@target VARCHAR(20)	
AS
BEGIN
	SET NOCOUNT ON ;
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbcust only
		
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustProductStatus') = 0 RETURN--VB,AB
	IF dbo.f_CheckRepTable('ProductStatusProfile') = 0 RETURN
		
	DECLARE @tmpMembers TABLE(CustID INT PRIMARY KEY, SyncAB BIT, SyncVB BIT, xmlStrDisabled XML DEFAULT(''), xmlStrSynced XML DEFAULT(''))
	
	DECLARE @bitmapOrderVB TINYINT,
			@bitmapOrderAB TINYINT						
	
	SELECT @bitmapOrderAB = MAX(CASE WHEN sporttype = 211 AND bettype = 2401 THEN bitmapOrder ELSE 0 END),		
		@bitmapOrderVB = MAX(CASE WHEN sporttype = 212 AND bettype = 4001 THEN bitmapOrder ELSE 0 END)
	FROM dbo.ProductStatusProfile WITH(NOLOCK)
	WHERE sporttype IN (211,212)
		
	INSERT INTO @tmpMembers(custID, SyncAB, SyncVB)
	SELECT ci.custid,1,1 		
	FROM dbo.CustInfo ci WITH(NOLOCK)				
	WHERE srecommend = @srecommend
		AND ci.custid <= @max_custid
		AND roleid = 1
		AND enabled = 1
	
	UPDATE t
	SET syncAB = dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderAB),
		syncVB = dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderVB)
	FROM @tmpMembers t
		INNER JOIN dbo.CustProductStatus p WITH(NOLOCK) ON t.custid = p.custid
	
	DELETE t
	WHERE SyncAB = 1 AND SyncVB = 1
	
	UPDATE t
	SET xmlStrDisabled = (SELECT 
					 (SELECT bitmapOrder as '@b', 1 as '@s'
					 FROM dbo.ProductStatusProfile WITH(NOLOCK)
					 WHERE 1=CASE WHEN (syncVB = 0 AND Sporttype = 212 ) or (syncAB = 0 AND Sporttype = 211) then 1 ELSE 0 end
					  FOR XML path('r'),TYPE) 
					FOR XML PATH('root'), TYPE
				),
		xmlStrSynced = (SELECT 
					 (SELECT bitmapOrder as '@b', 1 as '@s'
					 FROM dbo.ProductStatusProfile WITH(NOLOCK)
					 WHERE 1=CASE WHEN (syncVB = 0 AND Sporttype = 212 ) or (syncAB = 0 AND Sporttype = 211) then 1 ELSE 0 end
					  for XML path('r'),TYPE) 
					FOR XML PATH('root'), TYPE
				)	
	FROM @tmpMembers t
	
	UPDATE cs	
	SET bitmapHasSynced =(SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (bitmapHasSynced, CONVERT(VARCHAR(MAX),t.xmlStrSynced))),
		bitmapIsDisabled =(SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (bitmapIsDisabled, CONVERT(VARCHAR(MAX),t.xmlStrDisabled)))
	FROM dbo.CustProductStatus cs WITH (ROWLOCK,UPDLOCK)
		INNER JOIN @tmpMembers t ON cs.custID = t.custID
	WHERE syncAB = 0 OR syncVB = 0
	
END	
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	


---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @srecommend INT,
		@max_custid INT,
		@bitmapOrderVB TINYINT,
		@bitmapOrderAB TINYINT	
		
CREATE TABLE #Super(CustID INT, isfinished BIT DEFAULT(0))

SELECT @max_custid = xxx
						
SELECT @bitmapOrderAB = MAX(CASE WHEN sporttype = 211 AND bettype = 2401 THEN bitmapOrder ELSE 0 END),		
	@bitmapOrderVB = MAX(CASE WHEN sporttype = 212 AND bettype = 4001 THEN bitmapOrder ELSE 0 END)
FROM dbo.ProductStatusProfile WITH(NOLOCK)
WHERE sporttype IN (211,212)

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
	INNER JOIN dbo.CustProductStatus p WITH(NOLOCK) ON ci.custid = p.custid
WHERE srecommend IN (SELECT custid FROM #super)
	AND ci.custid <= @max_custid
	AND roleid = 1
	AND enabled = 1
	AND (dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderAB) = 0
		OR dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderVB) = 0
		)

DELETE #Super
WHERE custid NOT IN (SELECT srecommend FROM #tmp)
	
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
	
	waitfor delay '00:00:0.280'
END			
GO	
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
-----------------------------------------------------------------------------------	

---
---
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------	
DECLARE @srecommend INT,
		@max_custid INT,
		@bitmapOrderVB TINYINT,
		@bitmapOrderAB TINYINT	
		
CREATE TABLE #Super(CustID INT, isfinished BIT DEFAULT(0))

SELECT @max_custid = xxx
						
SELECT @bitmapOrderAB = MAX(CASE WHEN sporttype = 211 AND bettype = 2401 THEN bitmapOrder ELSE 0 END),		
	@bitmapOrderVB = MAX(CASE WHEN sporttype = 212 AND bettype = 4001 THEN bitmapOrder ELSE 0 END)
FROM dbo.ProductStatusProfile WITH(NOLOCK)
WHERE sporttype IN (211,212)

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
	INNER JOIN dbo.CustProductStatus p WITH(NOLOCK) ON ci.custid = p.custid
WHERE srecommend IN (SELECT custid FROM #super)
	AND ci.custid <= @max_custid
	AND roleid = 1
	AND enabled = 1
	AND (dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderAB) = 0
		OR dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderVB) = 0
		)

DELETE #Super
WHERE custid NOT IN (SELECT srecommend FROM #tmp)
	
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Super
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.[Acc_DynamicCustomerInfo_09] @srecommend = @srecommend
			,@max_custid = @max_custid
			,@target = 'DBCUST'
	
	waitfor delay '00:00:0.280'
END			
GO	
-- END STEP 3: RUN THIS SCRIPT AT DBCUST -----
-----------------------------------------------------------------------------------
