/*
	Created: 20171122@Johnson
	Task : Correct settings for un-sync newly agents for GD,VB,AB
	DB:  DBCUST/CustDB
*/
DECLARE @max_custid INT

CREATE TABLE #Super(CustID INT)

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
	
CREATE TABLE #tmpAgents (CustID INT PRIMARY KEY, mrecommend INT, isDirectAccount BIT, SyncGD BIT, SyncCS BIT, SyncAB BIT, SyncVB BIT, xmlStrDisabled XML, xmlStrSynced XML)

DECLARE @bitmapOrderVB TINYINT,
		@bitmapOrderAB TINYINT						

SELECT @bitmapOrderAB = MAX(CASE WHEN sporttype = 211 AND bettype = 2401 THEN bitmapOrder ELSE 0 END),		
	@bitmapOrderVB = MAX(CASE WHEN sporttype = 212 AND bettype = 4001 THEN bitmapOrder ELSE 0 END)
FROM dbo.ProductStatusProfile WITH(NOLOCK)
WHERE sporttype IN (211,212)

--GD
INSERT INTO #tmpAgents(custID, mrecommend, IsDirectAccount, SyncGD, SyncCS, SyncAB, SyncVB)
SELECT ci.custid, mrecommend, CASE WHEN c.CustID IS NULL THEN 0 ELSE 1 END,
	CASE WHEN HideGoldDeluxe = 1 AND ci.currency NOT IN (44,45,62) THEN 0 ELSE 1 END,
	ci.SyncCasino,
	dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderAB),
	dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderVB)
FROM dbo.CustInfo ci WITH(NOLOCK)
	LEFT JOIN dbo.CustDirectAccount c WITH(NOLOCK) ON ci.custid = c.custid
	INNER JOIN dbo.CustProductStatus p WITH(NOLOCK) ON ci.custid = p.custid
WHERE srecommend IN (SELECT custID FROM #Super)
	AND ci.custID > @Max_custID
	AND roleid = 2
	AND enabled = 1
	AND (HideGoldDeluxe = 1
		OR SyncCasino = 0
		OR dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderAB) = 0
		OR dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderVB) = 0
		)

IF @@ROWCOUNT = 0
BEGIN
	PRINT 'No any more newly agent un-sync'
	RETURN
END	

-------------------------------------------------------------
--PT/Winlimit/StakeLevel
UPDATE cs
SET cs.mpositiontaking = CASE WHEN t.isDirectAccount = 1 THEN 0 ELSE mcs.mpositiontaking END,
	cs.apositiontaking = CASE WHEN t.isDirectAccount = 1 THEN mcs.mpositiontaking ELSE 0 END,		
	cs.isautompositiontaking =0,
	cs.autompositiontaking =0,
	cs.discount = CASE WHEN t.isDirectAccount = 1 THEN mcs.adiscount ELSE 0 END
FROM dbo.CustSettingGame cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #tmpAgents t ON cs.custID = t.custID	
	INNER JOIN dbo.CustSettingGame mcs WITH(NOLOCK) ON mcs.custid = t.mrecommend 
													AND mcs.sporttype =cs.sporttype
													AND mcs.bettype = cs.bettype													
WHERE cs.sporttype = 255
	AND cs.bettype = 1701
	AND t.SyncGD = 0

