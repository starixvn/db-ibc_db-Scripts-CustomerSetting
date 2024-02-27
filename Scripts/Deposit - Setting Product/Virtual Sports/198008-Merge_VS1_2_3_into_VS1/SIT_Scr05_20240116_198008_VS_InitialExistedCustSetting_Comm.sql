/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240116@Tacy
	Task: initial setting for new VS setting - copy from VS1 setting [Redmine: #198008]
	DB: DBCust/CustDB and all replicated servers
*/
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	 @target VARCHAR(20),
	 @CustList XML,
	 @mode	 TINYINT -- 1 ~ SMA, 2 ~ Member
AS
BEGIN	
	SET NOCOUNT ON;
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbcust only
	
	IF (dbo.f_CheckRepTable('Dep_CustDiscountSetting_Member') = 0 
		OR dbo.f_CheckRepTable('Dep_CustDiscountGroupSetting_Member') = 0 	
		)
		RETURN
	
	CREATE TABLE #tbCustomer(
				 CustID	INT
				,RoleID TINYINT
				,SportType SMALLINT DEFAULT (180)
				,BetType SMALLINT DEFAULT (1201)
				,PRIMARY KEY CLUSTERED (CustID, Sporttype, Bettype))

	DECLARE @NewSporttype SMALLINT = 9908, @ProductSettingID INT = 185

	INSERT INTO #tbCustomer (CustID, RoleID)
	SELECT   t.c.value('@CustID','INT')		AS CustID
			,t.c.value('@RoleID','TINYINT')	AS RoleID
	FROM @CustList.nodes('root') t(c)

	IF @mode=1
	BEGIN
		BEGIN --Comm
			--Dep_CustDiscountGroupSetting_Member
			INSERT INTO Dep_CustDiscountGroupSetting_Member ([AgentID], [SportType], [BetType], [PlayerDiscount], [AgentDiscount], [MasterDiscount], [SuperDiscount])
			SELECT a.AgentID, @NewSporttype, a.BetType, a.PlayerDiscount, a.AgentDiscount, a.MasterDiscount, a.SuperDiscount
			FROM Dep_CustDiscountGroupSetting_Member a WITH (NOLOCK)
			INNER JOIN #tbCustomer t
					ON a.AgentID = t.CustID 
					AND a.SportType = t.sporttype
					AND a.BetType = t.bettype	
			OUTER APPLY (SELECT TOP 1 b.AgentID
						 FROM Dep_CustDiscountGroupSetting_Member b WITH (NOLOCK)
						 WHERE b.AgentID = t.CustID AND b.SportType=@NewSporttype) b
			WHERE t.RoleID=2 AND b.AgentID IS NULL
			
			--Dep_LicenseeProductSetting
			INSERT INTO Dep_LicenseeProductSetting ([CustID], [ProductSettingID])
			SELECT a.CustID, @ProductSettingID
			FROM Dep_LicenseeProductSetting a WITH (NOLOCK)
				INNER JOIN #tbCustomer t ON t.CustID=a.CustID
				INNER JOIN Dep_ProductSetting ps WITH (NOLOCK) ON ps.ProductSettingID=a.ProductSettingID
				OUTER APPLY (SELECT TOP 1 B.CustID 
							 FROM Dep_LicenseeProductSetting b WITH (NOLOCK)
							 WHERE b.CustID=a.CustID AND b.ProductSettingID=@ProductSettingID) b
			WHERE ps.ProductID=5 AND ps.SettingType=9 AND t.RoleID=4 AND b.CustID IS NULL
		END
	END

	IF @mode=2
	BEGIN
		--Dep_CustDiscountSetting_Member
		INSERT INTO Dep_CustDiscountSetting_Member ([CustID], [SportType], [BetType], [PlayerDiscount], [AgentDiscount], [MasterDiscount], [SuperDiscount])
		SELECT a.CustID, @NewSporttype, a.BetType, a.PlayerDiscount, a.AgentDiscount, a.MasterDiscount, a.SuperDiscount
		FROM Dep_CustDiscountSetting_Member a WITH (NOLOCK)
		INNER JOIN #tbCustomer t
				ON a.CustID = t.CustID 
				AND a.SportType = t.sporttype
				AND a.BetType = t.bettype	
		OUTER APPLY (SELECT TOP 1 b.CustID
						 FROM Dep_CustDiscountSetting_Member b WITH (NOLOCK)
						 WHERE b.CustID = t.CustID AND b.SportType=@NewSporttype) b
		WHERE b.CustID IS NULL
	END

	DROP TABLE #tbCustomer
