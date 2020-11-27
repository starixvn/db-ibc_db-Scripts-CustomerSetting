/*
	Created: 20201127@Tina
	Task: Delete existing data of Big Gaming_UUS [Redmine: #144105]
	DB: DBCUST/CustDB
	
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
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN	
	IF dbo.f_CheckRepTable('site') = 0 RETURN
	IF dbo.f_CheckRepTable('customer') = 0 RETURN	
	IF dbo.f_CheckRepTable('custsuper') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_CustSuper') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN

	DECLARE @Sporttype SMALLINT 
	CREATE TABLE #supers (custid INT)
	CREATE TABLE #CustStakeLevel_AgentTemp(custid INT)
	CREATE TABLE #CustStakeLevel_MemberTemp(custid INT)
	CREATE TABLE #CustPTSetting3rd_AgentTemp(custid INT)
	CREATE TABLE #CustPTSetting3rd_MemberTemp(custid INT)
	CREATE TABLE #CustPTGroupSetting3rd_MemberTemp(AgentID INT)
	CREATE TABLE #CustDiscount3rd_MemberTemp(custid INT)
	CREATE TABLE #CustDiscount3rd_AgentTemp(custid INT)
	CREATE TABLE #CustWinLossLimit_AgentTemp(custid INT)
	CREATE TABLE #CustWinLossLimit_MemberTemp(custid INT)

	SELECT @Sporttype = 236

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
		AND ci.Site<>'CN88'
		AND ci.currency IN (20,72) -- UUS, YNG



	SELECT DISTINCT cg.custid 
	INTO #CustStakeLevel_Agent
	FROM dbo.CustStakeLevel_Agent cg WITH(NOLOCK)	
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID	
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype

	SELECT DISTINCT cg.custid 
	INTO #CustStakeLevel_Member
	FROM dbo.CustStakeLevel_Member cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype	

	SELECT DISTINCT cg.custid 
	INTO #CustPTSetting3rd_Agent
	FROM dbo.CustPTSetting3rd_Agent cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype

	SELECT DISTINCT cg.custid 
	INTO #CustPTSetting3rd_Member
	FROM dbo.CustPTSetting3rd_Member cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype

	SELECT DISTINCT cg.AgentID
	INTO #CustPTGroupSetting3rd_Member
	FROM dbo.CustPTGroupSetting3rd_Member cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.AgentID
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype

	SELECT DISTINCT cg.CustID
	INTO #CustDiscount3rd_Member
	FROM dbo.CustDiscount3rd_Member cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype

	SELECT DISTINCT cg.CustID
	INTO #CustDiscount3rd_Agent
	FROM dbo.CustDiscount3rd_Agent cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype

	SELECT DISTINCT cg.CustID
	INTO #CustWinLossLimit_Agent
	FROM dbo.CustWinLossLimit_Agent cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype

	SELECT DISTINCT cg.CustID
	INTO #CustWinLossLimit_Member
	FROM dbo.CustWinLossLimit_Member cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype

	WHILE EXISTS(SELECT TOP 1 1 FROM #CustStakeLevel_Agent)
	BEGIN
		DELETE TOP (3000) #CustStakeLevel_Agent OUTPUT DELETED.* INTO #CustStakeLevel_AgentTemp

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.CustStakeLevel_Agent cg WITH(ROWLOCK)		
			INNER JOIN #CustStakeLevel_AgentTemp ci ON ci.custid = cg.CustID	
		WHERE SportType = @Sporttype

		TRUNCATE TABLE #CustStakeLevel_AgentTemp
	END

	WHILE EXISTS(SELECT TOP 1 1 FROM #CustStakeLevel_Member)
	BEGIN
		DELETE TOP (3000) #CustStakeLevel_Member OUTPUT DELETED.* INTO #CustStakeLevel_MemberTemp

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.CustStakeLevel_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustStakeLevel_MemberTemp ci ON ci.custid = cg.CustID	
		WHERE SportType = @Sporttype

		TRUNCATE TABLE #CustStakeLevel_MemberTemp
	END	

	WHILE EXISTS(SELECT TOP 1 1 FROM #CustPTSetting3rd_Agent)
	BEGIN
		DELETE TOP (3000) #CustPTSetting3rd_Agent OUTPUT DELETED.* INTO #CustPTSetting3rd_AgentTemp

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.CustPTSetting3rd_Agent cg WITH(ROWLOCK)		
			INNER JOIN #CustPTSetting3rd_AgentTemp ci ON ci.custid = cg.CustID	
		WHERE SportType = @Sporttype

		TRUNCATE TABLE #CustPTSetting3rd_AgentTemp
	END
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #CustPTSetting3rd_Member)
	BEGIN
		DELETE TOP (3000) #CustPTSetting3rd_Member OUTPUT DELETED.* INTO #CustPTSetting3rd_MemberTemp

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.CustPTSetting3rd_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustPTSetting3rd_MemberTemp ci ON ci.custid = cg.CustID	
		WHERE SportType = @Sporttype

		TRUNCATE TABLE #CustPTSetting3rd_MemberTemp
	END
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #CustPTGroupSetting3rd_Member)
	BEGIN
		DELETE TOP (3000) #CustPTGroupSetting3rd_Member OUTPUT DELETED.* INTO #CustPTGroupSetting3rd_MemberTemp

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.CustPTGroupSetting3rd_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustPTGroupSetting3rd_MemberTemp ci ON ci.AgentID = cg.AgentID	
		WHERE SportType = @Sporttype

		TRUNCATE TABLE #CustPTGroupSetting3rd_MemberTemp
	END
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #CustDiscount3rd_Member)
	BEGIN
		DELETE TOP (3000) #CustDiscount3rd_Member OUTPUT DELETED.* INTO #CustDiscount3rd_MemberTemp

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.CustDiscount3rd_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustDiscount3rd_MemberTemp ci ON ci.custid = cg.CustID	
		WHERE SportType = @Sporttype

		TRUNCATE TABLE #CustDiscount3rd_MemberTemp
	END

	WHILE EXISTS(SELECT TOP 1 1 FROM #CustDiscount3rd_Agent)
	BEGIN
		DELETE TOP (3000) #CustDiscount3rd_Agent OUTPUT DELETED.* INTO #CustDiscount3rd_AgentTemp

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.CustDiscount3rd_Agent cg WITH(ROWLOCK)		
			INNER JOIN #CustDiscount3rd_AgentTemp ci ON ci.custid = cg.CustID	
		WHERE SportType = @Sporttype

		TRUNCATE TABLE #CustDiscount3rd_AgentTemp
	END

	WHILE EXISTS(SELECT TOP 1 1 FROM #CustWinLossLimit_Agent)
	BEGIN
		DELETE TOP (3000) #CustWinLossLimit_Agent OUTPUT DELETED.* INTO #CustWinLossLimit_AgentTemp

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.CustWinLossLimit_Agent cg WITH(ROWLOCK)		
			INNER JOIN #CustWinLossLimit_AgentTemp ci ON ci.custid = cg.CustID	
		WHERE SportType = @Sporttype

		TRUNCATE TABLE #CustWinLossLimit_AgentTemp
	END

	WHILE EXISTS(SELECT TOP 1 1 FROM #CustWinLossLimit_Member)
	BEGIN
		DELETE TOP (3000) #CustWinLossLimit_Member OUTPUT DELETED.* INTO #CustWinLossLimit_MemberTemp

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.CustWinLossLimit_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustWinLossLimit_MemberTemp ci ON ci.custid = cg.CustID	
		WHERE SportType = @Sporttype

		TRUNCATE TABLE #CustWinLossLimit_MemberTemp
	END
	
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = 'REPLICATED'


-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = 'DBCUST'

