/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221121@Eden
	Task: Delete unused settings of VS and RNG Lottery [#180640]
	DB: DBCust/CustDB and all subscribers of Custdb_custsetting publication
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
	IF dbo.f_CheckRepTable('site') = 0 RETURN
	IF dbo.f_CheckRepTable('customer') = 0 RETURN	
	IF dbo.f_CheckRepTable('custsuper') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_CustSuper') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN

	CREATE TABLE #ProductSettingDetail (SettingType SMALLINT, SportType SMALLINT, BetType SMALLINT, Islive BIT DEFAULT 0)
	CREATE TABLE #Member (CustID INT PRIMARY KEY CLUSTERED, isfinished BIT DEFAULT(0) )
	CREATE TABLE #SMATemp (	CustID INT PRIMARY KEY CLUSTERED, roleid TINYINT, isfinished BIT DEFAULT(0))

	INSERT INTO #ProductSettingDetail(SportType, BetType, SettingType)
	--PT VS
			  SELECT 180,	1201, 1
	UNION ALL SELECT 181,	1231, 1
	UNION ALL SELECT 182,	1231, 1
	UNION ALL SELECT 183,	1231, 1
	UNION ALL SELECT 184,	1231, 1
	UNION ALL SELECT 185,	1231, 1
	UNION ALL SELECT 186,	1220, 1
	UNION ALL SELECT 190,	2701, 1
	UNION ALL SELECT 191,	2701, 1
	UNION ALL SELECT 192,	2701, 1
	UNION ALL SELECT 193,	2801, 1
	UNION ALL SELECT 231,	5301, 1
	--Bet Setting VS
	UNION ALL SELECT 180,	1201, 2
	UNION ALL SELECT 181,	1231, 2
	UNION ALL SELECT 182,	1231, 2
	UNION ALL SELECT 183,	1231, 2
	UNION ALL SELECT 184,	1231, 2
	UNION ALL SELECT 185,	1231, 2
	UNION ALL SELECT 186,	1220, 2
	UNION ALL SELECT 190,	2701, 2
	UNION ALL SELECT 191,	2701, 2
	UNION ALL SELECT 192,	2701, 2
	UNION ALL SELECT 193,	2801, 2
	UNION ALL SELECT 199,	2799, 2
	UNION ALL SELECT 231,	5301, 20
	--WL Limit VS
	UNION ALL SELECT 180,	1201, 6
	--PT Lottery
	UNION ALL SELECT 220,	1021, 18
	UNION ALL SELECT 220,	1022, 18
	UNION ALL SELECT 220,	1023, 18
	--Bet Setting Lottery
	UNION ALL SELECT 220,	1021, 2
	UNION ALL SELECT 220,	1022, 2
	UNION ALL SELECT 220,	1023, 2
	--WL Limit RNG Lottery
	UNION ALL SELECT 169,	3611, 6
	UNION ALL SELECT 220,	1021, 6
	UNION ALL SELECT 222,	4901, 6
	UNION ALL SELECT 224,	5500, 6

	INSERT INTO #Member (CustID  )
	SELECT custid 
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1  --AND Enabled = 1 
		AND custid <= @maxcustid
	
	INSERT INTO #SMATemp (CustID, roleid)
	SELECT custid, roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) --AND Enabled = 1 
		AND custid <= @maxcustid 

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
			INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.CustID = ci.custid
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
			INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.AgentID = ci.custid
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

	--BetLimit	
	IF EXISTS(SELECT TOP 1 1 FROM #ProductSettingDetail WHERE SettingType IN (2,9,16,20))
	BEGIN
		CREATE TABLE #CustBetSetting3rd_Agent(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype ))
		CREATE TABLE #CustBetSetting3rd_Member(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype))

		CREATE TABLE #CustBetSetting3rd_AgentTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype))
		CREATE TABLE #CustBetSetting3rd_MemberTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT,  
												PRIMARY KEY(CustID ,Sporttype ,Bettype))
		
		INSERT INTO #CustBetSetting3rd_Agent(CustID, SportType, BetType)
		SELECT a.CustID, a.SportType, a.BetType
		FROM CustBetSetting3rd_Agent a WITH(NOLOCK)
			INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.CustID = ci.custid
		WHERE t.SettingType IN (2,9,16,20)
		
		INSERT INTO #CustBetSetting3rd_Member(CustID, SportType, BetType)
		SELECT a.CustID, a.SportType, a.BetType
		FROM CustBetSetting3rd_Member a WITH(NOLOCK)
			INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #Member ci WITH(NOLOCK) ON a.CustID = ci.custid
		WHERE t.SettingType IN (2,9,16,20)

		WHILE EXISTS(SELECT TOP 1 1 FROM #CustBetSetting3rd_Agent)
		BEGIN
			DELETE TOP (@batch) #CustBetSetting3rd_Agent OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
			INTO #CustBetSetting3rd_AgentTemp(CustID, SportType, BetType)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.CustBetSetting3rd_Agent cg WITH(ROWLOCK)		
				INNER JOIN #CustBetSetting3rd_AgentTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

			TRUNCATE TABLE #CustBetSetting3rd_AgentTemp
		END
	
		WHILE EXISTS(SELECT TOP 1 1 FROM #CustBetSetting3rd_Member)
		BEGIN
			DELETE TOP (@batch) #CustBetSetting3rd_Member OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
			INTO #CustBetSetting3rd_MemberTemp(CustID, SportType, BetType)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.CustBetSetting3rd_Member cg WITH(ROWLOCK)		
				INNER JOIN #CustBetSetting3rd_MemberTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

			TRUNCATE TABLE #CustBetSetting3rd_MemberTemp
		END

		DROP TABLE #CustBetSetting3rd_Agent
		DROP TABLE #CustBetSetting3rd_Member
		DROP TABLE #CustBetSetting3rd_AgentTemp
		DROP TABLE #CustBetSetting3rd_MemberTemp
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
			INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.CustID = ci.custid
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
	
	DROP TABLE #ProductSettingDetail	
	DROP TABLE #Member
	DROP TABLE #SMATemp
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
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	INNER JOIN custinfo c WITH(NOLOCK) ON c.custid = ci.custid
WHERE ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.islicensee = 0
		AND ci.custid <= @max_custid
		--AND c.Enabled = 1

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
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
			
	waitfor delay '00:00:0.100'
END
DROP TABLE #supers
GO