END
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) AND DBCUST (Run last)-----
--------------------------------------------------------------------------------------
PRINT N'COPY SETTING: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
PRINT N'--------------------------------------------------------'
DECLARE @target VARCHAR(20)
		,@max_custid INT
		,@CustList   XML
		,@BatchSize	INT = 3000

SELECT @max_custid = xxx 

IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

CREATE TABLE #Supers(CustID INT PRIMARY KEY)
CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
CREATE TABLE #SMAs (CustID INT PRIMARY KEY, RoleID TINYINT)
CREATE TABLE #Members (CustID INT PRIMARY KEY)
CREATE TABLE #tbCustomers_batch (CustID INT PRIMARY KEY, RoleID TINYINT)

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
WHERE  l.IsActive = 1 AND l.licenseeName IN ('Athena000','spondemo','SampleSite')
	AND cs.username NOT LIKE '3rdSuper%'
	AND cs.custid <= @max_custid
	AND cs.currency=20

--Dummy line
INSERT INTO #Dummy(CustID)
SELECT c.CustID 
FROM Customer c WITH(NOLOCK) 
	INNER JOIN #Supers s WITH (NOLOCK) ON s.CustID=c.srecommend
WHERE c.roleid=3 
	AND c.custid <= @max_custid
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

--SMAs
INSERT INTO #SMAs (CustID, RoleID)
SELECT c.custid, c.roleid
FROM dbo.CustInfo c WITH(NOLOCK)
INNER JOIN #Supers s ON s.CustID=c.srecommend
WHERE mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND c.custid <= @max_custid
	AND c.roleid IN (2,3,4)
	AND c.Enabled=1 

--Members
INSERT INTO #Members (CustID)
SELECT c.custid
FROM dbo.CustInfo c WITH(NOLOCK)
INNER JOIN #Supers s ON s.CustID=c.srecommend
WHERE mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND c.custid <= @max_custid
	AND c.roleid = 1
	AND c.Enabled=1
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
DECLARE @Cust_cnt INT

SELECT @Cust_cnt = COUNT(1)
FROM #SMAs

SELECT @Cust_cnt += COUNT(1)
FROM #Members

DECLARE @msg_total NVARCHAR(200) = 'Total of Customers Affected: %d.'

RAISERROR (@msg_total, 0, 1, @Cust_cnt) WITH NOWAIT

--For SMA
WHILE (1 = 1)
BEGIN
	DELETE FROM #tbCustomers_batch

	DELETE TOP (@BatchSize) T
	OUTPUT deleted.CustID, deleted.RoleID
		INTO #tbCustomers_batch(CustID,RoleID)
	FROM #SMAs t 

	IF @@ROWCOUNT = 0 BREAK
	
	SELECT @CustList=(SELECT CustID	AS '@CustID' 
							,RoleID AS '@RoleID'
					FROM #tbCustomers_batch
					FOR XML PATH('root')
				)

	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] 
				@target = @target,
				@CustList=@CustList,
				@mode = 1
	
	WAITFOR DELAY '00:00:0.050'

	SET @msg_total = 'Agent - Curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)

	RAISERROR (@msg_total, 0, 1) WITH NOWAIT
END			
	
--For Member
WHILE (1 = 1)
BEGIN
	DELETE FROM #tbCustomers_batch

	DELETE TOP (@BatchSize) T
	OUTPUT deleted.CustID, 1
		INTO #tbCustomers_batch(CustID,RoleID)
	FROM #Members t 

	IF @@ROWCOUNT = 0 BREAK
	
	SELECT @CustList=(SELECT CustID	AS '@CustID' 
							,RoleID AS '@RoleID'
					FROM #tbCustomers_batch
					FOR XML PATH('root')
				)

	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] 
				@target = @target,
				@CustList=@CustList,
				@mode = 2
	
	WAITFOR DELAY '00:00:0.050'

	SET @msg_total = 'Member - Curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)

	RAISERROR (@msg_total, 0, 1) WITH NOWAIT
END		
	
PRINT N'--------------------------------------------------------'
PRINT N'COPY SETTING: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

DROP TABLE #SMAs, #Members, #tbCustomers_batch, #Supers, #Dummy
GO
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (/06/DBTP) AND DBCUST (Run last) -----
-----------------------------------------------------------------------------------	
