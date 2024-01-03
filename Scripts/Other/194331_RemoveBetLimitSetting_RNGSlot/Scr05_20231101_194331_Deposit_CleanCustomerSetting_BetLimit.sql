/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20231101
	Task: RNG Slot products - clean redundant data - Deposit
		https://nexdev.net/issues/194331
	DB: DBCust/CustDB and all replicated server
*/
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@CustList XML
	,@mode TINYINT	-- 1 ~ SMA; 2 ~ Member
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')) RETURN -- run at DBCUST only

	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Member') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_ProductSettingDetail') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_ProductSetting') = 0 RETURN	

	CREATE TABLE #tbCustomer(
				 CustID	INT
				,roleID	TINYINT NOT NULL
				,SportType SMALLINT
				,BetType SMALLINT
				,ProductSettingID INT
				,PRIMARY KEY CLUSTERED (CustID, Sporttype, Bettype))
	
	CREATE TABLE #SportRNG (SportType SMALLINT)
	CREATE TABLE #Dep_ProductSettingDetail (ProductSettingID INT, SportType SMALLINT, BetType SMALLINT)

	INSERT INTO #SportRNG (SportType)
		  SELECT 155 --MG-RNG
	UNION SELECT 156 --SEAL Entertainment
	UNION SELECT 158 --Jili
	UNION SELECT 165 --Arcadia Gaming
	UNION SELECT 167 --CG
	UNION SELECT 172 --AdvantPlay
	UNION SELECT 174 --AdvantPlay Mini
	UNION SELECT 212 --Macau Games
	UNION SELECT 232 --PG Soft
	UNION SELECT 234 --Joker
	UNION SELECT 237 --MaxGame
	UNION SELECT 238 --Habanero
	UNION SELECT 247 --SG
	UNION SELECT 248 --PP

	INSERT INTO #Dep_ProductSettingDetail(ProductSettingID, SportType, BetType)
	SELECT ps.ProductSettingID, psd.SportType, psd.BetType
	FROM  Dep_ProductSettingDetail psd WITH (ROWLOCK, UPDLOCK)
	INNER JOIN Dep_ProductSetting ps WITH (NOLOCK) ON psd.ProductSettingID=ps.ProductSettingID
	INNER JOIN #SportRNG s ON s.sporttype=psd.SportType
	WHERE SettingType=8 AND SettingStatus=2

	INSERT INTO #tbCustomer (CustID, roleID,SportType, BetType, ProductSettingID)
	SELECT   t.c.value('@CustID','INT')		AS CustID
			,t.c.value('@roleID','TINYINT')	AS roleID
			,s.SportType
			,s.BetType
			,s.ProductSettingID
	FROM @CustList.nodes('root') t(c)
	CROSS APPLY (SELECT SportType, BetType, ProductSettingID FROM #Dep_ProductSettingDetail) s

	DECLARE @batch INT = 3000

	IF @mode=1	--SMA
	BEGIN
		--LicenseeProductSetting
		IF EXISTS (SELECT TOP 1 1 FROM #tbCustomer WHERE roleID=4)
		BEGIN
			CREATE TABLE #Dep_LicenseeProductSetting (CustID INT, ProductSettingID INT)
			CREATE TABLE #Dep_LicenseeProductSettingTemp (CustID INT, ProductSettingID INT)

			INSERT INTO #Dep_LicenseeProductSetting(CustID,ProductSettingID)
			SELECT d.CustID, d.ProductSettingID
			FROM Dep_LicenseeProductSetting d WITH(NOLOCK) 
				INNER JOIN #tbCustomer ci WITH(NOLOCK) ON d.CustID = ci.custid
														AND ci.ProductSettingID = d.ProductSettingID 
			WHERE ci.roleid=4

			WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_LicenseeProductSetting)
			BEGIN
				DELETE TOP (@batch) #Dep_LicenseeProductSetting OUTPUT DELETED.CustID, DELETED.ProductSettingID
				INTO #Dep_LicenseeProductSettingTemp(CustID, ProductSettingID)

				IF @@ROWCOUNT=0
					BREAK		

				DELETE lps
				FROM dbo.Dep_LicenseeProductSetting lps WITH(ROWLOCK)		
					INNER JOIN #Dep_LicenseeProductSettingTemp ci ON ci.custid = lps.CustID AND ci.ProductSettingID = lps.ProductSettingID

				TRUNCATE TABLE #Dep_LicenseeProductSettingTemp
			END

			DROP TABLE #Dep_LicenseeProductSetting, #Dep_LicenseeProductSettingTemp
		END

		CREATE TABLE #tbDep_CustStakeLevel_Agent(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID,Sporttype,Bettype ))
			
		CREATE TABLE #tbDep_CustStakeLevel_AgentTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID,Sporttype,Bettype ))

		INSERT INTO #tbDep_CustStakeLevel_Agent(CustID, SportType, BetType)
		SELECT a.CustID, a.SportType, a.BetType
		FROM Dep_CustStakeLevel_Agent a WITH(NOLOCK)
		INNER JOIN #tbCustomer c ON c.CustID=a.CustID
								AND c.SportType=a.SportType
								AND c.BetType=a.BetType

		WHILE EXISTS(SELECT TOP 1 1 FROM #tbDep_CustStakeLevel_Agent)
		BEGIN
			DELETE TOP (@batch) #tbDep_CustStakeLevel_Agent OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
			INTO #tbDep_CustStakeLevel_AgentTemp(CustID, SportType, BetType)

			IF @@ROWCOUNT=0
				BREAK
			
			DELETE cg
			FROM dbo.Dep_CustStakeLevel_Agent cg WITH(ROWLOCK)		
			INNER JOIN #tbDep_CustStakeLevel_AgentTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

			TRUNCATE TABLE #tbDep_CustStakeLevel_AgentTemp

			WAITFOR DELAY '00:00:00:030'
		END

		DROP TABLE #tbDep_CustStakeLevel_Agent
		DROP TABLE #tbDep_CustStakeLevel_AgentTemp

	END
	
	IF @mode=2	--Member
	BEGIN
		CREATE TABLE #tbDep_CustStakeLevel_Member(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID,Sporttype,Bettype))

		CREATE TABLE #tbDep_CustStakeLevel_MemberTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID,Sporttype,Bettype))
			
		INSERT INTO #tbDep_CustStakeLevel_Member(CustID, SportType, BetType)
		SELECT a.CustID, a.SportType, a.BetType
		FROM Dep_CustStakeLevel_Member a WITH(NOLOCK)
		INNER JOIN #tbCustomer c ON c.CustID=a.CustID
								AND c.SportType=a.SportType
								AND c.BetType=a.BetType

		WHILE EXISTS(SELECT TOP 1 1 FROM #tbDep_CustStakeLevel_Member)
		BEGIN
			DELETE TOP (@batch) #tbDep_CustStakeLevel_Member OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
			INTO #tbDep_CustStakeLevel_MemberTemp(CustID, SportType, BetType)

			IF @@ROWCOUNT=0
				BREAK
			
			DELETE cg
			FROM dbo.Dep_CustStakeLevel_Member cg WITH(ROWLOCK)		
			INNER JOIN #tbDep_CustStakeLevel_MemberTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

			TRUNCATE TABLE #tbDep_CustStakeLevel_MemberTemp

			WAITFOR DELAY '00:00:00:030'
		END

		DROP TABLE #tbDep_CustStakeLevel_Member
		DROP TABLE #tbDep_CustStakeLevel_MemberTemp
	END
END
GO
------------------------------------------------------	
-- BEGIN: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST-----
----------------------------------------------------------------------------------------------
PRINT N'DEPOSIT - Step 3: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
PRINT N'--------------------------------------------------------'
----------------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

DECLARE @Cust_cnt	INT,
		@max_custid INT,
		@CustList   XML,
		@BatchSize	INT = 1500

SELECT @max_custid = xxx
	
CREATE TABLE #SMA(CustID INT PRIMARY KEY, roleID TINYINT NOT NULL)

CREATE TABLE #Member(CustID INT PRIMARY KEY)

CREATE TABLE #Customer_batch(CustID INT PRIMARY KEY, roleID TINYINT NOT NULL)

------------------------------------------------
--SMA
INSERT INTO #SMA(custid, roleID)
SELECT ci.custid, ci.roleid
FROM customer ci WITH (NOLOCK) 
INNER JOIN Dep_CustSuper cs WITH (NOLOCK) ON cs.custid=ci.srecommend
WHERE ci.custid <= @max_custid
AND ci.roleid in (2,3,4)  

--Member
INSERT INTO #Member(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
INNER JOIN Dep_CustSuper cs WITH (NOLOCK) ON cs.custid=ci.srecommend
WHERE ci.custid <= @max_custid
AND ci.roleid = 1
---------------------------------------------------------------------------------------------

SELECT @Cust_cnt = COUNT(1)
FROM #SMA

SELECT @Cust_cnt += COUNT(1)
FROM #Member

DECLARE @msg_total NVARCHAR(200) = 'Deposit - Total of Customers Affected: %d.'

RAISERROR (@msg_total, 0, 1, @Cust_cnt) WITH NOWAIT

--For SMA
WHILE (1=1)
BEGIN
	DELETE FROM #Customer_batch

	DELETE TOP (@BatchSize) T
	OUTPUT deleted.CustID, deleted.roleID
		INTO #Customer_batch(CustID, roleID)
	FROM #SMA t 

	IF @@ROWCOUNT = 0 BREAK

	SELECT @CustList=(SELECT CustID AS '@CustID', 
							 roleID AS '@roleID'
					  FROM #Customer_batch
					  FOR XML PATH('root')
					 )
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] 
			@CustList=@CustList,
			@mode=1,
			@target = @target
	
	WAITFOR DELAY '00:00:00:280'

	SET @msg_total = 'SMA - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)

	RAISERROR (@msg_total, 0, 1) WITH NOWAIT
END	

--For Member
WHILE (1=1)
BEGIN
	DELETE FROM #Customer_batch

	DELETE TOP (@BatchSize) T
	OUTPUT deleted.CustID, 1
		INTO #Customer_batch(CustID, roleID)
	FROM #Member t 

	IF @@ROWCOUNT = 0 BREAK

	SELECT @CustList=(SELECT CustID AS '@CustID', 
							 roleID AS '@roleID'
					  FROM #Customer_batch
					  FOR XML PATH('root')
					 )

	EXEC dbo.[Acc_Dep_DynamicCustSetting_09]
			@CustList=@CustList,
			@mode=2,
			@target = @target
	
	WAITFOR DELAY '00:00:00:280'

	SET @msg_total = 'Member - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)

	RAISERROR (@msg_total, 0, 1) WITH NOWAIT
END	

PRINT N'--------------------------------------------------------'
PRINT N'DEPOSIT - Step 3: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
GO

-- END: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
-----------------------------------------------------------------------------------