UPDATE cs
SET cs.minpositiontaking = 0
FROM dbo.CustOverrideGame cs WITH(UPDLOCK,ROWLOCK)		
WHERE custid IN (SELECT custid FROM #tmpAgents WHERE syncGD = 0)
	AND sporttype = 255
	AND bettype = 1701
	AND cs.minpositiontaking <> 0
	
UPDATE cs
SET cs.MaxWinlimit = mcs.MaxWinlimit,
	cs.IsAutoReset = mcs.IsAutoReset
FROM dbo.CustWinLimit cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #tmpAgents t ON cs.custID = t.custID	
	INNER JOIN dbo.CustWinLimit mcs WITH(NOLOCK) ON mcs.custid = t.mrecommend
													AND mcs.sporttype = cs.sporttype
													AND mcs.bettype = cs.bettype
WHERE syncGD = 0
	AND cs.sporttype = 255
	AND cs.bettype= 1701
	
UPDATE cs
SET cs.StakeLevelList = mcs.StakeLevelList
FROM dbo.CustGameType cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #tmpAgents t ON cs.custID = t.custID
	INNER JOIN dbo.CustGameType mcs WITH(NOLOCK) ON mcs.custid = t.mrecommend
													AND mcs.GameTypeID = cs.GameTypeID														
WHERE syncGD = 0
	AND cs.GameTypeID IN (1701,1702)

--AB, VB	
UPDATE cs
SET 
	MasterPT = CASE WHEN isDirectAccount = 1 THEN 0 ELSE mcs.MasterPT END,						
	AgentPT = CASE WHEN isDirectAccount = 1 THEN mcs.MasterPT ELSE 0 END,
	IsAutoMasterPT = 0,
	AutoMasterPT = 0,
	MinPT = 0
FROM dbo.CustPTSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #tmpAgents t ON cs.custID = t.custID
	INNER JOIN dbo.CustPTSetting3rd_Agent mcs WITH(NOLOCK) ON mcs.custid = t.mrecommend
															AND mcs.sporttype = cs.sporttype
															AND mcs.bettype = cs.bettype
WHERE cs.sporttype IN (211,212)		
	AND 1 = (CASE WHEN (t.SyncAB = 0 AND cs.sporttype = 211) 
						OR (t.SyncVB = 0 AND cs.sporttype = 212) THEN 1 ELSE 0 END
			)


UPDATE cs
SET Discount = CASE WHEN isDirectAccount = 1 THEN mcs.Discount ELSE 0 END							
FROM dbo.CustDiscount3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #tmpAgents t ON cs.custID = t.custID
	INNER JOIN dbo.CustDiscount3rd_Agent mcs WITH(NOLOCK) ON mcs.custid = t.mrecommend
															AND mcs.sporttype = cs.sporttype
															AND mcs.bettype = cs.bettype
WHERE cs.sporttype IN (211,212)		
	AND 1 = (CASE WHEN (t.SyncAB = 0 AND cs.sporttype = 211) 
						OR (t.SyncVB = 0 AND cs.sporttype = 212) THEN 1 ELSE 0 END
			)	

UPDATE cs
SET MaxWinlimit = mcs.MaxWinlimit,
	MaxLosslimit = mcs.MaxLosslimit,
	IsAutoReset = mcs.IsAutoReset
FROM dbo.CustWinLossLimit_Agent cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #tmpAgents t ON cs.custID = t.custID
	INNER JOIN dbo.CustWinLossLimit_Agent mcs WITH(NOLOCK) ON mcs.custid = t.mrecommend
															AND mcs.sporttype = cs.sporttype
															AND mcs.bettype = cs.bettype
WHERE cs.sporttype IN (211,212)		
	AND 1 = (CASE WHEN (t.SyncAB = 0 AND cs.sporttype = 211) 
						OR (t.SyncVB = 0 AND cs.sporttype = 212) THEN 1 ELSE 0 END
			)

UPDATE cs
SET stakeLevelList = mcs.StakeLevelList
FROM dbo.CustStakeLevel_Agent cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #tmpAgents t ON cs.custID = t.custID
	INNER JOIN dbo.CustStakeLevel_Agent mcs WITH(NOLOCK) ON mcs.custid = t.mrecommend
															AND mcs.sporttype = cs.sporttype
															AND mcs.bettype = cs.bettype
WHERE cs.sporttype IN (211,212)		
	AND 1 = (CASE WHEN (t.SyncAB = 0 AND cs.sporttype = 211) 
						OR (t.SyncVB = 0 AND cs.sporttype = 212) THEN 1 ELSE 0 END
			)	

----------------------------------------------------------
--Status for VB, AB
UPDATE t
SET xmlStrDisabled = (SELECT 
				 (SELECT bitmapOrder as '@b', 1 as '@s'
				 FROM dbo.ProductStatusProfile WITH(NOLOCK)
				 where 1=case when (syncVB = 0 AND Sporttype = 212 ) or (syncAB = 0 AND Sporttype = 211) then 1 ELSE 0 end
				  for XML path('r'),TYPE) 
				FOR XML PATH('root'), TYPE
			),
	xmlStrSynced = (SELECT 
				 (SELECT bitmapOrder as '@b', 1 as '@s'
				 FROM dbo.ProductStatusProfile WITH(NOLOCK)
				 where 1=case when (syncVB = 0 AND Sporttype = 212 ) or (syncAB = 0 AND Sporttype = 211) then 1 ELSE 0 end
				  for XML path('r'),TYPE) 
				FOR XML PATH('root'), TYPE
			)	
FROM #tmpAgents t
WHERE SyncAB = 0 OR SyncVB = 0

UPDATE cs	
SET bitmapHasSynced =(SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (bitmapHasSynced, CONVERT(VARCHAR(MAX),t.xmlStrSynced))),
	bitmapIsDisabled =(SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (bitmapIsDisabled, CONVERT(VARCHAR(MAX),t.xmlStrDisabled)))
FROM dbo.CustProductStatus cs WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #tmpAgents t ON cs.custID = t.custID
WHERE syncAB = 0 OR syncVB = 0

UPDATE ci
SET HideGoldDeluxe = CASE WHEN t.SyncGD = 0 THEN 0 ELSE HideGoldDeluxe END,
	DisableGoldDeluxe = CASE WHEN t.SyncGD = 0 THEN 1 ELSE DisableGoldDeluxe END,
	SyncCasino = CASE WHEN t.SyncCS = 0 THEN 1 ELSE SyncCasino END,
	DisableCasino = CASE WHEN t.SyncCS = 0 THEN 1 ELSE DisableCasino END
FROM dbo.custinfo ci WITH(UPDLOCK,ROWLOCK)	
	INNER JOIN #tmpAgents t ON ci.custID = t.CustID
WHERE SyncGD = 0 OR SyncCS = 0

				