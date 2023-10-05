/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20221129
	Task: Deposit - Delete existing settings for GDG, Fishing World
		https://nexdev.net/issues/174511
	DB: DBCust/CustDB
*/ 
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@srecommend INT
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at DBCUST only
	
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustDiscountSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustDiscountGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustDiscountSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Member') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN				
	IF dbo.f_CheckRepTable('Dep_ProductSettingDetail') = 0 RETURN		
	IF dbo.f_CheckRepTable('Dep_ProductSetting') = 0 RETURN		
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN

	CREATE TABLE #Dep_ProductSettingDetail (ProductSettingID INT, SettingType SMALLINT, SportType SMALLINT, BetType SMALLINT, IsLive bit, ProductID TINYINT)
	CREATE TABLE #Member (CustID INT PRIMARY KEY CLUSTERED, isfinished BIT DEFAULT(0) )
	CREATE TABLE #SMA (CustID INT PRIMARY KEY CLUSTERED, roleid TINYINT, isfinished BIT DEFAULT(0))

	INSERT INTO #Dep_ProductSettingDetail(ProductSettingID, SettingType, SportType, BetType, IsLive, ProductID)
	SELECT ps.ProductSettingID, SettingType, SportType, BetType, IsLive, ProductID
	FROM Dep_ProductSettingDetail psd WITH(NOLOCK)
	INNER JOIN Dep_ProductSetting ps WITh(NOLOCK) ON psd.ProductSettingID=ps.ProductSettingID
	WHERE ps.ProductID IN (24,59)

	INSERT INTO #Member (CustID)
	SELECT custid 
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1 AND custid <= @maxcustid
	
	INSERT INTO #SMA (CustID, roleid)
	SELECT custid, roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND custid <= @maxcustid 

	DECLARE @batch INT = 3000

	--LicenseeProductSetting
	CREATE TABLE #Dep_LicenseeProductSetting (CustID INT, ProductSettingID INT)

	INSERT INTO #Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT d.CustID
			,d.ProductSettingID
	FROM Dep_LicenseeProductSetting d WITH(NOLOCK) 
		INNER JOIN #SMA ci WITH(NOLOCK) ON d.CustID = ci.custid
		INNER JOIN #Dep_ProductSettingDetail dps WITH(NOLOCK) ON dps.ProductSettingID = d.ProductSettingID 
	WHERE ci.roleid=4

	IF EXISTS (SELECT TOP 1 1 FROM #Dep_LicenseeProductSetting)
	BEGIN
		CREATE TABLE #Dep_LicenseeProductSettingTemp (CustID INT, ProductSettingID INT)
		
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
	END

	--PositionTaking
	IF EXISTS(SELECT TOP 1 1 FROM #Dep_ProductSettingDetail WHERE SettingType IN (1))
	BEGIN
		CREATE TABLE #Dep_CustPTSetting_Agent(CustID INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
												PRIMARY KEY(CustID,Sporttype,Bettype ,IsLive))
		CREATE TABLE #Dep_CustPTSetting_Member(CustID INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
												PRIMARY KEY(CustID,Sporttype,Bettype ,IsLive))
		CREATE TABLE #Dep_CustPTGroupSetting_Member(AgentID INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
												PRIMARY KEY(AgentID ,Sporttype,Bettype ,IsLive))

		CREATE TABLE #Dep_CustPTSetting_AgentTemp(CustID INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
												PRIMARY KEY(CustID,Sporttype,Bettype ,IsLive))
		CREATE TABLE #Dep_CustPTSetting_MemberTemp(CustID INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
												PRIMARY KEY(CustID,Sporttype,Bettype ,IsLive))
		CREATE TABLE #Dep_CustPTGroupSetting_MemberTemp(AgentID INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
												PRIMARY KEY(AgentID ,Sporttype,Bettype ,IsLive))
		
		INSERT INTO #Dep_CustPTSetting_Agent(CustID, SportType, BetType, IsLive)
		SELECT a.CustID, a.SportType, a.BetType, a.IsLive
		FROM Dep_CustPTSetting_Agent a WITH(NOLOCK)
			INNER JOIN #Dep_ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #SMA ci WITH(NOLOCK) ON a.CustID = ci.custid
		WHERE t.SettingType IN (1)
		
		INSERT INTO #Dep_CustPTSetting_Member(CustID, SportType, BetType, IsLive)
		SELECT a.CustID, a.SportType, a.BetType, a.IsLive
		FROM Dep_CustPTSetting_Member a WITH(NOLOCK)
			INNER JOIN #Dep_ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #Member ci WITH(NOLOCK) ON a.CustID = ci.custid
		WHERE t.SettingType IN (1)

		INSERT INTO #Dep_CustPTGroupSetting_Member(AgentID, SportType, BetType, IsLive)
		SELECT a.AgentID, a.SportType, a.BetType, a.IsLive
		FROM Dep_CustPTGroupSetting_Member a WITH(NOLOCK)
			INNER JOIN #Dep_ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #SMA ci WITH(NOLOCK) ON a.AgentID = ci.custid
		WHERE t.SettingType IN (1) AND ci.roleid = 2
		
		WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustPTSetting_Agent)
		BEGIN
			DELETE TOP (@batch) #Dep_CustPTSetting_Agent OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType,DELETED.IsLive
			INTO #Dep_CustPTSetting_AgentTemp(CustID, SportType, BetType, IsLive)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.Dep_CustPTSetting_Agent cg WITH(ROWLOCK)		
				INNER JOIN #Dep_CustPTSetting_AgentTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType AND ci.IsLive = cg.IsLive

			TRUNCATE TABLE #Dep_CustPTSetting_AgentTemp
		END
	
		WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustPTSetting_Member)
		BEGIN
			DELETE TOP (@batch) #Dep_CustPTSetting_Member OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType,DELETED.IsLive
			INTO #Dep_CustPTSetting_MemberTemp(CustID, SportType, BetType, IsLive)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.Dep_CustPTSetting_Member cg WITH(ROWLOCK)		
				INNER JOIN #Dep_CustPTSetting_MemberTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType AND ci.IsLive = cg.IsLive

			TRUNCATE TABLE #Dep_CustPTSetting_MemberTemp
		END
	
		WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustPTGroupSetting_Member)
		BEGIN
			DELETE TOP (@batch) #Dep_CustPTGroupSetting_Member OUTPUT DELETED.AgentID, DELETED.SportType,DELETED.BetType,DELETED.IsLive 
			INTO #Dep_CustPTGroupSetting_MemberTemp(AgentID, SportType, BetType, IsLive)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.Dep_CustPTGroupSetting_Member cg WITH(ROWLOCK)		
				INNER JOIN #Dep_CustPTGroupSetting_MemberTemp ci ON ci.AgentID = cg.AgentID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType AND ci.IsLive = cg.IsLive

			TRUNCATE TABLE #Dep_CustPTGroupSetting_MemberTemp
		END

		DROP TABLE #Dep_CustPTSetting_Agent
		DROP TABLE #Dep_CustPTSetting_Member
		DROP TABLE #Dep_CustPTGroupSetting_Member
		DROP TABLE #Dep_CustPTSetting_AgentTemp
		DROP TABLE #Dep_CustPTSetting_MemberTemp
		DROP TABLE #Dep_CustPTGroupSetting_MemberTemp
	END
	
	--Commission		
	IF EXISTS(SELECT TOP 1 1 FROM #Dep_ProductSettingDetail WHERE SettingType IN (3,5,9))
	BEGIN
		CREATE TABLE #Dep_CustDiscountSetting_Agent(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID,Sporttype,Bettype ))
		CREATE TABLE #Dep_CustDiscountSetting_Member(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID,Sporttype,Bettype))
		CREATE TABLE #Dep_CustDiscountGroupSetting_Member(AgentID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(AgentID ,Sporttype,Bettype))

		CREATE TABLE #Dep_CustDiscountSetting_AgentTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID,Sporttype,Bettype ))
		CREATE TABLE #Dep_CustDiscountSetting_MemberTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID,Sporttype,Bettype))
		CREATE TABLE #Dep_CustDiscountGroupSetting_MemberTemp(AgentID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(AgentID ,Sporttype,Bettype))
		
		INSERT INTO #Dep_CustDiscountSetting_Agent(CustID, SportType, BetType)
		SELECT a.CustID, a.SportType, a.BetType
		FROM Dep_CustDiscountSetting_Agent a WITH(NOLOCK)
			INNER JOIN #Dep_ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #SMA ci WITH(NOLOCK) ON a.CustID = ci.custid
		WHERE t.SettingType IN (3,5,9)
		
		INSERT INTO #Dep_CustDiscountSetting_Member(CustID, SportType, BetType)
		SELECT a.CustID, a.SportType, a.BetType
		FROM Dep_CustDiscountSetting_Member a WITH(NOLOCK)
			INNER JOIN #Dep_ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #Member ci WITH(NOLOCK) ON a.CustID = ci.custid
		WHERE t.SettingType IN (3,5,9)
		
		INSERT INTO #Dep_CustDiscountGroupSetting_Member(AgentID, SportType, BetType)
		SELECT a.AgentID, a.SportType, a.BetType
		FROM Dep_CustDiscountGroupSetting_Member a WITH(NOLOCK)
			INNER JOIN #Dep_ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #SMA ci WITH(NOLOCK) ON a.AgentID = ci.custid
		WHERE t.SettingType IN (3,5,9) AND ci.roleid = 2

		WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustDiscountSetting_Agent)
		BEGIN
			DELETE TOP (@batch) #Dep_CustDiscountSetting_Agent OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
			INTO #Dep_CustDiscountSetting_AgentTemp(CustID, SportType, BetType)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.Dep_CustDiscountSetting_Agent cg WITH(ROWLOCK)		
				INNER JOIN #Dep_CustDiscountSetting_AgentTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

			TRUNCATE TABLE #Dep_CustDiscountSetting_AgentTemp
		END
	
		WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustDiscountSetting_Member)
		BEGIN
			DELETE TOP (@batch) #Dep_CustDiscountSetting_Member OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
			INTO #Dep_CustDiscountSetting_MemberTemp(CustID, SportType, BetType)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.Dep_CustDiscountSetting_Member cg WITH(ROWLOCK)		
				INNER JOIN #Dep_CustDiscountSetting_MemberTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

			TRUNCATE TABLE #Dep_CustDiscountSetting_MemberTemp
		END

		WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustDiscountGroupSetting_Member)
		BEGIN
			DELETE TOP (@batch) #Dep_CustDiscountGroupSetting_Member OUTPUT DELETED.AgentID, DELETED.SportType,DELETED.BetType 
			INTO #Dep_CustDiscountGroupSetting_MemberTemp(AgentID, SportType, BetType)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.Dep_CustDiscountGroupSetting_Member cg WITH(ROWLOCK)		
				INNER JOIN #Dep_CustDiscountGroupSetting_MemberTemp ci ON ci.AgentID = cg.AgentID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

			TRUNCATE TABLE #Dep_CustDiscountGroupSetting_MemberTemp
		END

		DROP TABLE #Dep_CustDiscountSetting_Agent
		DROP TABLE #Dep_CustDiscountSetting_Member
		DROP TABLE #Dep_CustDiscountGroupSetting_Member
		DROP TABLE #Dep_CustDiscountSetting_AgentTemp
		DROP TABLE #Dep_CustDiscountSetting_MemberTemp
		DROP TABLE #Dep_CustDiscountGroupSetting_MemberTemp
	END

	--Stake Level		
	IF EXISTS(SELECT TOP 1 1 FROM #Dep_ProductSettingDetail WHERE SettingType IN (7,8))
	BEGIN
		CREATE TABLE #Dep_CustStakeLevel_Agent(CustID INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID,Sporttype,Bettype))
		CREATE TABLE #Dep_CustStakeLevel_Member(CustID INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID,Sporttype,Bettype))

		CREATE TABLE #Dep_CustStakeLevel_AgentTemp(CustID INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID,Sporttype,Bettype))
		CREATE TABLE #Dep_CustStakeLevel_MemberTemp(CustID INT, SportType SMALLINT, BetType SMALLINT,  
												PRIMARY KEY(CustID,Sporttype,Bettype))
		
		INSERT INTO #Dep_CustStakeLevel_Agent(CustID, SportType, BetType)
		SELECT a.CustID, a.SportType, a.BetType
		FROM Dep_CustStakeLevel_Agent a WITH(NOLOCK)
			INNER JOIN #Dep_ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #SMA ci WITH(NOLOCK) ON a.CustID = ci.custid
		WHERE t.SettingType IN (7,8)
		
		INSERT INTO #Dep_CustStakeLevel_Member(CustID, SportType, BetType)
		SELECT a.CustID, a.SportType, a.BetType
		FROM Dep_CustStakeLevel_Member a WITH(NOLOCK)
			INNER JOIN #Dep_ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #Member ci WITH(NOLOCK) ON a.CustID = ci.custid
		WHERE t.SettingType IN (7,8)

		WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustStakeLevel_Agent)
		BEGIN
			DELETE TOP (@batch) #Dep_CustStakeLevel_Agent OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
			INTO #Dep_CustStakeLevel_AgentTemp(CustID, SportType, BetType)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.Dep_CustStakeLevel_Agent cg WITH(ROWLOCK)		
				INNER JOIN #Dep_CustStakeLevel_AgentTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

			TRUNCATE TABLE #Dep_CustStakeLevel_AgentTemp
		END
	
		WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustStakeLevel_Member)
		BEGIN
			DELETE TOP (@batch) #Dep_CustStakeLevel_Member OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
			INTO #Dep_CustStakeLevel_MemberTemp(CustID, SportType, BetType)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.Dep_CustStakeLevel_Member cg WITH(ROWLOCK)		
				INNER JOIN #Dep_CustStakeLevel_MemberTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

			TRUNCATE TABLE #Dep_CustStakeLevel_MemberTemp
		END

		DROP TABLE #Dep_CustStakeLevel_Agent
		DROP TABLE #Dep_CustStakeLevel_Member
		DROP TABLE #Dep_CustStakeLevel_AgentTemp
		DROP TABLE #Dep_CustStakeLevel_MemberTemp
	END
	
	DROP TABLE #Dep_ProductSettingDetail	
	DROP TABLE #Member
	DROP TABLE #SMA
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','TESTDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'
Print 'Server Name : ' + @target

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
WHERE ci.roleid = 4  
	AND ci.custid IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND ci.custid <= @max_custid
		
-- For DEPLOYER info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers)
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_Dep_DynamicCustSetting_09 
			 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = @target
			
	WAITFOR DELAY '00:00:0.100'
END

DROP TABLE #supers
GO