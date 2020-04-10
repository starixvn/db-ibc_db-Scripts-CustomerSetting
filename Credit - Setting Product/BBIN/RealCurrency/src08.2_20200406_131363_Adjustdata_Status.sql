/*
	Created: 20200406@Eden
	Task: Adjust Status for BBIN [Redmine: #131363]
	DB: DBCUST/CustDB
*/ 
ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
AS
BEGIN
	SET NOCOUNT ON
	
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('CustProductStatus') = 1
	   AND dbo.f_CheckRepTable('ProductSettingDetail') = 1
	   AND dbo.f_CheckRepTable('ProductStatusProfile') = 1
	   )
		RETURN
	
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
		AND ci.currency IN (12,
							13,
							15,
							16,
							2,
							22,
							3,
							33,
							34,
							35,
							4,
							43,
							45,
							47,
							5,
							51,
							55,
							6,
							61,
							64,
							66,
							67,
							74,
							78,
							81
						) --supported currencies
	
	CREATE TABLE #CustList_ST (custid INT, IsDisabledAB BIT)
--------------------------------------Status Setting-------------------------------------------------		
	DECLARE @BitmapOrder TINYINT = 24

	INSERT INTO #CustList_ST (custid, IsDisabledAB)
	SELECT CS.CustID, isDisabledAB.value
	FROM DBNOTI.CustDB_AdjustCS.dbo.CustProductStatus cs WITH(NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) ON cs.CustID = ci.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, 6) as isDisabledAB
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, @BitmapOrder) as isDisabledBB
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsHidden, @BitmapOrder) as isHiddenBB
	WHERE (isDisabledBB.value <> isDisabledAB.value	OR isHiddenBB.value != 0)
		AND ci.Enabled = 1

	UPDATE cs
	SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
		bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,ci.IsDisabledAB)) 	
	FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #CustList_ST CI WITH(NOLOCK) ON cs.CustID = ci.CustID

	DROP TABLE #CustList_ST
	DROP TABLE #supers
END
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
PRINT N'Step 10: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

EXEC dbo.Acc_DynamicCustomerInfo_09 

PRINT N'Step 10: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'