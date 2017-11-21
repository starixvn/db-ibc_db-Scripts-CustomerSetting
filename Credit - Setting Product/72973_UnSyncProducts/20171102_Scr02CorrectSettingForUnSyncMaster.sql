/*
	Created: 20171102@Johnson
	Task : Correct settings for un-sync masters for GD,VB,AB
	DB:  DBCUST/CustDB
*/
 
 ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
	@srecommend INT, 
	@max_custid INT,
	@target VARCHAR(20)	
AS
BEGIN
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbcust only
		
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDirectAccount') = 0 RETURN
	IF dbo.f_CheckRepTable('CustSettingGame') = 0 RETURN--GD
	IF dbo.f_CheckRepTable('CustOverrideGame') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustWinLimit') = 0 RETURN
	IF dbo.f_CheckRepTable('CustGameType') = 0 RETURN
	IF dbo.f_CheckRepTable('CustProductStatus') = 0 RETURN--VB,AB
	IF dbo.f_CheckRepTable('ProductStatusProfile') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN
	
	CREATE TABLE #tmpMasters (CustID INT PRIMARY KEY, isDirectAccount BIT, SyncGD BIT, SyncAB BIT, SyncVB BIT)
	
	DECLARE @bitmapOrderVB TINYINT,
			@bitmapOrderAB TINYINT						
	
	SELECT @bitmapOrderAB = MAX(CASE WHEN sporttype = 211 AND bettype = 2401 THEN bitmapOrder ELSE 0 END),		
		@bitmapOrderVB = MAX(CASE WHEN sporttype = 212 AND bettype = 4001 THEN bitmapOrder ELSE 0 END)
	FROM dbo.ProductStatusProfile WITH(NOLOCK)
	WHERE sporttype IN (211,212)
	
	--GD
	INSERT INTO #tmpMasters(custID, IsDirectAccount, SyncGD, SyncAB, SyncVB)
	SELECT ci.custid, CASE WHEN c.CustID IS NULL THEN 0 ELSE 1 END,
		CASE WHEN HideGoldDeluxe = 1 THEN 0 ELSE 1 END,
		dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderAB),
		dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderVB)
	FROM dbo.CustInfo ci WITH(NOLOCK)
		LEFT JOIN dbo.CustDirectAccount c WITH(NOLOCK) ON ci.custid = c.custid
		INNER JOIN dbo.CustProductStatus p WITH(NOLOCK) ON ci.custid = p.custid
	WHERE srecommend = @srecommend
		AND ci.custid <= @max_custid
		AND roleid = 3
		AND enabled = 1
		AND (HideGoldDeluxe = 1
			OR dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderAB) = 0
			OR dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderVB) = 0
			)
	
	UPDATE cs
	SET cs.spositiontaking = CASE WHEN t.isDirectAccount = 1 THEN 0 ELSE scs.spositiontaking END,
		cs.mpositiontaking = CASE WHEN t.isDirectAccount = 1 THEN scs.spositiontaking ELSE 0 END,
		cs.isautopositiontaking =0,
		cs.autopositiontaking =0,
		cs.adiscount = CASE WHEN t.isDirectAccount = 1 THEN scs.sdiscount ELSE 0 END
	FROM dbo.CustSettingGame cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN dbo.CustSettingGame scs WITH(NOLOCK) ON scs.custid = @srecommend 
														AND scs.sporttype =cs.sporttype
														AND scs.bettype = cs.bettype
		INNER JOIN #tmpMasters t ON cs.custID = t.custID												
	WHERE cs.sporttype = 255
		AND cs.bettype = 1701
		AND t.SyncGD = 0
	
	UPDATE cs
	SET cs.minpositiontaking = 0
	FROM dbo.CustOverrideGame cs WITH(UPDLOCK,ROWLOCK)		
	WHERE custid IN (SELECT custid FROM #tmpMasters WHERE syncGD = 0)
		AND sporttype = 255
		AND bettype = 1701
		AND cs.minpositiontaking <> 0
	
	UPDATE cs
	SET cs.MaxWinlimit = scs.MaxWinlimit,
		cs.IsAutoReset = scs.IsAutoReset
	FROM dbo.CustWinLimit cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN dbo.CustWinLimit scs WITH(NOLOCK) ON scs.custid = @srecommend
														AND scs.sporttype = cs.sporttype
														AND scs.bettype = cs.bettype
	WHERE cs.custid IN (SELECT custid FROM #tmpMasters WHERE syncGD = 0)
		AND cs.sporttype = 255
		AND cs.bettype= 1701
	
	UPDATE cs
	SET cs.StakeLevelList = scs.StakeLevelList
	FROM dbo.CustGameType cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN dbo.CustGameType scs WITH(NOLOCK) ON scs.custid = @srecommend
														AND scs.GameTypeID = cs.GameTypeID														
	WHERE cs.custid IN (SELECT custid FROM #tmpMasters WHERE syncGD = 0)		
		AND cs.GameTypeID IN (1701,1702)
		
	--AB, VB	
	UPDATE cs
	SET SuperPT = CASE WHEN isDirectAccount = 1 THEN 0 ELSE scs.SuperPT END,
		MasterPT = CASE WHEN isDirectAccount = 1 THEN scs.SuperPT ELSE 0 END,						
		AgentPT = 0,
		IsAutoSuperPT = 0,
		AutoSuperPT = 0,
		MinPT = 0
	FROM dbo.CustPTSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tmpMasters t ON cs.custID = t.custID
		INNER JOIN dbo.CustPTSetting3rd_Agent scs WITH(NOLOCK) ON scs.custid = @srecommend
																AND scs.sporttype = cs.sporttype
																AND scs.bettype = cs.bettype
	WHERE cs.sporttype IN (211,212)		
		AND 1 = (CASE WHEN (t.SyncAB = 0 AND cs.sporttype = 211) 
							OR (t.SyncVB = 0 AND cs.sporttype = 212) THEN 1 ELSE 0 END
				)

	
	UPDATE cs
	SET Discount = CASE WHEN isDirectAccount = 1 THEN scs.Discount ELSE 0 END							
	FROM dbo.CustDiscount3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tmpMasters t ON cs.custID = t.custID
		INNER JOIN dbo.CustDiscount3rd_Agent scs WITH(NOLOCK) ON scs.custid = @srecommend
																AND scs.sporttype = cs.sporttype
																AND scs.bettype = cs.bettype
	WHERE cs.sporttype IN (211,212)		
		AND 1 = (CASE WHEN (t.SyncAB = 0 AND cs.sporttype = 211) 
							OR (t.SyncVB = 0 AND cs.sporttype = 212) THEN 1 ELSE 0 END
				)	
				
	UPDATE cs
	SET MaxWinlimit = scs.MaxWinlimit,
		MaxLosslimit = scs.MaxLosslimit,
		IsAutoReset = scs.IsAutoReset
	FROM dbo.CustWinLossLimit_Agent cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tmpMasters t ON cs.custID = t.custID
		INNER JOIN dbo.CustWinLossLimit_Agent scs WITH(NOLOCK) ON scs.custid = @srecommend
																AND scs.sporttype = cs.sporttype
																AND scs.bettype = cs.bettype
	WHERE cs.sporttype IN (211,212)		
		AND 1 = (CASE WHEN (t.SyncAB = 0 AND cs.sporttype = 211) 
							OR (t.SyncVB = 0 AND cs.sporttype = 212) THEN 1 ELSE 0 END
				)
			
	UPDATE cs
	SET stakeLevelList = scs.StakeLevelList
	FROM dbo.CustStakeLevel_Agent cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tmpMasters t ON cs.custID = t.custID
		INNER JOIN dbo.CustStakeLevel_Agent scs WITH(NOLOCK) ON scs.custid = @srecommend
																AND scs.sporttype = cs.sporttype
																AND scs.bettype = cs.bettype
	WHERE cs.sporttype IN (211,212)		
		AND 1 = (CASE WHEN (t.SyncAB = 0 AND cs.sporttype = 211) 
							OR (t.SyncVB = 0 AND cs.sporttype = 212) THEN 1 ELSE 0 END
				)	
			
	DROP TABLE #tmpMasters
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
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
	
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Super
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.[Acc_CustSetting3rd_19] @srecommend = @srecommend	
			,@max_custid = @max_custid
			,@target = 'REPLICATED'
	
	waitfor delay '00:00:0.280'
END			
GO	

-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
-----------------------------------------------------------------------------------	

---
---
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
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
	
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Super
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.[Acc_CustSetting3rd_19] @srecommend = @srecommend	
			,@max_custid = @max_custid
			,@target = 'DBCUST'
	
	waitfor delay '00:00:0.280'
END			
GO	
-- END STEP 3: RUN THIS SCRIPT AT DBCUST -----
-----------------------------------------------------------------------------------
