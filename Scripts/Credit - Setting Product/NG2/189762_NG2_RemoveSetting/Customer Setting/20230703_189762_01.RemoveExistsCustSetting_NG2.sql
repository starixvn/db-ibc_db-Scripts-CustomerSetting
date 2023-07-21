/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20230703
	Task: NG2 - Remove Setting
		https://nexdev.net/issues/189762
	DB: DBCust/CustDB and all replicated server
*/ 
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	 @CustList XML
	,@mode TINYINT	-- 1 ~ SMA; 2 ~ Member
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at DBCUST only
	
	IF dbo.f_CheckRepTable('ProductSettingDetail') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN

	CREATE TABLE #ProductSettingDetail (SettingType SMALLINT, SportType SMALLINT, BetType SMALLINT, IsLive bit, ProductID TINYINT, RealProductId TINYINT)

	CREATE TABLE #tbCustomer(CustID	INT PRIMARY KEY, roleID	TINYINT NOT NULL)

	INSERT INTO #ProductSettingDetail(SettingType, SportType, BetType, IsLive, ProductID, RealProductId)
	SELECT SettingType, SportType, BetType, IsLive, ProductID, RealProductId
	FROM ProductSettingDetail WITH(NOLOCK)
	WHERE SettingType NOT IN (4,11,13,21) -- Product status
	AND RealProductId = 23

	INSERT INTO #tbCustomer (CustID, roleID)
	SELECT   t.c.value('@CustID','INT')		AS CustID
			,t.c.value('@roleID','TINYINT')	AS roleID
	FROM @CustList.nodes('root') t(c)

	DECLARE @batch int = 3000

	--PositionTaking
	IF EXISTS(SELECT TOP 1 1 FROM #ProductSettingDetail WHERE SettingType IN (1,18))
	BEGIN
		IF @mode=1
		BEGIN
			CREATE TABLE #tbCustPTSetting3rd_Agent(CustID	INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
													PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
			CREATE TABLE #tbCustPTGroupSetting3rd_Member(AgentID INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
													PRIMARY KEY(AgentID ,Sporttype ,Bettype ,IsLive))

			CREATE TABLE #tbCustPTSetting3rd_AgentTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
													PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
			CREATE TABLE #tbCustPTGroupSetting3rd_MemberTemp(AgentID INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
													PRIMARY KEY(AgentID ,Sporttype ,Bettype ,IsLive))

			INSERT INTO #tbCustPTSetting3rd_Agent(CustID, SportType, BetType, IsLive)
			SELECT a.CustID, a.SportType, a.BetType, a.IsLive
			FROM CustPTSetting3rd_Agent a WITH(NOLOCK)
				INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
				INNER JOIN #tbCustomer ci WITH(NOLOCK) ON a.CustID = ci.custid
			WHERE t.SettingType IN (1,18)

			INSERT INTO #tbCustPTGroupSetting3rd_Member(AgentID, SportType, BetType, IsLive)
			SELECT a.AgentID, a.SportType, a.BetType, a.IsLive
			FROM CustPTGroupSetting3rd_Member a WITH(NOLOCK)
				INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
				INNER JOIN #tbCustomer ci WITH(NOLOCK) ON a.AgentID = ci.custid
			WHERE t.SettingType IN (1,18) AND ci.roleid = 2

			--Delete data
			WHILE EXISTS(SELECT TOP 1 1 FROM #tbCustPTSetting3rd_Agent)
			BEGIN
				DELETE TOP (@batch) #tbCustPTSetting3rd_Agent OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType,DELETED.IsLive
				INTO #tbCustPTSetting3rd_AgentTemp(CustID, SportType, BetType, IsLive)

				IF @@ROWCOUNT=0
					BREAK

				DELETE cg
				FROM dbo.CustPTSetting3rd_Agent cg WITH(ROWLOCK)		
					INNER JOIN #tbCustPTSetting3rd_AgentTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType AND ci.IsLive = cg.IsLive
				
				TRUNCATE TABLE #tbCustPTSetting3rd_AgentTemp
			END

			WHILE EXISTS(SELECT TOP 1 1 FROM #tbCustPTGroupSetting3rd_Member)
			BEGIN
				DELETE TOP (@batch) #tbCustPTGroupSetting3rd_Member OUTPUT DELETED.AgentID, DELETED.SportType,DELETED.BetType,DELETED.IsLive
				INTO #tbCustPTGroupSetting3rd_MemberTemp(AgentID, SportType, BetType, IsLive)

				IF @@ROWCOUNT=0
					BREAK
			
				DELETE cg
				FROM dbo.CustPTGroupSetting3rd_Member cg WITH(ROWLOCK)		
					INNER JOIN #tbCustPTGroupSetting3rd_MemberTemp ci ON ci.AgentID = cg.AgentID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType AND ci.IsLive = cg.IsLive

				TRUNCATE TABLE #tbCustPTGroupSetting3rd_MemberTemp
			END

			DROP TABLE #tbCustPTSetting3rd_Agent
			DROP TABLE #tbCustPTGroupSetting3rd_Member
			DROP TABLE #tbCustPTSetting3rd_AgentTemp
			DROP TABLE #tbCustPTGroupSetting3rd_MemberTemp
		END
		ELSE IF @mode=2
		BEGIN
			CREATE TABLE #tbCustPTSetting3rd_Member(CustID INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
												  PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
				
			CREATE TABLE #tbCustPTSetting3rd_MemberTemp(CustID INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
												  PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))

			INSERT INTO #tbCustPTSetting3rd_Member(CustID, SportType, BetType, IsLive)
			SELECT a.CustID, a.SportType, a.BetType, a.IsLive
			FROM CustPTSetting3rd_Member a WITH(NOLOCK)
				INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
				INNER JOIN #tbCustomer ci WITH(NOLOCK) ON a.CustID = ci.custid
			WHERE t.SettingType IN (1,18)

			WHILE EXISTS(SELECT TOP 1 1 FROM #tbCustPTSetting3rd_Member)
			BEGIN
				DELETE TOP (@batch) #tbCustPTSetting3rd_Member OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType,DELETED.IsLive
				INTO #tbCustPTSetting3rd_MemberTemp(CustID, SportType, BetType, IsLive)

				IF @@ROWCOUNT=0
					BREAK
			
				DELETE cg
				FROM dbo.CustPTSetting3rd_Member cg WITH(ROWLOCK)		
				INNER JOIN #tbCustPTSetting3rd_MemberTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType AND ci.IsLive = cg.IsLive

				TRUNCATE TABLE #tbCustPTSetting3rd_MemberTemp
			END
			
			DROP TABLE #tbCustPTSetting3rd_Member
			DROP TABLE #tbCustPTSetting3rd_MemberTemp
		END
	END
	
	--Commission		
	IF EXISTS(SELECT TOP 1 1 FROM #ProductSettingDetail WHERE SettingType IN (3,19,5,14))
	BEGIN
		IF @mode=1
		BEGIN	
			CREATE TABLE #tbCustDiscount3rd_Agent(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
													PRIMARY KEY(CustID ,Sporttype ,Bettype ))
			
			CREATE TABLE #tbCustDiscount3rd_AgentTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
													PRIMARY KEY(CustID ,Sporttype ,Bettype ))

			INSERT INTO #tbCustDiscount3rd_Agent(CustID, SportType, BetType)
			SELECT a.CustID, a.SportType, a.BetType
			FROM CustDiscount3rd_Agent a WITH(NOLOCK)
				INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
				INNER JOIN #tbCustomer ci WITH(NOLOCK) ON a.CustID = ci.custid
			WHERE t.SettingType IN (3,19,5,14)
			
			WHILE EXISTS(SELECT TOP 1 1 FROM #tbCustDiscount3rd_Agent)
			BEGIN
				DELETE TOP (@batch) #tbCustDiscount3rd_Agent OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
				INTO #tbCustDiscount3rd_AgentTemp(CustID, SportType, BetType)

				IF @@ROWCOUNT=0
					BREAK
			
				DELETE cg
				FROM dbo.CustDiscount3rd_Agent cg WITH(ROWLOCK)		
				INNER JOIN #tbCustDiscount3rd_AgentTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

				TRUNCATE TABLE #tbCustDiscount3rd_AgentTemp
			END

			DROP TABLE #tbCustDiscount3rd_Agent
			DROP TABLE #tbCustDiscount3rd_AgentTemp
		END
		ELSE IF @mode=2
		BEGIN
			CREATE TABLE #tbCustDiscount3rd_Member(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
													PRIMARY KEY(CustID ,Sporttype ,Bettype))

			CREATE TABLE #tbCustDiscount3rd_MemberTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
													PRIMARY KEY(CustID ,Sporttype ,Bettype))
			
			INSERT INTO #tbCustDiscount3rd_Member(CustID, SportType, BetType)
			SELECT a.CustID, a.SportType, a.BetType
			FROM CustDiscount3rd_Member a WITH(NOLOCK)
				INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
				INNER JOIN #tbCustomer ci WITH(NOLOCK) ON a.CustID = ci.custid
			WHERE t.SettingType IN (3,19,5,14)

			WHILE EXISTS(SELECT TOP 1 1 FROM #tbCustDiscount3rd_Member)
			BEGIN
				DELETE TOP (@batch) #tbCustDiscount3rd_Member OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
				INTO #tbCustDiscount3rd_MemberTemp(CustID, SportType, BetType)

				IF @@ROWCOUNT=0
					BREAK
			
				DELETE cg
				FROM dbo.CustDiscount3rd_Member cg WITH(ROWLOCK)		
				INNER JOIN #tbCustDiscount3rd_MemberTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

				TRUNCATE TABLE #tbCustDiscount3rd_MemberTemp
			END

			DROP TABLE #tbCustDiscount3rd_Member
			DROP TABLE #tbCustDiscount3rd_MemberTemp
		END
	END
	
	--Bet setting		
	IF EXISTS(SELECT TOP 1 1 FROM #ProductSettingDetail WHERE SettingType IN (2,9,16,20,23))
	BEGIN
		IF @mode=1
		BEGIN
			CREATE TABLE #tbCustBetSetting3rd_Agent(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
													PRIMARY KEY(CustID ,Sporttype ,Bettype ))
			
			CREATE TABLE #tbCustBetSetting3rd_AgentTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
													PRIMARY KEY(CustID ,Sporttype ,Bettype ))

			INSERT INTO #tbCustBetSetting3rd_Agent(CustID, SportType, BetType)
			SELECT a.CustID, a.SportType, a.BetType
			FROM CustBetSetting3rd_Agent a WITH(NOLOCK)
				INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
				INNER JOIN #tbCustomer ci WITH(NOLOCK) ON a.CustID = ci.custid
			WHERE t.SettingType IN (2,9,16,20,23)

			WHILE EXISTS(SELECT TOP 1 1 FROM #tbCustBetSetting3rd_Agent)
			BEGIN
				DELETE TOP (@batch) #tbCustBetSetting3rd_Agent OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
				INTO #tbCustBetSetting3rd_AgentTemp(CustID, SportType, BetType)

				IF @@ROWCOUNT=0
					BREAK
			
				DELETE cg
				FROM dbo.CustBetSetting3rd_Agent cg WITH(ROWLOCK)	
				INNER JOIN #tbCustBetSetting3rd_AgentTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType
				
				TRUNCATE TABLE #tbCustBetSetting3rd_AgentTemp
			END

			DROP TABLE #tbCustBetSetting3rd_Agent
			DROP TABLE #tbCustBetSetting3rd_AgentTemp
		END
		ELSE IF @mode=2
		BEGIN
			CREATE TABLE #tbCustBetSetting3rd_Member(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
													PRIMARY KEY(CustID ,Sporttype ,Bettype ))
			
			CREATE TABLE #tbCustBetSetting3rd_MemberTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
													PRIMARY KEY(CustID ,Sporttype ,Bettype ))

			INSERT INTO #tbCustBetSetting3rd_Member(CustID, SportType, BetType)
			SELECT a.CustID, a.SportType, a.BetType
			FROM CustBetSetting3rd_Member a WITH(NOLOCK)
				INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
				INNER JOIN #tbCustomer ci WITH(NOLOCK) ON a.CustID = ci.custid
			WHERE t.SettingType IN (2,9,16,20,23)

			WHILE EXISTS(SELECT TOP 1 1 FROM #tbCustBetSetting3rd_Member)
			BEGIN
				DELETE TOP (@batch) #tbCustBetSetting3rd_Member OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
				INTO #tbCustBetSetting3rd_MemberTemp(CustID, SportType, BetType)

				IF @@ROWCOUNT=0
					BREAK
			
				DELETE cg
				FROM dbo.CustBetSetting3rd_Member cg WITH(ROWLOCK)		
				INNER JOIN #tbCustBetSetting3rd_MemberTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType
				
				TRUNCATE TABLE #tbCustBetSetting3rd_MemberTemp
			END

			DROP TABLE #tbCustBetSetting3rd_Member
			DROP TABLE #tbCustBetSetting3rd_MemberTemp
		END
	END
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST-----
----------------------------------------------------------------------------------------------
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
----------------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

DECLARE @Cust_cnt	INT,
		@max_custid INT,
		@CustList   XML

SELECT @max_custid = xxx

CREATE TABLE #SMA(
	CustID		INT PRIMARY KEY
	,roleID		TINYINT NOT NULL
)

