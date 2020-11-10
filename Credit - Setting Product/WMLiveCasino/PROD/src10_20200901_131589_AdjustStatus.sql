/*
	Created: Winfred
	Date: 20200828
	Task: Adjust Status for WM [Redmine: 131589]
	DB: DBCUST/CustDB
*/ 

 PRINT N'Step 10: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
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
		AND s.islicensee = 0
		AND ci.Site NOT IN ('CN88')
		AND CI.currency IN (15 --IN
							,45 --Won
							,2 --RM
							,5 --HK$
							,13 --RMB
							,66 --YUN
							,43 --THB
							,3 --US$
							,16 --Yen
							,35 --$US
							,64 --UT
							,95 -- USD
							,51 -- INH
							,67 --HKK
							,4 --TB
							,22 --IND
							,33 --IDD
							,34 --IDR
							,47 --DDD
						)

--------------------------------------Status Setting-------------------------------------------------		
	DECLARE @BitmapOrder TINYINT = 29

	CREATE TABLE #CustList_ST (custid INT, IsDisabledSG BIT)
	INSERT INTO #CustList_ST (custid, IsDisabledSG)
	SELECT CS.CustID, isDisabledSG.value
	FROM DBNOTI.CustDB_AdjustCS.dbo.CustProductStatus cs WITH(NOLOCK)
		INNER JOIN dbo.CustProductStatus cs2 WITH(NOLOCK) ON cs.CustID= cs2.CustID
		INNER JOIN custInfo ci WITH(NOLOCK) ON cs.CustID = ci.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, 22) as isDisabledSG
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS2.bitmapIsDisabled, @BitmapOrder) as isDisabledWM
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS2.bitmapIsHidden, @BitmapOrder) as isHiddenWM
	WHERE (isDisabledWM.value <> isDisabledSG.value	OR isHiddenWM.value != 0)
		AND ci.Enabled = 1

	DECLARE @tmp_AdjustStatus TABLE (custid INT, IsDisabledSG BIT) 
	WHILE (1 = 1)
	BEGIN	
		DELETE TOP (5000) t 	
		OUTPUT Deleted.custid, Deleted.IsDisabledSG
		INTO @tmp_AdjustStatus
		FROM #CustList_ST t

		IF @@ROWCOUNT = 0 BREAK

		UPDATE cs
		SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
			bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,ci.IsDisabledSG)) 	
		FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN @tmp_AdjustStatus CI  ON cs.CustID = ci.CustID
	
		DELETE @tmp_AdjustStatus

		WAITFOR DELAY '00:00:0.500'
	END

	DROP TABLE #CustList_ST
	DROP TABLE #supers
PRINT N'Step 10: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 