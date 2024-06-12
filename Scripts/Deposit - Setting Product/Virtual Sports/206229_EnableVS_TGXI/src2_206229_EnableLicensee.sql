/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240607@Winfred
	Task: [TGXI] - Enable VS product for TGXI [Redmine: #206229]
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
	
	IF (dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0
		
		OR dbo.f_CheckRepTable('Dep_ProductSetting') = 0
		OR dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 
		
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 

		OR dbo.f_CheckRepTable('Dep_CustDiscountSetting_Member') = 0 
		OR dbo.f_CheckRepTable('Dep_CustDiscountGroupSetting_Member') = 0 	

		OR dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 	
		)
		RETURN
	
	DECLARE @bitmapOrder TINYINT = 42
	DECLARE @SuperPT SMALLMONEY = 88

	CREATE TABLE #tbDep_ProductSettingNew(ProductSettingID TINYINT, SettingType TINYINT)
	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32),isfinished BIT DEFAULT(0))

	CREATE TABLE #tbCustomer(
				 CustID	INT
				,RoleID TINYINT
				,SportType SMALLINT DEFAULT (9908)
				,BetType SMALLINT DEFAULT (1201)
				,PRIMARY KEY CLUSTERED (CustID, Sporttype, Bettype))

	--#tbDep_ProductSettingNew
	INSERT INTO #tbDep_ProductSettingNew (ProductSettingID, SettingType)
	SELECT 182, 4 UNION --Product Status
	SELECT 183, 1 UNION	--PT
	SELECT 184, 2 UNION --BetLimit
	SELECT 185, 9		--Comm

	INSERT INTO #tbCustomer (CustID, RoleID)
	SELECT   t.c.value('@CustID','INT')		AS CustID
			,t.c.value('@RoleID','TINYINT')	AS RoleID
	FROM @CustList.nodes('root') t(c)

	IF @mode=1 --For SMA
	BEGIN
		BEGIN  --PT
			--Dep_CustPTSetting_Agent
			INSERT INTO dbo.Dep_CustPTSetting_Agent
				(	[CustID] ,[SportType] ,[BetType] ,[IsLive] ,[SuperPT] ,[MasterPT] ,[AgentPT] )
			SELECT CustID, Sporttype, BetType, 0, @SuperPT, @SuperPT, @SuperPT
			FROM #tbCustomer
			WHERE RoleID=4
	
			INSERT INTO dbo.Dep_CustPTSetting_Agent
				(	[CustID] ,[SportType] ,[BetType] ,[IsLive] ,[SuperPT] ,[MasterPT] ,[AgentPT] )
			SELECT CustID,Sporttype,BetType,0,0,@SuperPT,0	
			FROM #tbCustomer
			WHERE RoleID=3

			INSERT INTO dbo.Dep_CustPTSetting_Agent
				(	[CustID] ,[SportType] ,[BetType] ,[IsLive] ,[SuperPT] ,[MasterPT] ,[AgentPT] )
			SELECT CustID,Sporttype,BetType,0,0,0,@SuperPT
			FROM #tbCustomer
			WHERE RoleID=2

			INSERT INTO dbo.Dep_CustPTGroupSetting_Member
				(	AgentID ,[SportType] ,[BetType] ,[IsLive] ,[SuperPT] ,[MasterPT] ,[AgentPT] )
			SELECT CustID,Sporttype,BetType,0,0,0,@SuperPT
			FROM #tbCustomer
			WHERE RoleID=2
			
			INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
			SELECT CustID, n.ProductSettingID
			FROM #tbCustomer a
				CROSS APPLY (SELECT n.ProductSettingID FROM #tbDep_ProductSettingNew n WHERE n.SettingType=1) n
			WHERE RoleID=4 AND
				NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=a.CustID AND ProductSettingID=n.ProductSettingID)
		END

		BEGIN --Bet Setting
			--Dep_CustBetSetting_Agent
			INSERT INTO Dep_CustBetSetting_Agent ([CustID], [SportType], [BetType], [MinBet], [MaxBet], [MaxPerMatch])
			SELECT CustID, Sporttype, BetType, 50, 22500, 75000
			FROM #tbCustomer
			
			INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
			SELECT CustID, n.ProductSettingID
			FROM #tbCustomer a
				CROSS APPLY (SELECT n.ProductSettingID FROM #tbDep_ProductSettingNew n WHERE n.SettingType = 2) n
			WHERE RoleID=4 AND
				NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=a.CustID AND ProductSettingID=n.ProductSettingID)
		END

		BEGIN --Comm
			
			--Dep_CustDiscountGroupSetting_Member
			INSERT INTO Dep_CustDiscountGroupSetting_Member 
			([AgentID], [SportType], [BetType], [PlayerDiscount], [AgentDiscount], [MasterDiscount], [SuperDiscount])
			SELECT CustID, SportType, BetType, 0, 0, 0, 0
			FROM #tbCustomer	
			WHERE RoleID=2
			
			INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
			SELECT CustID, n.ProductSettingID
			FROM #tbCustomer a
				CROSS APPLY (SELECT n.ProductSettingID FROM #tbDep_ProductSettingNew n WHERE n.SettingType = 9) n
			WHERE RoleID=4 AND
				NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=a.CustID AND ProductSettingID=n.ProductSettingID)
		END
	END

	IF @mode=2 --For Member
	BEGIN
		--Dep_CustPTSetting_Member
		INSERT INTO dbo.Dep_CustPTSetting_Member
			(	CustID ,[SportType] ,[BetType] ,[IsLive] ,[SuperPT] ,[MasterPT] ,[AgentPT] )
		SELECT t.CustID ,Sporttype ,BetType ,0 ,0  ,0 ,@SuperPT
		FROM #tbCustomer t
			INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON t.CustID=m.CustID
		WHERE m.IsGroupedPT=0

		--Dep_CustBetSetting_Member
		INSERT INTO dbo.Dep_CustBetSetting_Member(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
		SELECT CustID, Sporttype, BetType, 50, 22500, 75000
		FROM #tbCustomer
		
		--Dep_CustDiscountSetting_Member
		INSERT INTO Dep_CustDiscountSetting_Member 
		([CustID], [SportType], [BetType], [PlayerDiscount], [AgentDiscount], [MasterDiscount], [SuperDiscount])
		SELECT CustID, SportType, BetType, 0, 0, 0, 0
		FROM #tbCustomer	
	END

	BEGIN --Status
	
		INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
		SELECT c.CustID
			,bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsHidden,@bitmapOrder,0))
			,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsDisabled,@bitmapOrder,0))
		FROM Dep_CustProductStatus c WITH(NOLOCK)
			INNER JOIN custInfo ci WITH(NOLOCK) ON c.CustID = ci.custid
			INNER JOIN  #tbCustomer temp ON temp.CustID = c.custid
	
		UPDATE c 
		SET  c.bitmapIsHidden = tmp.bitmapIsHidden
			,c.bitmapIsDisabled = tmp.bitmapIsDisabled
		FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
			INNER JOIN #Dep_CustProductStatus tmp ON c.CustID = tmp.CustID

		INSERT INTO Dep_CustProductStatus (CustID,bitmapIsDisabled,bitmapIsHidden)
		SELECT	A.custid
				, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @bitmapOrder,0) AS bitmapIsDisabled
				, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @bitmapOrder,0)  AS bitmapIsHidden
		FROM #tbCustomer A
			INNER JOIN custInfo ci WITH(NOLOCK) ON A.CustID = ci.custid
		WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = A.CustID)
			
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT CustID, n.ProductSettingID
		FROM #tbCustomer a
			CROSS APPLY (SELECT n.ProductSettingID FROM #tbDep_ProductSettingNew n WHERE n.SettingType = 4) n
		WHERE RoleID=4 AND
			NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=a.CustID AND ProductSettingID=n.ProductSettingID)

		TRUNCATE TABLE #Dep_CustProductStatus
	END

	DROP TABLE #tbCustomer, #tbDep_ProductSettingNew , #Dep_CustProductStatus
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
		,@BatchSize	INT = 5000
		,@srecommend INT