CREATE TABLE #Member(
	CustID		INT PRIMARY KEY
)

CREATE TABLE #Customer_batch(
	CustID		INT PRIMARY KEY
	,roleID		TINYINT NOT NULL
)
------------------------------------------------
--SMA
INSERT INTO #SMA(custid, roleID)
SELECT ci.custid, ci.roleid
FROM customer ci WITH (NOLOCK) 
INNER JOIN site s WITH (NOLOCK) ON s.site=ci.site
WHERE ci.roleid in (2,3,4)  
	AND ci.srecommend NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND ci.custid <= @max_custid
	AND s.SiteLabel='789y'

--Member
INSERT INTO #Member(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
INNER JOIN site s WITH (NOLOCK) ON s.site=ci.site
WHERE ci.roleid=1  
	AND ci.srecommend NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND ci.custid <= @max_custid
	AND s.SiteLabel='789y'

-- For deployer info
---------------------------------------------------------------------------------------------
SELECT @Cust_cnt = COUNT(1)
FROM #SMA

SELECT @Cust_cnt += COUNT(1)
FROM #Member

DECLARE @msg_total NVARCHAR(200) = 'Total of Customers Affected: %d.'

RAISERROR (@msg_total, 0, 1, @Cust_cnt) WITH NOWAIT

