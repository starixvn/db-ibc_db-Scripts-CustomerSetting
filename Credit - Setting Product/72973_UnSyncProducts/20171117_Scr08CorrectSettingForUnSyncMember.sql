/*
	Created: 20171117@Johnson
	Task : Correct settings for un-sync members for GD,VB,AB
	DB:  DBCUST/CustDB
*/
 
 ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
	@srecommend INT, 
	@max_custid INT,
	@target VARCHAR(20)	
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbcust only
		
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN
		
	IF dbo.f_CheckRepTable('CustSettingGame') = 0 RETURN--GD		
	IF dbo.f_CheckRepTable('CustWinLimit') = 0 RETURN
	IF dbo.f_CheckRepTable('CustGameType') = 0 RETURN
	IF dbo.f_CheckRepTable('StakeLevel') = 0 RETURN
	
	IF dbo.f_CheckRepTable('CustProductStatus') = 0 RETURN--VB,AB
	IF dbo.f_CheckRepTable('ProductStatusProfile') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN
		
	CREATE TABLE #tmpMembers (CustID INT PRIMARY KEY, srecommend INT, mrecommend INT, recommend INT, SyncGD BIT, SyncAB BIT, SyncVB BIT)
	
	DECLARE @bitmapOrderVB TINYINT,
			@bitmapOrderAB TINYINT,
			@apt SMALLMONEY,
			@mpt SMALLMONEY,
			@spt SMALLMONEY
	
	SELECT @bitmapOrderAB = MAX(CASE WHEN sporttype = 211 AND bettype = 2401 THEN bitmapOrder ELSE 0 END),		
		@bitmapOrderVB = MAX(CASE WHEN sporttype = 212 AND bettype = 4001 THEN bitmapOrder ELSE 0 END)
	FROM dbo.ProductStatusProfile WITH(NOLOCK)
	WHERE sporttype IN (211,212)
	
	--GD
	INSERT INTO #tmpMembers(custID, srecommend, mrecommend, recommend, SyncGD, SyncAB, SyncVB)
	SELECT ci.custid, srecommend, mrecommend, recommend,		
		CASE WHEN HideGoldDeluxe = 1 AND ci.currency NOT IN (44,45,62) THEN 0 ELSE 1 END,
		dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderAB),
		dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderVB)
	FROM dbo.CustInfo ci WITH(NOLOCK)		
		INNER JOIN dbo.CustProductStatus p WITH(NOLOCK) ON ci.custid = p.custid
	WHERE srecommend = @srecommend
		AND ci.custID <= @max_custid
		AND roleid = 1
		AND enabled = 1
		AND (HideGoldDeluxe = 1
			OR dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderAB) = 0
			OR dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderVB) = 0
			)
	
	UPDATE cs
	SET @apt = acs.apositiontaking,		
		@mpt = CASE WHEN acs.isautompositiontaking = 0 THEN acs.mpositiontaking
					ELSE CASE WHEN acs.autompositiontaking < mcs.mpositiontaking - @apt 
								THEN acs.autompositiontaking ELSE mcs.mpositiontaking - @apt END
					END,
		@spt = CASE WHEN mcs.isautopositiontaking = 0 THEN mcs.spositiontaking
					ELSE CASE WHEN mcs.autopositiontaking < scs.spositiontaking - @mpt - @apt
							THEN mcs.autopositiontaking ELSE scs.spositiontaking - @mpt - @apt END
					END,
		cs.apositiontaking = @apt,			
		cs.mpositiontaking = @mpt,
		cs.spositiontaking = @spt,
		cs.isautompositiontaking =0,
		cs.autompositiontaking =0,
		cs.isautopositiontaking =0,
		cs.autopositiontaking =0,
		cs.sdiscount = scs.sdiscount,
		cs.adiscount = mcs.adiscount,
		cs.discount = acs.discount,
		cs.playerdiscount = 0
	FROM dbo.CustSettingGame cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tmpMembers t ON cs.custID = t.custID	
		INNER JOIN dbo.CustSettingGame scs WITH(NOLOCK) ON scs.custid = t.srecommend 
														AND scs.sporttype =cs.sporttype
														AND scs.bettype = cs.bettype
		INNER JOIN dbo.CustSettingGame mcs WITH(NOLOCK) ON mcs.custid = t.mrecommend 
														AND mcs.sporttype =cs.sporttype
														AND mcs.bettype = cs.bettype
		INNER JOIN dbo.CustSettingGame acs WITH(NOLOCK) ON acs.custid = t.recommend 
														AND acs.sporttype =cs.sporttype
														AND acs.bettype = cs.bettype												
	WHERE cs.sporttype = 255
		AND cs.bettype = 1701
		AND t.SyncGD = 0
	
	UPDATE cs
	SET cs.MaxWinlimit = acs.MaxWinlimit,
		cs.IsAutoReset = acs.IsAutoReset
	FROM dbo.CustWinLimit cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tmpMembers t ON cs.custID = t.custID
		INNER JOIN dbo.CustWinLimit acs WITH(NOLOCK) ON acs.custid = t.recommend
														AND acs.sporttype = cs.sporttype
														AND acs.bettype = cs.bettype
	WHERE syncGD = 0
		AND cs.sporttype = 255
		AND cs.bettype= 1701
		
	UPDATE cs
	SET cs.StakeLevelList = s.StakeLevelList_Lowest
	FROM dbo.CustGameType cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tmpMembers t ON cs.custID = t.custID
		INNER JOIN dbo.CustGameType acs WITH(NOLOCK) ON acs.custid = t.recommend
														AND acs.GameTypeID = cs.GameTypeID														
		CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),cd.val),'') AS StakeLevelList_Lowest
					FROM (SELECT CAST(val AS INT) AS val
						  FROM dbo.strSplit(acs.StakeLevelList,','))cd
							INNER JOIN dbo.StakeLevel SL WITH(NOLOCK) ON cd.val = sl.StakeLevelID
						 WHERE MinStake <> 0 AND MaxStake <> 0
						ORDER BY minstake , maxstake
					) s													
	WHERE syncGD = 0		
		AND acs.GameTypeID IN (1701,1702)--optimize execution plan
		AND acs.custid IN (SELECT recommend FROM #tmpMembers WHERE syncGD = 0)
	
	--AB, VB	
	UPDATE cs
	SET @apt = acs.AgentPT,
		@mpt = CASE WHEN acs.isAutoMasterPT = 0 THEN acs.MasterPT
					ELSE CASE WHEN acs.autoMasterPT < mcs.MasterPT - @apt 
								THEN acs.autoMasterPT ELSE mcs.MasterPT - @apt END
					END,
		@spt = CASE WHEN mcs.isAutoSuperPT = 0 THEN mcs.SuperPT
					ELSE CASE WHEN mcs.autoSuperPT < scs.SuperPT - @mpt - @apt
							THEN mcs.autoSuperPT ELSE scs.SuperPT - @mpt - @apt END
					END,
		AgentPT = @apt,		
		MasterPT = @mpt,
		SuperPT = @spt,		
		IsAutoSuperPT = 0,
		AutoSuperPT = 0,
		IsAutoMasterPT = 0,
		autoMasterPT = 0
	FROM dbo.CustPTSetting3rd_member cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tmpMembers t ON cs.custID = t.custID		
		INNER JOIN dbo.CustPTSetting3rd_Agent scs WITH(NOLOCK) ON scs.custid = t.srecommend
																AND scs.sporttype = cs.sporttype
																AND scs.bettype = cs.bettype
		INNER JOIN dbo.CustPTSetting3rd_Agent mcs WITH(NOLOCK) ON mcs.custid = t.mrecommend
																AND mcs.sporttype = cs.sporttype
																AND mcs.bettype = cs.bettype
		INNER JOIN dbo.CustPTSetting3rd_Agent acs WITH(NOLOCK) ON acs.custid = t.recommend
																AND acs.sporttype = cs.sporttype
																AND acs.bettype = cs.bettype														
	WHERE (t.SyncAB = 0 AND cs.sporttype = 211) 
		OR (t.SyncVB = 0 AND cs.sporttype = 212)
	
	UPDATE cs
	SET cs.SuperDiscount = scs.Discount,
		cs.MasterDiscount = mcs.Discount,
		cs.AgentDiscount = acs.Discount,
		cs.PlayerDiscount = 0
	FROM dbo.CustDiscount3rd_Member cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tmpMembers t ON cs.custID = t.custID		
		INNER JOIN dbo.CustDiscount3rd_Agent scs WITH(NOLOCK) ON scs.custid = t.srecommend
																AND scs.sporttype = cs.sporttype
																AND scs.bettype = cs.bettype
		INNER JOIN dbo.CustDiscount3rd_Agent mcs WITH(NOLOCK) ON mcs.custid = t.mrecommend
																AND mcs.sporttype = cs.sporttype
																AND mcs.bettype = cs.bettype
		INNER JOIN dbo.CustDiscount3rd_Agent acs WITH(NOLOCK) ON acs.custid = t.recommend
																AND acs.sporttype = cs.sporttype
																AND acs.bettype = cs.bettype														
	WHERE (t.SyncAB = 0 AND cs.sporttype = 211) 
		OR (t.SyncVB = 0 AND cs.sporttype = 212) 
				
	UPDATE cs
	SET MaxWinlimit = acs.MaxWinlimit,
		MaxLosslimit = acs.MaxLosslimit,
		IsAutoReset = acs.IsAutoReset
	FROM dbo.CustWinLossLimit_Member cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tmpMembers t ON cs.custID = t.custID
		INNER JOIN dbo.CustWinLossLimit_Agent acs WITH(NOLOCK) ON acs.custid = t.recommend
																AND acs.sporttype = cs.sporttype
																AND acs.bettype = cs.bettype
	WHERE (t.SyncAB = 0 AND cs.sporttype = 211) 
		OR (t.SyncVB = 0 AND cs.sporttype = 212) 
			
	UPDATE cs
	SET stakeLevelList = s.StakeLevelList_Lowest
	FROM dbo.CustStakeLevel_Member cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tmpMembers t ON cs.custID = t.custID
		INNER JOIN dbo.CustStakeLevel_Agent acs WITH(NOLOCK) ON acs.custid = t.recommend
																AND acs.sporttype = cs.sporttype
																AND acs.bettype = cs.bettype
		CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),cd.val),'') AS StakeLevelList_Lowest
					FROM (SELECT CAST(val AS INT) AS val
						  FROM dbo.strSplit(acs.StakeLevelList,','))cd
							INNER JOIN dbo.StakeLevel SL WITH(NOLOCK) ON cd.val = sl.StakeLevelID
						 WHERE MinStake <> 0 AND MaxStake <> 0
						ORDER BY minstake , maxstake
					) s																
	WHERE (t.SyncAB = 0 AND acs.sporttype = 211) --optimize execution plan
		OR (t.SyncVB = 0 AND acs.sporttype = 212) 
	
	DROP TABLE #tmpMembers
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
	AND (HideGoldDeluxe = 1
		OR dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderAB) = 0
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
	AND (HideGoldDeluxe = 1
		OR dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderAB) = 0
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

	EXEC dbo.[Acc_CustSetting3rd_19] @srecommend = @srecommend	
			,@max_custid = @max_custid
			,@target = 'DBCUST'
	
	waitfor delay '00:00:0.280'
END			
GO	
-- END STEP 3: RUN THIS SCRIPT AT DBCUST -----
-----------------------------------------------------------------------------------	