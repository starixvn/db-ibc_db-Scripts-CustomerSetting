/*
	Created: 20210819@Elodie
	Task : Enable status Saba Virtual Sport for Malaysia Market [RedmineID: #160419]
	DB: DBCUST/CustDB
*/
	PRINT N'Step 4: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
	DECLARE @ProductID TINYINT = 54, @max_custid INT, @BitmapOrderSapa TINYINT = 28

	SELECT @max_custid = xxx

	CREATE TABLE #supers (custid INT)
		INSERT INTO #supers(custid)
		SELECT ci.custid
		FROM dbo.customer c WITH (NOLOCK) 
			INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
			INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
			LEFT JOIN  dbo.custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
		WHERE ci.roleid = 4
			AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))
			AND cs.isinternal = 0 	
			AND ci.Enabled = 1
			AND s.islicensee = 0
			AND c.username NOT LIKE '3rdSuper%'
			AND s.site IN ('733333', '722222', '222223')
			AND ci.currency  IN (2, 67)
		

	CREATE TABLE #CustList (CustID INT PRIMARY KEY,isfinished BIT DEFAULT(0))
	
	INSERT INTO #CustList(CustID)
	SELECT custid
	FROM dbo.custInfo ci WITH (NOLOCK)
	WHERE ci.srecommend IN (SELECT custid FROM #supers) 
		AND ci.Enabled = 1
		AND ci.custid > @max_custid
		 
	DECLARE @Cust_Temp TABLE(CustID INT)
	DECLARE @BatchSize SMALLINT = 5000
	
	WHILE(1 =1)
	BEGIN
		UPDATE TOP (@BatchSize) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID INTO @Cust_Temp(CustID)
		FROM #CustList c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0
		BEGIN 
			BREAK
		END 	
			
		UPDATE cs
		SET 
			cs.bitmapHasSynced = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapHasSynced,@BitmapOrderSapa,1)),
			cs.bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrderSapa,0)),
			cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrderSapa,0)) 
		FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK)
			INNER JOIN @Cust_Temp ci ON cs.CustID = ci.CustID	
		
		DELETE FROM @Cust_Temp
	END



