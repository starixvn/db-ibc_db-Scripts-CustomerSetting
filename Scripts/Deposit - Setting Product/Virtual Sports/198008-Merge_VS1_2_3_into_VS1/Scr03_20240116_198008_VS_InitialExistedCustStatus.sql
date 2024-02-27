/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created: 20240116@Tacy
	Task: initial status for new VS setting - copy from VS1 status [Redmine: #198008]
	DB: DBCust/CustDB and all replicated servers
*/
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_19]
	@CustList VARCHAR(MAX)
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at DBCUST only
	
	IF NOT dbo.f_CheckRepTable('Dep_CustProductStatus') = 1
		RETURN
	
	DECLARE @bitmapOrderNew TINYINT = 42
		, @bitmapOrder	TINYINT = 4

	CREATE TABLE #CustList (CustID INT PRIMARY KEY)

	INSERT INTO #CustList(CustID)
	SELECT TRIM(value) AS CustID
	FROM STRING_SPLIT(@CustList,',')
	WHERE TRIM(value)<>''
	
	UPDATE cs
	SET	 bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cs.bitmapIsHidden, @bitmapOrderNew
																						, dbo.f_GetProductStatus(cs.bitmapIsHidden , @bitmapOrder))) --Get VS status
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cs.bitmapIsDisabled, @bitmapOrderNew
																						, dbo.f_GetProductStatus(cs.bitmapIsDisabled , @bitmapOrder))) --Get VS status
	FROM [dbo].Dep_CustProductStatus cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #CustList b ON cs.CustID = b.CustID 

	DROP TABLE #CustList
END
GO
------------------------------------------------------	
-- BEGIN: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST-----
----------------------------------------------------------------------------------------------
PRINT N'COPY STATUS: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
PRINT N'--------------------------------------------------------'
----------------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

DECLARE @Cust_cnt	INT,
		@max_custid INT,
		@CustList   VARCHAR(MAX),
		@BatchSize	INT = 3000

SELECT @max_custid = xxx

CREATE TABLE #Supers(CustID INT PRIMARY KEY)
CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
CREATE TABLE #tbCustomers (CustID INT PRIMARY KEY)
CREATE TABLE #tbCustomers_batch (CustID INT PRIMARY KEY)

---------------------------------------------------------------------------------------------
INSERT INTO #Supers(custid)
SELECT cs.custid
FROM dbo.Dep_CustSuper cs WITH(NOLOCK)
	INNER JOIN bodb_licensee.dbo.Licensees l WITH (NOLOCK) ON l.LicenseeName = cs.site
	CROSS APPLY (SELECT TOP (1) 1 
				FROM dbo.Dep_LicenseeProductSetting lp WITH (NOLOCK) 
						INNER JOIN dbo.Dep_ProductSetting p WITH (NOLOCK) 
						ON p.ProductSettingID = lp.ProductSettingID 
						AND p.SettingType = 4 --offered product
						AND p.ProductID IN (5) 
						AND p.ProductSettingID NOT BETWEEN 182 AND 185 --New VS setting
				WHERE  lp.CustID = cs.custid							
				)
				AS tmp (_sb)
WHERE  l.IsActive = 1
	AND cs.username NOT LIKE '3rdSuper%'
	AND cs.custid <= @max_custid

--Dummy line
INSERT INTO #Dummy(CustID)
SELECT c.CustID 
FROM Customer c WITH(NOLOCK) 
	INNER JOIN #Supers s WITH (NOLOCK) ON s.CustID=c.srecommend
WHERE c.roleid=3 
	AND c.custid <= @max_custid
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

--#tbCustomers
INSERT INTO #tbCustomers (CustID)
SELECT c.custid
FROM dbo.CustInfo c WITH(NOLOCK)
INNER JOIN #Supers s ON s.CustID=c.srecommend
WHERE mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND c.custid <= @max_custid
	AND c.roleid IN (1,2,3,4)
	AND c.Enabled=1
---------------------------------------------------------------------------------------------

SELECT @Cust_cnt = COUNT(1)
FROM #tbCustomers

DECLARE @msg_total NVARCHAR(200) = 'Total of Existing Customers Affected: %d.'

RAISERROR (@msg_total, 0, 1, @Cust_cnt) WITH NOWAIT

WHILE (1=1)
BEGIN
	DELETE FROM #tbCustomers_batch

	DELETE TOP (@BatchSize) T
	OUTPUT deleted.CustID
		INTO #tbCustomers_batch(CustID)
	FROM #tbCustomers t 

	IF @@ROWCOUNT = 0 BREAK

	SELECT @CustList=STUFF((SELECT ',' + CAST(CUSTID AS VARCHAR)
							FROM #tbCustomers_batch
							FOR XML PATH('')),1,1,'')

	EXEC dbo.[Acc_Dep_DynamicCustSetting_19] 
			@CustList=@CustList,
			@target = @target
	
	WAITFOR DELAY '00:00:00:280'

	SET @msg_total = 'curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)

	RAISERROR (@msg_total, 0, 1) WITH NOWAIT
END	

DROP TABLE #Dummy, #Supers, #tbCustomers, #tbCustomers_batch

PRINT N'--------------------------------------------------------'
PRINT N'COPY STATUS: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
GO

-- END: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
-----------------------------------------------------------------------------------