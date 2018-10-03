/*
	Created: Winnie
	Task: Adjust status for Esports
	DB: DBCUST/CustDB
	Date: 20181001
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

	DECLARE @Sporttype INT
	SELECT @Sporttype=43	
	DECLARE @BitmapOrder INT
	SELECT @BitmapOrder= bitmapOrder from ProductStatusProfile WITH(NOLOCK) where SportType=@Sporttype

	CREATE TABLE #CustList_Status (custid INT)
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

	INSERT INTO #CustList_Status (custid)
	SELECT ci.custid
	FROM [dbo].[CustProductStatus] cs WITH(NOLOCK)
		INNER JOIN dbo.custInfo ci WITH(NOLOCK) ON cs.CustID = ci.CustID	
	WHERE ci.srecommend IN (SELECT custid FROM #supers)		 				
		AND bitmapIsDisabled <>  (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(bitmapIsDisabled, @BitmapOrder, ISNULL(ci.DisableEsports,1)))
		
	RAISERROR('Done: Get the affected downlines list for status', 0, 1)  WITH NOWAIT

	SELECT Custid FROM #CustList_Status

	UPDATE cs
		SET bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(bitmapIsDisabled, @BitmapOrder, ISNULL(ci.DisableEsports,1)))
	FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #CustList_Status c WITH(NOLOCK) ON cs.CustID = c.CustID	
		INNER JOIN dbo.custInfo ci WITH(NOLOCK) ON cs.CustID = ci.CustID	

	RAISERROR('Done: Update the affected downlines list for status', 0, 1)  WITH NOWAIT
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
EXEC dbo.Acc_DynamicCustomerInfo_09 
