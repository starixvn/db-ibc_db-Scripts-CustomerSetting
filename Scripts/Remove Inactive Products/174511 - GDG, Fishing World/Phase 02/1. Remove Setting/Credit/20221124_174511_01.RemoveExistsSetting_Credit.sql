/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20221129
	Task: Credit - Delete existing settings for GDG, Fishing World
		https://nexdev.net/issues/174511
	DB: DBCust/CustDB
*/ 
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@srecommend INT
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at DBCUST only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN

	CREATE TABLE #ProductSettingDetail (SettingType SMALLINT, SportType SMALLINT, BetType SMALLINT, IsLive bit, ProductID TINYINT, RealProductId TINYINT)
	CREATE TABLE #Member (CustID INT PRIMARY KEY CLUSTERED, isfinished BIT DEFAULT(0) )
	CREATE TABLE #SMA (CustID INT PRIMARY KEY CLUSTERED, roleid TINYINT, isfinished BIT DEFAULT(0))

	INSERT INTO #ProductSettingDetail(SettingType, SportType, BetType, IsLive, ProductID, RealProductId)
	SELECT SettingType, SportType, BetType, IsLive, ProductID, RealProductId
	FROM ProductSettingDetail WITH(NOLOCK)
	WHERE SettingType NOT IN (4,11,13,21) 
	AND RealProductId IN (24,59)

	INSERT INTO #Member (CustID)
	SELECT custid 
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1 AND custid <= @maxcustid
	
	INSERT INTO #SMA (CustID, roleid)
	SELECT custid, roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND custid <= @maxcustid 

	DECLARE @batch int = 3000
	--PositionTaking
	IF EXISTS(SELECT TOP 1 1 FROM #ProductSettingDetail WHERE SettingType IN (1,18))
	BEGIN
		CREATE TABLE #CustPTSetting3rd_Agent(CustID	INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
		CREATE TABLE #CustPTSetting3rd_Member(CustID	INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
		CREATE TABLE #CustPTGroupSetting3rd_Member(AgentID INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
												PRIMARY KEY(AgentID ,Sporttype ,Bettype ,IsLive))

		CREATE TABLE #CustPTSetting3rd_AgentTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
		CREATE TABLE #CustPTSetting3rd_MemberTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
		CREATE TABLE #CustPTGroupSetting3rd_MemberTemp(AgentID INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
												PRIMARY KEY(AgentID ,Sporttype ,Bettype ,IsLive))
		
		INSERT INTO #CustPTSetting3rd_Agent(CustID, SportType, BetType, IsLive)
		SELECT a.CustID, a.SportType, a.BetType, a.IsLive
		FROM CustPTSetting3rd_Agent a WITH(NOLOCK)
			INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #SMA ci WITH(NOLOCK) ON a.CustID = ci.custid
		WHERE t.SettingType IN (1,18)
		
		INSERT INTO #CustPTSetting3rd_Member(CustID, SportType, BetType, IsLive)
		SELECT a.CustID, a.SportType, a.BetType, a.IsLive
		FROM CustPTSetting3rd_Member a WITH(NOLOCK)
			INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #Member ci WITH(NOLOCK) ON a.CustID = ci.custid
		WHERE t.SettingType IN (1,18)

		INSERT INTO #CustPTGroupSetting3rd_Member(AgentID, SportType, BetType, IsLive)
		SELECT a.AgentID, a.SportType, a.BetType, a.IsLive
		FROM CustPTGroupSetting3rd_Member a WITH(NOLOCK)
			INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #SMA ci WITH(NOLOCK) ON a.AgentID = ci.custid
		WHERE t.SettingType IN (1,18) AND ci.roleid = 2
		
		WHILE EXISTS(SELECT TOP 1 1 FROM #CustPTSetting3rd_Agent)
		BEGIN
			DELETE TOP (@batch) #CustPTSetting3rd_Agent OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType,DELETED.IsLive
			INTO #CustPTSetting3rd_AgentTemp(CustID, SportType, BetType, IsLive)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.CustPTSetting3rd_Agent cg WITH(ROWLOCK)		
				INNER JOIN #CustPTSetting3rd_AgentTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType AND ci.IsLive = cg.IsLive

			TRUNCATE TABLE #CustPTSetting3rd_AgentTemp
		END
	
		WHILE EXISTS(SELECT TOP 1 1 FROM #CustPTSetting3rd_Member)
		BEGIN
			DELETE TOP (@batch) #CustPTSetting3rd_Member OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType,DELETED.IsLive
			INTO #CustPTSetting3rd_MemberTemp(CustID, SportType, BetType, IsLive)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.CustPTSetting3rd_Member cg WITH(ROWLOCK)		
				INNER JOIN #CustPTSetting3rd_MemberTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType AND ci.IsLive = cg.IsLive

			TRUNCATE TABLE #CustPTSetting3rd_MemberTemp
		END
	
		WHILE EXISTS(SELECT TOP 1 1 FROM #CustPTGroupSetting3rd_Member)
		BEGIN
			DELETE TOP (@batch) #CustPTGroupSetting3rd_Member OUTPUT DELETED.AgentID, DELETED.SportType,DELETED.BetType,DELETED.IsLive 
			INTO #CustPTGroupSetting3rd_MemberTemp(AgentID, SportType, BetType, IsLive)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.CustPTGroupSetting3rd_Member cg WITH(ROWLOCK)		
				INNER JOIN #CustPTGroupSetting3rd_MemberTemp ci ON ci.AgentID = cg.AgentID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType AND ci.IsLive = cg.IsLive

			TRUNCATE TABLE #CustPTGroupSetting3rd_MemberTemp
		END

		DROP TABLE #CustPTSetting3rd_Agent
		DROP TABLE #CustPTSetting3rd_Member
		DROP TABLE #CustPTGroupSetting3rd_Member
		DROP TABLE #CustPTSetting3rd_AgentTemp
		DROP TABLE #CustPTSetting3rd_MemberTemp
		DROP TABLE #CustPTGroupSetting3rd_MemberTemp
	END
	
	--Commission		
	IF EXISTS(SELECT TOP 1 1 FROM #ProductSettingDetail WHERE SettingType IN (3,19,5,14))
	BEGIN
		CREATE TABLE #CustDiscount3rd_Agent(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype ))
		CREATE TABLE #CustDiscount3rd_Member(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype))

		CREATE TABLE #CustDiscount3rd_AgentTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype))
		CREATE TABLE #CustDiscount3rd_MemberTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT,  
												PRIMARY KEY(CustID ,Sporttype ,Bettype))
		
		INSERT INTO #CustDiscount3rd_Agent(CustID, SportType, BetType)
		SELECT a.CustID, a.SportType, a.BetType
		FROM CustDiscount3rd_Agent a WITH(NOLOCK)
			INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #SMA ci WITH(NOLOCK) ON a.CustID = ci.custid
		WHERE t.SettingType IN (3,19,5,14)
		
		INSERT INTO #CustDiscount3rd_Member(CustID, SportType, BetType)
		SELECT a.CustID, a.SportType, a.BetType
		FROM CustDiscount3rd_Member a WITH(NOLOCK)
			INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #Member ci WITH(NOLOCK) ON a.CustID = ci.custid
		WHERE t.SettingType IN (3,19,5,14)

		WHILE EXISTS(SELECT TOP 1 1 FROM #CustDiscount3rd_Agent)
		BEGIN
			DELETE TOP (@batch) #CustDiscount3rd_Agent OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
			INTO #CustDiscount3rd_AgentTemp(CustID, SportType, BetType)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.CustDiscount3rd_Agent cg WITH(ROWLOCK)		
				INNER JOIN #CustDiscount3rd_AgentTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

			TRUNCATE TABLE #CustDiscount3rd_AgentTemp
		END
	
		WHILE EXISTS(SELECT TOP 1 1 FROM #CustDiscount3rd_Member)
		BEGIN
			DELETE TOP (@batch) #CustDiscount3rd_Member OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
			INTO #CustDiscount3rd_MemberTemp(CustID, SportType, BetType)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.CustDiscount3rd_Member cg WITH(ROWLOCK)		
				INNER JOIN #CustDiscount3rd_MemberTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

			TRUNCATE TABLE #CustDiscount3rd_MemberTemp
		END

		DROP TABLE #CustDiscount3rd_Agent
		DROP TABLE #CustDiscount3rd_Member
		DROP TABLE #CustDiscount3rd_AgentTemp
		DROP TABLE #CustDiscount3rd_MemberTemp
	END
	
	--Win Loss Limit		
	IF EXISTS(SELECT TOP 1 1 FROM #ProductSettingDetail WHERE SettingType IN (6,12))
	BEGIN
		CREATE TABLE #CustWinLossLimit_Agent(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype ))
		CREATE TABLE #CustWinLossLimit_Member(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype))

		CREATE TABLE #CustWinLossLimit_AgentTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype))
		CREATE TABLE #CustWinLossLimit_MemberTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT,  
												PRIMARY KEY(CustID ,Sporttype ,Bettype))
		
		INSERT INTO #CustWinLossLimit_Agent(CustID, SportType, BetType)
		SELECT a.CustID, a.SportType, a.BetType
		FROM CustWinLossLimit_Agent a WITH(NOLOCK)
			INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #SMA ci WITH(NOLOCK) ON a.CustID = ci.custid
		WHERE t.SettingType IN (6,12)
		
		INSERT INTO #CustWinLossLimit_Member(CustID, SportType, BetType)
		SELECT a.CustID, a.SportType, a.BetType
		FROM CustWinLossLimit_Member a WITH(NOLOCK)
			INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #Member ci WITH(NOLOCK) ON a.CustID = ci.custid
		WHERE t.SettingType IN (6,12)

		WHILE EXISTS(SELECT TOP 1 1 FROM #CustWinLossLimit_Agent)
		BEGIN
			DELETE TOP (@batch) #CustWinLossLimit_Agent OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
			INTO #CustWinLossLimit_AgentTemp(CustID, SportType, BetType)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.CustWinLossLimit_Agent cg WITH(ROWLOCK)		
				INNER JOIN #CustWinLossLimit_AgentTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

			TRUNCATE TABLE #CustWinLossLimit_AgentTemp
		END
	
		WHILE EXISTS(SELECT TOP 1 1 FROM #CustWinLossLimit_Member)
		BEGIN
			DELETE TOP (@batch) #CustWinLossLimit_Member OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
			INTO #CustWinLossLimit_MemberTemp(CustID, SportType, BetType)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.CustWinLossLimit_Member cg WITH(ROWLOCK)		
				INNER JOIN #CustWinLossLimit_MemberTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

			TRUNCATE TABLE #CustWinLossLimit_MemberTemp
		END

		DROP TABLE #CustWinLossLimit_Agent
		DROP TABLE #CustWinLossLimit_Member
		DROP TABLE #CustWinLossLimit_AgentTemp
		DROP TABLE #CustWinLossLimit_MemberTemp
	END
	
	--Stake Level		
	IF EXISTS(SELECT TOP 1 1 FROM #ProductSettingDetail WHERE SettingType IN (7,8,17))
	BEGIN
		CREATE TABLE #CustStakeLevel_Agent(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype ))
		CREATE TABLE #CustStakeLevel_Member(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype))

		CREATE TABLE #CustStakeLevel_AgentTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype))
		CREATE TABLE #CustStakeLevel_MemberTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT,  
												PRIMARY KEY(CustID ,Sporttype ,Bettype))
		
		INSERT INTO #CustStakeLevel_Agent(CustID, SportType, BetType)
		SELECT a.CustID, a.SportType, a.BetType
		FROM CustStakeLevel_Agent a WITH(NOLOCK)
			INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #SMA ci WITH(NOLOCK) ON a.CustID = ci.custid
		WHERE t.SettingType IN (7,8,17)
		
		INSERT INTO #CustStakeLevel_Member(CustID, SportType, BetType)
		SELECT a.CustID, a.SportType, a.BetType
		FROM CustStakeLevel_Member a WITH(NOLOCK)
			INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #Member ci WITH(NOLOCK) ON a.CustID = ci.custid
		WHERE t.SettingType IN (7,8,17)

		WHILE EXISTS(SELECT TOP 1 1 FROM #CustStakeLevel_Agent)
		BEGIN
			DELETE TOP (@batch) #CustStakeLevel_Agent OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
			INTO #CustStakeLevel_AgentTemp(CustID, SportType, BetType)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.CustStakeLevel_Agent cg WITH(ROWLOCK)		
				INNER JOIN #CustStakeLevel_AgentTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

			TRUNCATE TABLE #CustStakeLevel_AgentTemp
		END
	
		WHILE EXISTS(SELECT TOP 1 1 FROM #CustStakeLevel_Member)
		BEGIN
			DELETE TOP (@batch) #CustStakeLevel_Member OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
			INTO #CustStakeLevel_MemberTemp(CustID, SportType, BetType)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.CustStakeLevel_Member cg WITH(ROWLOCK)		
				INNER JOIN #CustStakeLevel_MemberTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

			TRUNCATE TABLE #CustStakeLevel_MemberTemp
		END

		DROP TABLE #CustStakeLevel_Agent
		DROP TABLE #CustStakeLevel_Member
		DROP TABLE #CustStakeLevel_AgentTemp
		DROP TABLE #CustStakeLevel_MemberTemp
	END
	
	DROP TABLE #ProductSettingDetail	
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
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
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
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
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

	EXEC dbo.Acc_DynamicCustSetting3rd_09 
			 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = @target
			
	WAITFOR DELAY '00:00:0.100'
END

DROP TABLE #supers
GO