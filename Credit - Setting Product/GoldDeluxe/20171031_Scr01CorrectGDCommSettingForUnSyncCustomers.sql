/*
	Created: 20171031@Johnson
	Task : Correct comm setting for un-sync customers for GD
	DB:  DBCUST/CustDB
*/
 
 ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
	@srecommend INT, 
	@target VARCHAR(20)	
AS
BEGIN
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbtrans only
		
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN
	IF dbo.f_CheckRepTable('CustSettingGame') = 0 RETURN--GD
	IF dbo.f_CheckRepTable('CustOverrideGame') = 0 RETURN
	IF dbo.f_CheckRepTable('CustProductStatus') = 0 RETURN
	IF dbo.f_CheckRepTable('ProductStatusProfile') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
		
	DECLARE @bitmapOrderAB INT,
			@bitmapOrderVB INT
	
	CREATE TABLE #UnSyncCust (CustID INT PRIMARY KEY, UplineID INT, roleid TINYINT, SyncGD BIT, SyncAB BIT, SyncVB BIT)
	
	SELECT @bitmapOrderAB = MAX(CASE WHEN sporttype= 211 THEN bitmapOrder ELSE 0 END ),
			@bitmapOrderVB = MAX(CASE WHEN sporttype= 212 THEN bitmapOrder ELSE 0 END)		
	FROM dbo.ProductStatusProfile WITH(NOLOCK)
	WHERE sporttype IN (211,212)
	
	INSERT INTO #UnSyncCust(custid,UplineID,roleid,SyncGD,syncAB,SyncVB)
	SELECT ci.custID,CASE WHEN roleid = 1 THEN recommend
						WHEN roleid = 2 THEN mrecommend
						WHEN roleid = 3 THEN srecommend END,
			roleid,
			CASE WHEN HideGoldDeluxe = 1 THEN 0 ELSE 1 END,
			dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderAB),
			dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderVB)
	FROM dbo.CustInfo ci WITH(NOLOCK)
		INNER JOIN dbo.CustProductStatus cs WITH(NOLOCK) ON ci.custid = cs.custid
	WHERE ci.srecommend = @srecommend
		AND roleid < 4
		AND enabled=1
		AND (dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderAB)= 0
			OR dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderVB) = 0
			OR HideGoldDeluxe = 1
		)
		
	--reset setting for un-sync customers for GD
	UPDATE cs
	SET minpositiontaking =0		
	FROM dbo.CustOverrideGame cs WITH(UPDLOCK,ROWLOCK) 
	WHERE custid IN (SELECT custid FROM #UnSyncCust WHERE syncGD = 0 AND roleid > 1)
		AND sporttype = 255
		AND bettype =1701	
		
	UPDATE cs
	SET spositiontaking = CASE WHEN roleid = 3 THEN upline.minpositiontaking ELSE 0 END,
		mpositiontaking = CASE WHEN roleid = 2 THEN upline.minpositiontaking ELSE 0 END,
		apositiontaking = CASE WHEN roleid = 1 THEN upline.minpositiontaking ELSE 0 END,
		isautopositiontaking=0,
		isautompositiontaking=0,
		autopositiontaking=0,
		autompositiontaking=0
	FROM dbo.CustSettingGame cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #UnSyncCust t ON cs.custid = t.custID
		INNER JOIN dbo.CustOverrideGame upline WITH(NOLOCK) ON upline.custID = t.UplineID
																AND upline.sporttype = cs.sporttype
																AND upline.bettype = cs.bettype	
	WHERE syncGD = 0
		AND cs.sporttype = 255
		AND cs.bettype =1701
	
	--VB,AB	
	UPDATE cs
	SET MinPT =0
	FROM dbo.CustPTSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN (SELECT custid, 211 as Sporttype FROM #UnSyncCust WHERE syncAB =0 AND roleid > 1
					UNION ALL SELECT custid, 212 as Sporttype FROM #UnSyncCust WHERE syncVB =0 AND roleid > 1
					)t ON cs.custid = t.custid
						AND cs.sporttype=t.sporttype
	
	UPDATE cs
	SET cs.superPT = CASE WHEN t.roleid = 3 THEN upline.MinPT ELSE 0 END,
		cs.MasterPT = CASE WHEN t.roleid = 2 THEN upline.MinPT ELSE 0 END,
		cs.AgentPT = 0,
		cs.IsAutoMasterPT =0,
		cs.AutoMasterPT =0,
		cs.IsAutoSuperPT =0,
		cs.AutoSuperPT =0
	FROM dbo.CustPTSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN (SELECT custid, uplineID, roleid, 211 as Sporttype FROM #UnSyncCust WHERE syncAB =0 AND roleid > 1
					UNION ALL 
					SELECT custid, uplineID, roleid, 212 as Sporttype FROM #UnSyncCust WHERE syncVB =0 AND roleid > 1
					)t ON cs.custid = t.custid
						AND cs.sporttype=t.sporttype
		INNER JOIN dbo.CustPTSetting3rd_Agent upline WITH(NOLOCK) ON upline.custID = t.UplineID
																	AND upline.sporttype = cs.sporttype
																	AND upline.bettype = cs.bettype
						
	UPDATE cs
	SET cs.superPT = 0,
		cs.MasterPT = 0,
		cs.AgentPT = upline.minPT,
		cs.IsAutoMasterPT =0,
		cs.AutoMasterPT =0,
		cs.IsAutoSuperPT =0,
		cs.AutoSuperPT =0
	FROM dbo.CustPTSetting3rd_Member cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN (SELECT custid, uplineID, roleid, 211 as Sporttype FROM #UnSyncCust WHERE syncAB =0 AND roleid = 1
					UNION ALL 
					SELECT custid, uplineID, roleid, 212 as Sporttype FROM #UnSyncCust WHERE syncVB =0 AND roleid = 1
					)t ON cs.custid = t.custid
						AND cs.sporttype=t.sporttype
		INNER JOIN dbo.CustPTSetting3rd_Agent upline WITH(NOLOCK) ON upline.custID = t.UplineID
																	AND upline.sporttype = cs.sporttype
																	AND upline.bettype = cs.bettype
			
						
	--GD
	SELECT ci.custid, cs.sdiscount, cs.adiscount, cs.discount, scs.sdiscount as superDiscount, mcs.adiscount as masterDiscount, acs.discount as agentDiscount
	INTO #tmpSetting
	FROM dbo.CustInfo ci WITH(NOLOCK)
		INNER JOIN dbo.CustSettingGame cs WITH(NOLOCK) ON ci.custid = cs.CustID
																AND cs.sporttype = 255
																AND cs.bettype =1701
		INNER JOIN dbo.CustSettingGame scs WITH(NOLOCK) ON scs.custid = @srecommend
														AND scs.sporttype = cs.sporttype
														AND scs.bettype = cs.bettype
		INNER JOIN dbo.CustSettingGame mcs WITH(NOLOCK) ON mcs.custid = ci.mrecommend
														AND mcs.sporttype = cs.sporttype
														AND mcs.bettype = cs.bettype
		INNER JOIN dbo.CustSettingGame acs WITH(NOLOCK) ON acs.custid = ci.recommend
														AND acs.sporttype = cs.sporttype
														AND acs.bettype = cs.bettype												
	WHERE srecommend = @srecommend
		AND roleid = 1
		AND enabled = 1		
		AND (cs.sdiscount <> scs.sdiscount
			OR cs.adiscount <> mcs.adiscount
			OR cs.discount <> acs.discount)
	
	IF @@ROWCOUNT = 0
		RETURN;
	
	UPDATE cs
	SET cs.sdiscount = CASE WHEN cs.sdiscount <> t.superDiscount THEN t.superDiscount ELSE cs.sdiscount END,
		cs.adiscount = CASE WHEN cs.adiscount <> t.masterDiscount THEN t.masterDiscount ELSE cs.adiscount END,
		cs.discount = CASE WHEN cs.discount <> t.agentDiscount THEN t.agentDiscount ELSE cs.discount END
	FROM dbo.CustSettingGame cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tmpSetting t ON cs.custid = t.custid
	WHERE cs.sporttype= 255
		AND cs.bettype=1701

	DROP TABLE #tmpSetting	
	DROP TABLE #UnSyncCust	
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
SELECT custid 
FROM dbo.custInfo WITH (Nolock) 
WHERE roleid = 4
	AND custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))	
	AND custid NOT IN (SELECT custid FROM dbo.CustSuper WITH(NOLOCK) WHERE isInternal = 1)
	AND Enabled = 1
	
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
SELECT custid 
FROM dbo.custInfo WITH (Nolock) 
WHERE roleid = 4
	AND custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))
	AND custid NOT IN (SELECT custid FROM dbo.CustSuper WITH(NOLOCK) WHERE isInternal = 1)
	AND Enabled = 1
	
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