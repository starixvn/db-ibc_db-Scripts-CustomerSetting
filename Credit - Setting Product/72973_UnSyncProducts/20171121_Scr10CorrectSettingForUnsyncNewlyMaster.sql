/*
	Created: 20171121@Johnson
	Task : Correct settings for un-sync newly masters for GD,VB,AB
	DB:  DBCUST/CustDB
*/
DECLARE @srecommend INT,
		@max_custid INT

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

CREATE TABLE #tmpMasters (CustID INT PRIMARY KEY, srecommend INT, isDirectAccount BIT, SyncGD BIT, SyncCS BIT, SyncAB BIT, SyncVB BIT, xmlStrDisabled XML, xmlStrSynced XML)
	
DECLARE @bitmapOrderVB TINYINT,
		@bitmapOrderAB TINYINT						

SELECT @bitmapOrderAB = MAX(CASE WHEN sporttype = 211 AND bettype = 2401 THEN bitmapOrder ELSE 0 END),		
	@bitmapOrderVB = MAX(CASE WHEN sporttype = 212 AND bettype = 4001 THEN bitmapOrder ELSE 0 END)
FROM dbo.ProductStatusProfile WITH(NOLOCK)
WHERE sporttype IN (211,212)

--GD
INSERT INTO #tmpMasters(custID, srecommend, IsDirectAccount, SyncGD, SyncCS, SyncAB, SyncVB)
SELECT ci.custid, ci.srecommend,
	CASE WHEN c.CustID IS NULL THEN 0 ELSE 1 END,
	CASE WHEN HideGoldDeluxe = 1 THEN 0 ELSE 1 END,
	ci.syncCasino,
	dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderAB),
	dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderVB)
FROM dbo.CustInfo ci WITH(NOLOCK)
	LEFT JOIN dbo.CustDirectAccount c WITH(NOLOCK) ON ci.custid = c.custid
	INNER JOIN dbo.CustProductStatus p WITH(NOLOCK) ON ci.custid = p.custid
WHERE srecommend IN (SELECT custid FROM #super)
	AND ci.custid > @max_custid
	AND roleid = 3
	AND enabled = 1
	AND (HideGoldDeluxe = 1
		OR dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderAB) = 0
		OR dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderVB) = 0
		)	

IF @@ROWCOUNT = 0
BEGIN
	PRINT 'No any more newly master un-sync'
	RETURN
END		

--SELECT COUNT(1) FROM #tmpMasters

-----------------------------------------------
--update PT/Winlimit/Stakelevl

UPDATE cs
SET cs.spositiontaking = CASE WHEN t.isDirectAccount = 1 THEN 0 ELSE scs.spositiontaking END,
	cs.mpositiontaking = CASE WHEN t.isDirectAccount = 1 THEN scs.spositiontaking ELSE 0 END,
	cs.isautopositiontaking =0,
	cs.autopositiontaking =0,
	cs.adiscount = CASE WHEN t.isDirectAccount = 1 THEN scs.sdiscount ELSE 0 END
FROM dbo.CustSettingGame cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #tmpMasters t ON cs.custID = t.custID
	INNER JOIN dbo.CustSettingGame scs WITH(NOLOCK) ON scs.custid = t.srecommend 
													AND scs.sporttype =cs.sporttype
													AND scs.bettype = cs.bettype													
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
	INNER JOIN #tmpMasters t ON cs.custID = t.custID
	INNER JOIN dbo.CustWinLimit scs WITH(NOLOCK) ON scs.custid = t.srecommend
													AND scs.sporttype = cs.sporttype
													AND scs.bettype = cs.bettype
WHERE syncGD = 0
	AND cs.sporttype = 255
	AND cs.bettype= 1701

UPDATE cs
SET cs.StakeLevelList = scs.StakeLevelList
FROM dbo.CustGameType cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #tmpMasters t ON cs.custID = t.custID
	INNER JOIN dbo.CustGameType scs WITH(NOLOCK) ON scs.custid = t.srecommend
													AND scs.GameTypeID = cs.GameTypeID														
WHERE syncGD = 0
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
	INNER JOIN dbo.CustPTSetting3rd_Agent scs WITH(NOLOCK) ON scs.custid = t.srecommend
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
	INNER JOIN dbo.CustDiscount3rd_Agent scs WITH(NOLOCK) ON scs.custid = t.srecommend
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
	INNER JOIN dbo.CustWinLossLimit_Agent scs WITH(NOLOCK) ON scs.custid = t.srecommend
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
	INNER JOIN dbo.CustStakeLevel_Agent scs WITH(NOLOCK) ON scs.custid = t.srecommend
															AND scs.sporttype = cs.sporttype
															AND scs.bettype = cs.bettype
WHERE cs.sporttype IN (211,212)		
	AND 1 = (CASE WHEN (t.SyncAB = 0 AND cs.sporttype = 211) 
						OR (t.SyncVB = 0 AND cs.sporttype = 212) THEN 1 ELSE 0 END
			)	

------------------------------
--update status
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
FROM #tmpMasters t
WHERE syncAB = 0 OR syncVB = 0

UPDATE cs	
SET bitmapHasSynced =(SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (bitmapHasSynced, CONVERT(VARCHAR(MAX),t.xmlStrSynced))),
	bitmapIsDisabled =(SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (bitmapHasSynced, CONVERT(VARCHAR(MAX),t.xmlStrDisabled)))
FROM dbo.CustProductStatus cs WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #tmpMasters t ON cs.custID = t.custID
WHERE syncAB = 0 OR syncVB = 0		

UPDATE dbo.custinfo WITH(UPDLOCK,ROWLOCK)
SET HideGoldDeluxe = CASE WHEN HideGoldDeluxe = 1 THEN 0 ELSE HideGoldDeluxe END,
	DisableGoldDeluxe = CASE WHEN HideGoldDeluxe = 1 THEN 1 ELSE DisableGoldDeluxe END,
	SyncCasino = CASE WHEN SyncCasino = 0 THEN 1 ELSE SyncCasino END,
	DisableCasino = CASE WHEN SyncCasino = 0 THEN 1 ELSE DisableCasino END
WHERE Custid IN (SELECT custid FROM #tmpMasters WHERE SyncGD = 0)	
	AND (HideGoldDeluxe = 1 OR SyncCasino = 0)	