SELECT @max_custid = xxx

IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
CREATE TABLE #SMAs (CustID INT PRIMARY KEY, RoleID TINYINT)
CREATE TABLE #Members (CustID INT PRIMARY KEY)
CREATE TABLE #tbCustomers_batch (CustID INT PRIMARY KEY, RoleID TINYINT)

---------------------------------------------------------------------------------------------
SET @srecommend = 52761582 
--52761584

--Dummy line
INSERT INTO #Dummy(CustID)
SELECT c.CustID 
FROM Customer c WITH(NOLOCK) 
WHERE c.roleid=3 
	AND c.srecommend = @srecommend
	AND c.custid <= @max_custid
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

--SMAs
INSERT INTO #SMAs (CustID, RoleID)
SELECT c.custid, c.roleid
FROM dbo.CustInfo c WITH(NOLOCK)
WHERE mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND c.srecommend = @srecommend
	AND c.custid <= @max_custid
	AND c.roleid IN (2,3,4)
	AND c.Enabled=1

--Members
INSERT INTO #Members (CustID)
SELECT c.custid
FROM dbo.CustInfo c WITH(NOLOCK)
WHERE mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND c.srecommend = @srecommend
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

DROP TABLE #SMAs, #Members, #tbCustomers_batch, #Dummy
GO
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (/06/DBTP) AND DBCUST (Run last) -----
-----------------------------------------------------------------------------------	
