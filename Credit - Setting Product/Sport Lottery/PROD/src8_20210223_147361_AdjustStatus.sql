/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Winfred
	Date: 20210223
	Task: Adjust status of Sports Lottery [Redmine: 147361]
	DB: DBCUST/CustDB
	
	P/s : Step 8 Adjust setting
*/ 
 
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
	USE CustDB
	GO

	PRINT N'Step 8: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

	IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;
	
	CREATE TABLE #supers (custid INT)
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
		AND ci.Site<>'CN88'
		AND ci.currency NOT IN (20,72) -- UUS, YNG
		AND Ci.custid NOT IN (356942,410722,410800,462612,479690,499837,507226,512864,776702,833216,838365,897682,932905,984326,984549,1008937,
			1060883,1211012,1593254,1598401,1604404,1993804,1993818,3139575,3671274,4138910,5340162,5340166,5551985,5931469,5973408,6418627,
			6621107,7669811,7694778,7945498,8017299,8095139,8488565,8621974,8907700,9525991,9934460,10535290,10542643,11581838,11734366,
			12300617,12742869,12968884,13338762,13543345,13549891,14063528,14423359,14453695,14776453,14827154,14827246,15778049,16154752,
			16901190,16928094,17436696,17724317,18023072,19646705,20055370,20124800,20309230,22150801,22378516,23416974,23475292,25589933,
			26576899,27349067,27377389,27474847,28532147,43136376,45571377,46080688,46107818)
		-- exclude headline SDRMB, 266HK, M863HK, SBSR, YKH, S188RM, PYY, POT, SF8, S80R
	--------------------------------------Status Setting-------------------------------------------------		
	DECLARE @BitmapOrder TINYINT = 32

	CREATE TABLE #CustList_ST (custid INT, IsDisabledLT BIT)
	INSERT INTO #CustList_ST (custid, IsDisabledLT)
	SELECT CS.CustID, isDisabledLT.value
	FROM dbo.CustProductStatus cs WITH(NOLOCK)
		INNER JOIN dbo.CustProductStatus cs2 WITH(NOLOCK) ON cs.CustID= cs2.CustID
		INNER JOIN custInfo ci WITH(NOLOCK) ON cs.CustID = ci.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, 11) as isDisabledLT
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS2.bitmapIsDisabled, @BitmapOrder) as isDisabledSL
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS2.bitmapIsHidden, @BitmapOrder) as isHiddenSL
	WHERE (isDisabledSL.value <> isDisabledLT.value	OR isHiddenSL.value != 0)
		AND ci.Enabled = 1

	DECLARE @tmp_AdjustStatus TABLE (custid INT, IsDisabledLT BIT) 
	WHILE (1 = 1)
	BEGIN	
		DELETE TOP (5000) t 	
		OUTPUT Deleted.custid, Deleted.IsDisabledLT
		INTO @tmp_AdjustStatus
		FROM #CustList_ST t

		IF @@ROWCOUNT = 0 BREAK

		UPDATE cs
		SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
			bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,ci.IsDisabledLT)) 	
		FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN @tmp_AdjustStatus CI  ON cs.CustID = ci.CustID
	
		DELETE @tmp_AdjustStatus

		WAITFOR DELAY '00:00:0.500'
	END

	DROP TABLE #CustList_ST
	DROP TABLE #supers
	
	PRINT N'Step 8: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
