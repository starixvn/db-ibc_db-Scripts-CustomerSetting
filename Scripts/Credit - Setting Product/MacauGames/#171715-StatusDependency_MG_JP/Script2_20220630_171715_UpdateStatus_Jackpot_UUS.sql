/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220630@Eden
	Task: Update jackpot Status - UUS [#171715]
	DB: DBCUST/CustDB
*/
USE CUSTDB
GO
	DECLARE @BitmapOrder_MG TINYINT = 5
	DECLARE @BitmapOrder_JP TINYINT = 39

	CREATE TABLE #CustTemp_Upd(CustID INT,IsFinished BIT DEFAULT 0)
	CREATE TABLE #CustTempBatch(CustID INT)
	CREATE TABLE #supers (custid int)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM customer ci WITH (NOLOCK) 
		INNER JOIN custinfo c WITH(NOLOCK) ON ci.custid = c.custid
		INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
		LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.islicensee = 0
		and c.Enabled = 1			
		AND ci.Site <> 'CN88'
		AND ci.currency = 20
	
	INSERT INTO #CustTemp_Upd(CustID)
	SELECT c.CustID
	FROM [dbo].[CustProductStatus] c WITH(NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) 
			ON ci.CustID = c.CustID
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(C.bitmapIsDisabled, @BitmapOrder_MG) as isDisabledMG
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(C.bitmapIsDisabled, @BitmapOrder_JP) as isDisabledJP
	WHERE isDisabledMG.value = 1 AND isDisabledJP.value = 0
		AND ci.srecommend IN ( SELECT custid from #supers)

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustTempBatch

		UPDATE TOP (5000)  t 
		SET t.IsFinished = 1 
		OUTPUT DELETED.CustID INTO #CustTempBatch(CustID) 
		FROM #CustTemp_Upd t 
		WHERE t.IsFinished = 0

		IF @@ROWCOUNT=0
			BREAK

		UPDATE cs
		SET cs.bitmapIsDisabled = dis.NewBitmap
		FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempBatch ci ON cs.CustID = ci.CustID
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder_JP,1) as dis
			CROSS APPLY dbo.f_CustSetting_ProductStatusSel(Cs.bitmapIsDisabled, @BitmapOrder_MG) as isDisabledMG
			CROSS APPLY dbo.f_CustSetting_ProductStatusSel(Cs.bitmapIsDisabled, @BitmapOrder_JP) as isDisabledJP
		WHERE isDisabledMG.value = 1 AND isDisabledJP.value = 0
	END
	
	DROP TABLE #CustTempBatch
	DROP TABLE #CustTemp_Upd
	DROP TABLE #supers

