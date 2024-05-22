/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240521
	Task: Init data exchange for ugsports & 77fortune & ZFRT649 - New accounts [Redmine:#205332]
	DB: DBCUST/CustDB
*/

USE Custdb
GO

PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

BEGIN
	CREATE TABLE #supers (custid INT, currency INT, site VARCHAR(50), isfinished bit default(0))

	DECLARE @max_custid INT = xxx ---input maxcustid

	INSERT INTO #supers(custid, site)
	SELECT ci.srecommend, cs.site
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'
		AND ci.Enabled = 1
		AND (
			(cs.site IN ('ugsports','77fortune','ZFRT649') AND Ci.currency IN (61))
		)

	DECLARE @SportType SMALLINT = 221 
		, @Bettype SMALLINT = 8001
		, @ProductID TINYINT = 31
		, @bitmapOrder TINYINT
		, @batchNum INT = 5000
		, @ChargeComm DECIMAL(9,8) = 0.02

	SELECT @bitmapOrder = bitmapOrder FROM Dep_ProductStatusProfile WITH(NOLOCK) WHERE Sporttype =  @SportType 

	CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY,RoleID INT)
	CREATE TABLE #tmpCustBatch		(CustID INT PRIMARY KEY,RoleID INT)
	CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)
	--DECLARE @Currency INT, @Site VARCHAR(50)
	--SELECT @Site = site, @Currency = currency FROM Customer WITH(NOLOCK) WHERE custid = @srecommend

	INSERT INTO #Dummy(CustID)
	SELECT CustID 
	FROM Customer WITH(NOLOCK) 
	WHERE srecommend IN ( select custid from #supers)
		AND roleid=3 AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

	INSERT INTO #tmpCust(CustID,RoleID)
	SELECT ci.CustID,ci.roleid
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend IN (select custid from #supers) 
		AND ci.custid > @max_custid 
		AND ci.Enabled=1
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO [dbo].[Dep_CustDiscountSetting_Agent]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[Discount])
	SELECT c.custid,@SportType,@Bettype,@ChargeComm
	FROM #tmpCust c WITH(NOLOCK)
		LEFT JOIN Dep_CustDiscountSetting_Agent ag WITH(NOLOCK)
			ON c.CustID = ag.CustID
			AND ag.SportType = @SportType
			AND ag.BetType = @Bettype
	WHERE c.roleid IN(2,3,4)
		AND ag.CustID IS NULL
	
	DECLARE @bitmapInit	binary(32)
	SELECT @bitmapInit = NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF,@bitmapOrder,0)

	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #tmpCustBatch

		DELETE TOP(@batchNum) t
		OUTPUT deleted.CustID,deleted.RoleID INTO #tmpCustBatch(CustID,RoleID)
		FROM #tmpCust t

		IF @@ROWCOUNT = 0
			BREAK

		UPDATE c 
		SET  bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsHidden,@bitmapOrder,0))
			,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsDisabled,@bitmapOrder,0))
		FROM [dbo].[Dep_CustProductStatus] c WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #tmpCustBatch t ON C.custid = T.custid

		--Insert new if not exist record before
		INSERT INTO [Dep_CustProductStatus](CustID,bitmapIsDisabled,bitmapIsHidden)
		SELECT t.CustID, @bitmapInit, @bitmapInit
		FROM #tmpCustBatch t
			LEFT JOIN [dbo].[Dep_CustProductStatus] c WITH(NOLOCK) ON C.custid = T.custid
		WHERE c.CustID IS NULL
	END

	INSERT INTO Dep_LicenseeProductSetting (CustID,ProductSettingID)
	SELECT s.custid, ps.ProductSettingID
	FROM Dep_ProductSetting ps WITH (NOLOCK)
		CROSS JOIN #supers s
		LEFT JOIN  Dep_LicenseeProductSetting lps WITH (NOLOCK) 
			ON lps.ProductSettingID = ps.ProductSettingID 
			AND lps.CustID = s.custid
	WHERE ps.ProductID= @ProductID
		AND lps.CustID IS NULL

	--Dep_ChargeInfoSetting:
	DECLARE @_Date Date = GETDATE()

	INSERT INTO Dep_ChargeInfoSetting ([CustID], [SportType], [PT])
	SELECT s.custid, @SportType, 
		CASE WHEN s.site='ugsports'  THEN 87.5
			 WHEN s.site='77fortune' THEN 86.5
									 ELSE 88
		END AS [PT]
	FROM #supers s
		OUTER APPLY (SELECT CustID
					 FROM Dep_ChargeInfoSetting t WITH (NOLOCK)
					 WHERE t.CustID=S.custid
					 AND t.SportType=@SportType
					 AND t.FromDate<=@_Date AND t.ToDate>=@_Date) a
	WHERE a.CustID IS NULL

	DROP TABLE #Dummy
	DROP TABLE #tmpCust
	DROP TABLE #supers
	DROP TABLE #tmpCustBatch
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

GO