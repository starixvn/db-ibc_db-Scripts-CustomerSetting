/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 20221228
	Task: Macau Games - Remove commission [#RM:174513]
	DB: DBCUST/CustDB And all subscriber of CustDB_Custsetting Publication
*/
 
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@srecommend INT
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('site') = 0 RETURN
	IF dbo.f_CheckRepTable('customer') = 0 RETURN	
	IF dbo.f_CheckRepTable('custsuper') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_CustSuper') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 0 RETURN			

	DECLARE @Sporttype SMALLINT = 212,@bettype SMALLINT = 4001
	
	CREATE TABLE #Member (CustID INT PRIMARY KEY CLUSTERED, isfinished BIT DEFAULT(0) )
	CREATE TABLE #SMATemp (	CustID INT PRIMARY KEY CLUSTERED, roleid TINYINT, isfinished BIT DEFAULT(0))
	CREATE TABLE #MemberTemp (CustID INT PRIMARY KEY)
	CREATE TABLE #SMATempNew (CustID INT PRIMARY KEY)

	INSERT INTO #Member (CustID  )
	SELECT custid 
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1  AND custid <= @maxcustid
	
	INSERT INTO #SMATemp (CustID, roleid)
	SELECT custid, roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND custid <= @maxcustid 
		
	DECLARE @batch INT = 3000	
	--PositionTaking
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
		INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.CustID = ci.custid
	WHERE a.SportType = @Sporttype and a.BetType = @bettype
		
	INSERT INTO #CustPTSetting3rd_Member(CustID, SportType, BetType, IsLive)
	SELECT a.CustID, a.SportType, a.BetType, a.IsLive
	FROM CustPTSetting3rd_Member a WITH(NOLOCK)
		INNER JOIN #Member ci WITH(NOLOCK) ON a.CustID = ci.custid
	WHERE a.SportType = @Sporttype and a.BetType = @bettype

	INSERT INTO #CustPTGroupSetting3rd_Member(AgentID, SportType, BetType, IsLive)
	SELECT a.AgentID, a.SportType, a.BetType, a.IsLive
	FROM CustPTGroupSetting3rd_Member a WITH(NOLOCK)
		INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.AgentID = ci.custid
	WHERE a.SportType = @Sporttype and a.BetType = @bettype AND ci.roleid = 2
		
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

	--Commission	
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
		INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.CustID = ci.custid
	WHERE a.SportType = @Sporttype and a.BetType = @bettype
		
	INSERT INTO #CustDiscount3rd_Member(CustID, SportType, BetType)
	SELECT a.CustID, a.SportType, a.BetType
	FROM CustDiscount3rd_Member a WITH(NOLOCK)
		INNER JOIN #Member ci WITH(NOLOCK) ON a.CustID = ci.custid
	WHERE a.SportType = @Sporttype and a.BetType = @bettype

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

	--Win Loss Limit
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
		INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.CustID = ci.custid
	WHERE a.SportType = @Sporttype and a.BetType = @bettype
		
	INSERT INTO #CustWinLossLimit_Member(CustID, SportType, BetType)
	SELECT a.CustID, a.SportType, a.BetType
	FROM CustWinLossLimit_Member a WITH(NOLOCK)
		INNER JOIN #Member ci WITH(NOLOCK) ON a.CustID = ci.custid
	WHERE a.SportType = @Sporttype and a.BetType = @bettype

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
	
	DROP TABLE #Member
	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
	DROP TABLE #SMATempNew
	DROP TABLE #CustWinLossLimit_Agent
	DROP TABLE #CustWinLossLimit_Member
	DROP TABLE #CustWinLossLimit_AgentTemp
	DROP TABLE #CustWinLossLimit_MemberTemp
	DROP TABLE #CustDiscount3rd_Agent
	DROP TABLE #CustDiscount3rd_Member
	DROP TABLE #CustDiscount3rd_AgentTemp
	DROP TABLE #CustDiscount3rd_MemberTemp
	DROP TABLE #CustPTSetting3rd_Agent
	DROP TABLE #CustPTSetting3rd_Member
	DROP TABLE #CustPTGroupSetting3rd_Member
	DROP TABLE #CustPTSetting3rd_AgentTemp
	DROP TABLE #CustPTSetting3rd_MemberTemp
	DROP TABLE #CustPTGroupSetting3rd_MemberTemp
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS AND DBCUST(run finally)
--------------------------------------------------------------------------------------
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;
CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
BEGIN
	SET @target = 'DBCUST'
	DELETE cg FROM dbo.ProductStatusSiteCurrency cg WITH(ROWLOCK) WHERE SportType = 212 AND BetType = 4001	
	DELETE cg FROM dbo.SportNonOfferedSiteCurrency cg WITH(ROWLOCK) WHERE SportType = 212 AND BetType = 4001	
END
ELSE 
BEGIN	
	SET @target = 'REPLICATED'
END

Print 'Server Name : ' + @target

DECLARE @max_custid INT, @srecommend INT
SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.islicensee = 0
		AND ci.custid <= @max_custid
		
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

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = @target
			
	WAITFOR DELAY '00:00:0.100'
END

PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

