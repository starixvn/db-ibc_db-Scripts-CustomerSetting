/*
	Created: 20200421@Tiara
	Date: 20200421
	Task: Adjust Status for Sexy Gaming - Batch 2 [Redmine: #130678]
	DB: DBCUST/CustDB
*/ 

	
	CREATE TABLE #supers (custid int)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM customer ci WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
		LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND ci.Site<>'CN88'
		AND s.islicensee = 0
		AND ci.currency IN (6,78,69,13,66,81,45) --Euro, EUR; MMK, RMB, CY, YUN, WON

--------------------------------------Status Setting-------------------------------------------------		
	DECLARE @BitmapOrder TINYINT = 22

	CREATE TABLE #CustList_ST (custid INT, IsDisabledAB BIT)
	INSERT INTO #CustList_ST (custid, IsDisabledAB)
	SELECT CS.CustID, isDisabledAB.value
	FROM DBNOTI.CustDB_AdjustCS.dbo.CustProductStatus cs WITH(NOLOCK)
		INNER JOIN dbo.CustProductStatus cs2 WITH(NOLOCK) ON cs.CustID= cs2.CustID
		INNER JOIN custInfo ci WITH(NOLOCK) ON cs.CustID = ci.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, 6) as isDisabledAB
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS2.bitmapIsDisabled, @BitmapOrder) as isDisabledSG
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS2.bitmapIsHidden, @BitmapOrder) as isHiddenSG
	WHERE (isDisabledSG.value <> isDisabledAB.value	OR isHiddenSG.value != 0)
		AND ci.Enabled = 1

	DECLARE @tmp_AdjustStatus TABLE (custid INT, IsDisabledAB BIT) 
	WHILE (1 = 1)
	BEGIN	
	DELETE TOP (5000) t 	
	OUTPUT Deleted.custid, Deleted.IsDisabledAB
	INTO @tmp_AdjustStatus
	FROM #CustList_ST t

	IF @@ROWCOUNT = 0 BREAK

	UPDATE cs
	SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
		bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,ci.IsDisabledAB)) 	
	FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN @tmp_AdjustStatus CI  ON cs.CustID = ci.CustID
	
	DELETE @tmp_AdjustStatus

	WAITFOR DELAY '00:00:0.500'
	END

	DROP TABLE #CustList_ST
	DROP TABLE #supers
