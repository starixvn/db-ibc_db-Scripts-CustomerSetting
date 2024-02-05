/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240205
	Task: Init data exchange for ZhiFeng895, Sky9, ZhiFeng919 - New accounts [Redmine:#200848]
	DB: DBCUST/CustDB and all subscriber of CustDB_custseting Pub
*/

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB -----
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	 @srecommend INT	
	, @max_custid INT
	, @target VARCHAR(20)
AS
BEGIN	
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbtrans only
	
	IF (dbo.f_CheckRepTable('Dep_ProductSetting') = 0
		OR dbo.f_CheckRepTable('Dep_ProductSettingDetail') = 0
		OR dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 		
		OR dbo.f_CheckRepTable('Dep_ProductStatusProfile') = 0 
		OR dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 
		OR dbo.f_CheckRepTable('Dep_CustDiscountSetting_Agent') = 0 
	   )
		RETURN

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

	INSERT INTO #Dummy(CustID)
	SELECT CustID 
	FROM Customer WITH(NOLOCK) 
	WHERE srecommend=@srecommend AND roleid=3 AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

	INSERT INTO #tmpCust(CustID,RoleID)
	SELECT ci.CustID,ci.roleid
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend = @srecommend AND ci.custid<=@max_custid 
		AND ci.Enabled=1
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO [dbo].[Dep_CustDiscountSetting_Agent]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[Discount])
	SELECT c.custid,@SportType,@Bettype,@ChargeComm
	FROM #tmpCust c WITH(NOLOCK)
	WHERE c.roleid IN(2,3,4)

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
	SELECT @srecommend, ps.ProductSettingID
	FROM Dep_ProductSetting ps WITH (NOLOCK)
		LEFT JOIN  Dep_LicenseeProductSetting lps WITH (NOLOCK) 
			ON lps.ProductSettingID = ps.ProductSettingID 
			AND CustID = @srecommend
	WHERE ps.ProductID= @ProductID
		AND lps.CustID IS NULL

	DROP TABLE #Dummy
	DROP TABLE #tmpCust
END
GO

--------------BEGIN STEP 2: Run this SP at replicated DB ----------
SET NOCOUNT ON;

PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
		DROP TABLE	#supers;

CREATE TABLE #supers (custid INT, currency INT, isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT  @max_custid= xxx ---input maxcustid

DECLARE @ProductID TINYINT = 31, @Sporttype SMALLINT = 221

CREATE TABLE #Supers_Offered (custid INT PRIMARY KEY)

INSERT INTO #Supers_Offered (custid)
SELECT DISTINCT lds.CustID
FROM Dep_LicenseeProductSetting lds WITH (NOLOCK)
	INNER JOIN Dep_CustSuper c WITH (NOLOCK) on c.custid = lds.CustID 
	INNER JOIN Dep_ProductSetting ps WITH (NOLOCK) ON lds.ProductSettingID = PS.ProductSettingID AND ps.ProductID= @ProductID
	INNER JOIN Dep_ProductSettingDetail psd WITH (NOLOCK) ON psd.ProductSettingID = ps.ProductSettingID
WHERE PSD.SportType = @Sporttype

INSERT INTO #supers(custid)
SELECT ci.srecommend
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'
		AND ci.CustID <= @max_custid
		AND ci.Enabled=1
		AND cs.site IN ('ZhiFeng895', 'Sky9', 'ZhiFeng919') 
		AND Ci.currency IN (61)
		AND ci.custid NOT IN (SELECT custid FROM #Supers_Offered)

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid		
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] 
		 @srecommend = @srecommend
		,@max_custid=@max_custid
		,@target = @target
				
	WAITFOR DELAY '00:00:00.280'			
END	

PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

DROP TABLE #supers
GO		
--------------END STEP 2: Run this SP at replicated DB ----------			
