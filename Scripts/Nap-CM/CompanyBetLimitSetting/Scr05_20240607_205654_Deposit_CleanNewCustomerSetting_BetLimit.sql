/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20240607
	Task: VGaming & Virtual Games - clean data - New customers
		https://nexdev.net/issues/205654
	DB: DBCust/CustDB
*/
----------------------------------------------------------------------------------------------
PRINT N'New Customers - Start on: ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
PRINT N'--------------------------------------------------------'
----------------------------------------------------------------------------------------------

DECLARE @Cust_cnt	INT,
		@max_custid INT

SELECT @max_custid = xxx
	
CREATE TABLE #supers (custid INT PRIMARY KEY)
CREATE TABLE #SMA(CustID INT PRIMARY KEY)
CREATE TABLE #Member( CustID INT PRIMARY KEY)
CREATE TABLE #Dep_ProductSettingDetail (ProductSettingID INT, SettingType SMALLINT, SportType SMALLINT, BetType SMALLINT)

------------------------------------------------------------------------------------------------
CREATE TABLE #tblCustomer(
				 CustID		INT
				,SportType	SMALLINT
				,BetType	SMALLINT
				,PRIMARY KEY CLUSTERED (CustID, Sporttype, Bettype))

CREATE TABLE #tblCustomer_batch(
				 CustID		INT
				,SportType	SMALLINT
				,BetType	SMALLINT
				,PRIMARY KEY CLUSTERED (CustID, Sporttype, Bettype))

------------------------------------------------------------------------------------------------
INSERT INTO #Dep_ProductSettingDetail(ProductSettingID,SettingType, SportType, BetType)
SELECT psd.ProductSettingID, SettingType, SportType, BetType
FROM Dep_ProductSettingDetail psd WITH(NOLOCK)
	INNER JOIN Dep_ProductSetting ps WITh(NOLOCK) ON psd.ProductSettingID=ps.ProductSettingID
WHERE ps.ProductID in (38,66) AND ps.SettingType IN (7,8,4)

--get supers offered VGaming & Virtual Games
INSERT INTO #supers(custid)
SELECT cs.custid
FROM dbo.Dep_CustSuper cs WITH(NOLOCK)
	INNER JOIN bodb_licensee.dbo.Licensees l WITH (NOLOCK) ON l.LicenseeName = cs.site
	CROSS APPLY (SELECT TOP (1) 1 
				FROM dbo.Dep_LicenseeProductSetting lp WITH (NOLOCK) 
						INNER JOIN #Dep_ProductSettingDetail p WITH (NOLOCK) 
						ON p.ProductSettingID = lp.ProductSettingID 
						AND p.SettingType = 4 --offered product
				WHERE  lp.CustID = cs.custid							
				)
				AS tmp (_sb)

DELETE FROM #Dep_ProductSettingDetail WHERE SettingType=4

---------------------------------------------------------
--SMA
INSERT INTO #SMA (CustID)
SELECT c.custid
FROM Custinfo c WITH (NOLOCK)
	INNER JOIN #supers s ON c.srecommend = s.custid
WHERE c.roleid IN (2,3,4) AND c.custid > @max_custid 

--Member
INSERT INTO #Member (CustID)
SELECT c.custid
FROM Custinfo c WITH (NOLOCK)
	INNER JOIN #supers s ON c.srecommend = s.custid
WHERE roleid = 1 AND c.custid > @max_custid

---------------------------------------------------------

SELECT @Cust_cnt = COUNT(DISTINCT CustID)
FROM #SMA

SELECT @Cust_cnt += COUNT(DISTINCT CustID)
FROM #Member

DECLARE @msg_total NVARCHAR(200) = 'Total of New Customers Affected: %d.'

RAISERROR (@msg_total, 0, 1, @Cust_cnt) WITH NOWAIT

-----------------------------------------------------------------------------------------------
DECLARE @batch int = 3000

