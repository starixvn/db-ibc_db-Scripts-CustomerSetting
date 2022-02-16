/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211227@Eden
	Task: Delete Existing Setting of Saba Casino - Real Currency [#164280]
	DB: DBCUST/CustDB and all subscriber of CustDB_custseting Pub
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('site') = 0 RETURN
	IF dbo.f_CheckRepTable('customer') = 0 RETURN	
	IF dbo.f_CheckRepTable('custsuper') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_CustSuper') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN

	DECLARE @Sporttype SMALLINT  = 208
		,@betType SMALLINT = 2101
		,@BatchNum INT = 5000
	
	IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;
	
	CREATE TABLE #supers (custid INT)
	CREATE TABLE #CustTempBatch(custid INT)


	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM customer ci WITH (NOLOCK) 
		INNER JOIN custinfo c WITH(NOLOCK) ON ci.custid = c.custid
		INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
		LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.islicensee = 0
		and c.Enabled = 1			
		AND ci.Site <> 'CN88'
		AND ci.currency IN (
					2	-- 	RM
				,	3	-- 	US$
				,	5	-- 	HK$
				,	6	-- 	EURO
				,	10	-- 	INR1
				,	13	-- 	RMB
				,	15	-- 	IN
				,	16	-- 	Yen
				,	22	-- 	IND
				,	33	-- 	IDD
				,	34	-- 	IDR
				,	35	-- 	$US
				,	43	-- 	THB
				,	45	-- 	WON
				,	47	-- 	DDD
				,	64	-- 	UT
				,	67	-- 	HKK
				,	69	-- 	MMK
				,	95	-- 	USD
					)
	
	--PT
	SELECT DISTINCT cg.custid 
	INTO #CustPTSetting3rd_Agent
	FROM dbo.CustPTSetting3rd_Agent cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype AND BetType = @betType

	SELECT DISTINCT cg.custid 
	INTO #CustPTSetting3rd_Member
	FROM dbo.CustPTSetting3rd_Member cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype AND BetType = @betType

	SELECT DISTINCT cg.AgentID
	INTO #CustPTGroupSetting3rd_Member
	FROM dbo.CustPTGroupSetting3rd_Member cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.AgentID
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype AND BetType = @betType

	--Stake Level
	SELECT DISTINCT cg.CustID
	INTO #CustStakeLevel_Agent
	FROM dbo.CustStakeLevel_Agent cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype AND BetType = @betType

	SELECT DISTINCT cg.CustID
	INTO #CustStakeLevel_Member
	FROM dbo.CustStakeLevel_Member cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype AND BetType = @betType

	--> Winloss Limit
	SELECT DISTINCT cg.CustID
	INTO #CustWinLossLimit_Agent
	FROM dbo.CustWinLossLimit_Agent cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype AND BetType = @betType

	SELECT DISTINCT cg.CustID
	INTO #CustWinLossLimit_Member
	FROM dbo.CustWinLossLimit_Member cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype AND BetType = @betType

	--PT
	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #CustPTSetting3rd_Agent 
		OUTPUT DELETED.CustID INTO #CustTempBatch(CustID)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.CustPTSetting3rd_Agent cg WITH(ROWLOCK)		
			INNER JOIN #CustTempBatch ci ON ci.custid = cg.CustID	
		WHERE SportType = @Sporttype AND BetType = @betType

		TRUNCATE TABLE #CustTempBatch
	END

	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #CustPTSetting3rd_Member 
		OUTPUT DELETED.CustID INTO #CustTempBatch(CustID)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.CustPTSetting3rd_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustTempBatch ci ON ci.custid = cg.CustID	
		WHERE SportType = @Sporttype AND BetType = @betType

		TRUNCATE TABLE #CustTempBatch
	END
	
	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #CustPTGroupSetting3rd_Member 
		OUTPUT DELETED.AgentID INTO #CustTempBatch(CustID)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.CustPTGroupSetting3rd_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustTempBatch ci ON ci.custid = cg.AgentID	
		WHERE SportType = @Sporttype AND BetType = @betType

		TRUNCATE TABLE #CustTempBatch
	END
	
	--Stake Level
	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #CustStakeLevel_Agent 
		OUTPUT DELETED.CustID INTO #CustTempBatch(CustID)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.CustStakeLevel_Agent cg WITH(ROWLOCK)		
			INNER JOIN #CustTempBatch ci ON ci.custid = cg.CustID	
		WHERE SportType = @Sporttype AND BetType = @betType

		TRUNCATE TABLE #CustTempBatch
	END

	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #CustStakeLevel_Member 
		OUTPUT DELETED.CustID INTO #CustTempBatch(CustID)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.CustStakeLevel_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustTempBatch ci ON ci.custid = cg.CustID	
		WHERE SportType = @Sporttype AND BetType = @betType

		TRUNCATE TABLE #CustTempBatch
	END

	--Winloss limit
	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #CustWinLossLimit_Agent 
		OUTPUT DELETED.CustID INTO #CustTempBatch(CustID)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.CustWinLossLimit_Agent cg WITH(ROWLOCK)		
			INNER JOIN #CustTempBatch ci ON ci.custid = cg.CustID	
		WHERE SportType = @Sporttype AND BetType = @betType

		TRUNCATE TABLE #CustTempBatch
	END

	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #CustWinLossLimit_Member 
		OUTPUT DELETED.CustID INTO #CustTempBatch(CustID)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.CustWinLossLimit_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustTempBatch ci ON ci.custid = cg.CustID	
		WHERE SportType = @Sporttype AND BetType = @betType

		TRUNCATE TABLE #CustTempBatch
	END

	DROP TABLE #CustPTGroupSetting3rd_Member
	DROP TABLE #CustPTSetting3rd_Agent
	DROP TABLE #CustPTSetting3rd_Member
	DROP TABLE #CustStakeLevel_Agent
	DROP TABLE #CustStakeLevel_Member
	DROP TABLE #CustWinLossLimit_Agent
	DROP TABLE #CustWinLossLimit_Member
	DROP TABLE #CustTempBatch
	DROP TABLE #supers
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS AND DBCUST -----
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = @target