--For SMA
WHILE (1=1)
BEGIN
	DELETE FROM #Customer_batch

	DELETE TOP (3000) T
	OUTPUT deleted.CustID, deleted.roleID
		INTO #Customer_batch(CustID, roleID)
	FROM #SMA t 

	IF @@ROWCOUNT = 0 BREAK

	SELECT @CustList=(SELECT CustID AS '@CustID', 
							 roleID AS '@roleID'
					  FROM #Customer_batch
					  FOR XML PATH('root')
					 )
	
	EXEC dbo.[Acc_DynamicCustSetting3rd_09] 
			@CustList=@CustList,
			@mode=1,
			@target = @target
	
	WAITFOR DELAY '00:00:0.050'

	SET @msg_total = 'SMA - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)

	RAISERROR (@msg_total, 0, 1) WITH NOWAIT
END	

--For Member
WHILE (1=1)
BEGIN
	DELETE FROM #Customer_batch

	DELETE TOP (3000) T
	OUTPUT deleted.CustID, 1
		INTO #Customer_batch(CustID, roleID)
	FROM #Member t  

	IF @@ROWCOUNT = 0 BREAK
	
	SELECT @CustList=(SELECT CustID AS '@CustID', 
							 roleID AS '@roleID'
					  FROM #Customer_batch
					  FOR XML PATH('root')
					 )

	EXEC dbo.[Acc_DynamicCustSetting3rd_09]
			@CustList=@CustList,
			@mode=2,
			@target = @target
	
	WAITFOR DELAY '00:00:0.050'

	SET @msg_total = 'Member - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)

	RAISERROR (@msg_total, 0, 1) WITH NOWAIT
END	

DROP TABLE #SMA, #Member, #Customer_batch
GO	

PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
GO

-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
-----------------------------------------------------------------------------------