--Dep_LicenseeProductSetting
BEGIN
	CREATE TABLE #tmpDep_LicenseeProductSetting (CustID INT, ProductSettingID INT
											  ,PRIMARY KEY CLUSTERED (CustID, ProductSettingID))

	INSERT INTO #tmpDep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT d.CustID
			,d.ProductSettingID
	FROM Dep_LicenseeProductSetting d WITH(NOLOCK) 
		INNER JOIN #supers ci WITH(NOLOCK) ON d.CustID = ci.custid
	WHERE d.ProductSettingID IN (SELECT ps.ProductSettingID FROM #Dep_ProductSettingDetail ps)


	IF EXISTS (SELECT TOP 1 1 FROM #tmpDep_LicenseeProductSetting)
	BEGIN
		CREATE TABLE #tmpDep_LicenseeProductSetting_batch (CustID INT, ProductSettingID INT
													  ,PRIMARY KEY CLUSTERED (CustID, ProductSettingID))
		
		WHILE EXISTS(SELECT TOP 1 1 FROM #tmpDep_LicenseeProductSetting)
		BEGIN
			DELETE TOP (@batch) #tmpDep_LicenseeProductSetting 
			OUTPUT deleted.CustID, deleted.ProductSettingID
				INTO #tmpDep_LicenseeProductSetting_batch(CustID, ProductSettingID)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE lps
			FROM dbo.Dep_LicenseeProductSetting lps WITH(ROWLOCK)		
				INNER JOIN #tmpDep_LicenseeProductSetting_batch ci ON ci.custid = lps.CustID AND ci.ProductSettingID = lps.ProductSettingID

			TRUNCATE TABLE #tmpDep_LicenseeProductSetting_batch
		END
		
		DROP TABLE #tmpDep_LicenseeProductSetting_batch
	END

	DROP TABLE #tmpDep_LicenseeProductSetting
END

--SMA
IF EXISTS (SELECT TOP 1 1 FROM #SMA)
BEGIN
	INSERT INTO #tblCustomer(custid, SportType, BetType)
	SELECT cs.CustID, cs.SportType, cs.BetType
	FROM Dep_CustStakeLevel_Agent cs WITH (NOLOCK) 
		INNER JOIN #SMA m ON m.CustID=cs.CustID
		INNER JOIN #Dep_ProductSettingDetail s 
			ON s.SportType=cs.SportType
			AND s.BetType=cs.BetType

	WHILE EXISTS(SELECT TOP 1 1 FROM #tblCustomer)
	BEGIN
		TRUNCATE TABLE #tblCustomer_batch

		DELETE TOP (@batch) #tblCustomer
		OUTPUT deleted.CustID, deleted.SportType, deleted.BetType
		INTO #tblCustomer_batch(CustID, SportType, BetType)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE lps
		FROM dbo.Dep_CustStakeLevel_Agent lps WITH(ROWLOCK)		
			INNER JOIN #tblCustomer_batch ci 
				ON ci.custid = lps.CustID 
				AND ci.SportType = lps.SportType
				AND ci.BetType = lps.BetType
	END
END
	
--Member
IF EXISTS (SELECT TOP 1 1 FROM #Member)
BEGIN
	INSERT INTO #tblCustomer(custid, SportType, BetType)
	SELECT cs.CustID, cs.SportType, cs.BetType
	FROM Dep_CustStakeLevel_Member cs WITH (NOLOCK) 
		INNER JOIN #Member m ON m.CustID=cs.CustID
		INNER JOIN #Dep_ProductSettingDetail s 
			ON s.SportType=cs.SportType
			AND s.BetType=cs.BetType

	WHILE EXISTS(SELECT TOP 1 1 FROM #tblCustomer)
	BEGIN
		TRUNCATE TABLE #tblCustomer_batch

		DELETE TOP (@batch) #tblCustomer
		OUTPUT deleted.CustID, deleted.SportType, deleted.BetType
		INTO #tblCustomer_batch(CustID, SportType, BetType)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE lps
		FROM dbo.Dep_CustStakeLevel_Member lps WITH(ROWLOCK)		
			INNER JOIN #tblCustomer_batch ci 
				ON ci.custid = lps.CustID 
				AND ci.SportType = lps.SportType
				AND ci.BetType = lps.BetType
	END
END
PRINT N'--------------------------------------------------------'
PRINT N'New Customers - End on: ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
GO