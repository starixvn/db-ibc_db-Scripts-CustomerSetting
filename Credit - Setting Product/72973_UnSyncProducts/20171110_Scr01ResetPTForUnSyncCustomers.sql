/*
	Created: 20171110@Johnson
	Task : Reset PT settings for un-sync masters for GD,VB,AB
	DB:  DBCUST/CustDB
*/

ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
	@srecommend INT, 
	@target VARCHAR(20)	
AS
BEGIN
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbcust only
		
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN
	IF dbo.f_CheckRepTable('CustSettingGame') = 0 RETURN--GD
	IF dbo.f_CheckRepTable('CustOverrideGame') = 0 RETURN	
	
	IF dbo.f_CheckRepTable('CustProductStatus') = 0 RETURN--VB,AB
	IF dbo.f_CheckRepTable('ProductStatusProfile') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	
	CREATE TABLE #tmpCust (CustID INT PRIMARY KEY, roleid INT, UplineID INT, SyncGD BIT, UplineSyncGD BIT, SyncAB BIT, UplineSyncAB BIT, SyncVB BIT, UplineSyncVB BIT)
	DECLARE @bitmapOrderVB TINYINT,
			@bitmapOrderAB TINYINT						
	
	SELECT @bitmapOrderAB = MAX(CASE WHEN sporttype = 211 AND bettype = 2401 THEN bitmapOrder ELSE 0 END),		
		@bitmapOrderVB = MAX(CASE WHEN sporttype = 212 AND bettype = 4001 THEN bitmapOrder ELSE 0 END)
	FROM dbo.ProductStatusProfile WITH(NOLOCK)
	WHERE sporttype IN (211,212)
	
	INSERT INTO #tmpCust(custid,roleid,uplineID,syncGD,syncAB,syncVB)
	SELECT ci.custid, roleid, CASE WHEN roleid= 1 THEN recommend 
								WHEN roleid= 2 THEN mrecommend END,
			CASE WHEN HideGoldDeluxe = 1 THEN 0 ELSE 1 END,
			dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderAB),
			dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderVB)
	FROM dbo.CustInfo ci (NOLOCK)
		INNER JOIN dbo.CustProductStatus cs WITH(NOLOCK) ON ci.custid = cs.custid
	WHERE srecommend = @srecommend
		AND enabled = 1
		AND roleid IN (1,2)
		AND (HideGoldDeluxe =1 
			OR dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderAB) = 0
			OR dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderVB) = 0)
		
	UPDATE t 
	SET UplineSyncGD = CASE WHEN ci.HideGoldDeluxe = 1 THEN 0 ELSE 1 END,
		UplineSyncAB = dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderAB),
		UplineSyncVB = dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderVB)
	FROM #tmpCust t
		INNER JOIN dbo.CustInfo ci WITH(NOLOCK) ON t.UplineID = ci.custid
		INNER JOIN dbo.CustProductStatus cs WITH(NOLOCK) ON ci.custid= cs.custid
	
	UPDATE cs
	SET spositiontaking = 0,
		mpositiontaking = 0,
		apositiontaking = 0,
		isautompositiontaking = 0,
		autompositiontaking = 0,
		isautopositiontaking = 0,
		autopositiontaking = 0
	FROM dbo.CustSettingGame cs WITH(UPDLOCK,ROWLOCK)
	WHERE custid IN (SELECT custid 
					FROM #tmpCust 
					WHERE SyncGD = 0
						AND 1 = (CASE WHEN roleid = 1 THEN 1
									WHEN roleid = 2 AND UplineSyncGD = 0 THEN 1
									ELSE 0 END
								)
					)
		AND sporttype = 255
	
	UPDATE cs
	SET minpositiontaking = 0
	FROM dbo.CustOverrideGame cs WITH(UPDLOCK,ROWLOCK)
	WHERE custid IN (SELECT custid 
					FROM #tmpCust 
					WHERE SyncGD = 0
						AND roleid = 2
						AND UplineSyncGD = 0
					)
		AND sporttype = 255
	
	UPDATE cs
	SET SuperPT = 0,
		MasterPT = 0,
		AgentPT = 0,
		IsAutoMasterPT = 0,
		AutoMasterPT = 0,
		MinPT = 0
	FROM dbo.CustPTSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tmpCust t ON cs.custid = t.custid
	WHERE sporttype IN (211,212)
		AND roleid = 2
		AND 1 = (CASE WHEN (sporttype = 211 AND SyncAB = 0 AND UplineSyncAB = 0)
							OR (sporttype = 212 AND SyncVB = 0 AND UplineSyncVB = 0)
						THEN 1 ELSE 0 END
				)
	
	UPDATE cs
	SET SuperPT = 0,
		MasterPT = 0,
		AgentPT = 0,
		IsAutoMasterPT = 0,
		AutoMasterPT = 0,
		IsAutoSuperPT = 0,
		AutoSuperPT = 0
	FROM dbo.CustPTSetting3rd_Member cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tmpCust t ON cs.custid = t.custid
	WHERE sporttype IN (211,212)
		AND roleid = 1
		AND 1 = (CASE WHEN (sporttype = 211 AND SyncAB = 0)
							OR (sporttype = 212 AND SyncVB = 0)
						THEN 1 ELSE 0 END
				)
		
END
GO	
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
DECLARE @srecommend INT

CREATE TABLE #Super(CustID INT, isfinished BIT DEFAULT(0))

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
	
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Super
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.[Acc_CustSetting3rd_19] @srecommend = @srecommend			
			,@target = 'REPLICATED'
	
	waitfor delay '00:00:0.280'
END			
GO	

-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (/06/DBTP) -----
-----------------------------------------------------------------------------------	

---
---
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------	
DECLARE @srecommend INT
CREATE TABLE #Super(CustID INT, isfinished BIT DEFAULT(0))

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
	
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Super
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.[Acc_CustSetting3rd_19] @srecommend = @srecommend			
			,@target = 'DBCUST'
	
	waitfor delay '00:00:0.280'
END			
GO	
-- END STEP 3: RUN THIS SCRIPT AT DBCUST -----
-----------------------------------------------------------------------------------

	