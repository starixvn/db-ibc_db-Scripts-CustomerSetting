/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210426@Eden
	Task: Delete existing data of VGaming [#RM:153938]
	DB: DBCUST/CustDB And all subscriber of CustDB_Custsetting Publication
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
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN				

	DECLARE @Sporttype SMALLINT = 171
	CREATE TABLE #supers (custid INT)
	CREATE TABLE #CustPT_AgentTemp(custid INT)
	CREATE TABLE #CustPT_MemberTemp(custid INT)
	CREATE TABLE #CustPTGroup_MemberTemp(custid INT)
	CREATE TABLE #CustBet_AgentTemp(custid INT)
	CREATE TABLE #CustBet_MemberTemp(custid INT)
	CREATE TABLE #CustWinLoss_AgentTemp(custid INT)
	CREATE TABLE #CustWinLoss_MemberTemp(custid INT)

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
		AND ci.currency <> 20
		AND ci.site IN ('733333','722222','222223','222225')
		
	SELECT DISTINCT cg.custid 
	INTO #CustPT_Agent
	FROM CustPTSetting3rd_Agent cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype
						
	SELECT DISTINCT cg.custid 
	INTO #CustPT_Member
	FROM CustPTSetting3rd_Member cg WITH(NOLOCK)	
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid	
	WHERE SportType = @Sporttype
		
	SELECT DISTINCT cg.AgentID AS CustID
	INTO #CustPTGroup_Member
	FROM CustPTGroupSetting3rd_Member cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.AgentID	
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype
				
	SELECT DISTINCT cg.custid 
	INTO #CustBet_Agent
	FROM dbo.CustStakeLevel_Agent cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype

	SELECT DISTINCT cg.custid 
	INTO #CustBet_Member
	FROM dbo.CustStakeLevel_Member cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype

	SELECT DISTINCT cg.custid 
	INTO #CustWinLoss_Agent
	FROM dbo.CustWinLossLimit_Agent cg WITH(NOLOCK)	
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid	
	WHERE SportType = @Sporttype

	SELECT DISTINCT cg.custid 
	INTO #CustWinLoss_Member
	FROM dbo.CustWinLossLimit_Member cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype

	WHILE EXISTS(SELECT TOP 1 1 FROM #CustPT_Agent)
	BEGIN
		DELETE TOP (3000) #CustPT_Agent OUTPUT DELETED.* INTO #CustPT_AgentTemp

		IF @@ROWCOUNT=0
			BREAK

		DELETE cg
		FROM CustPTSetting3rd_Agent cg WITH(ROWLOCK)		
			INNER JOIN #CustPT_AgentTemp ci ON ci.custid = cg.CustID
		WHERE SportType = @Sporttype

		TRUNCATE TABLE #CustPT_AgentTemp
	END

	WHILE EXISTS(SELECT TOP 1 1 FROM #CustPT_Member)
	BEGIN
		DELETE TOP (3000) #CustPT_Member OUTPUT DELETED.* INTO #CustPT_MemberTemp

		IF @@ROWCOUNT=0
			BREAK	
							
		DELETE cg
		FROM CustPTSetting3rd_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustPT_MemberTemp ci ON ci.custid = cg.CustID
		WHERE SportType = @Sporttype

		TRUNCATE TABLE #CustPT_MemberTemp
	END

	WHILE EXISTS(SELECT TOP 1 1 FROM #CustPTGroup_Member)
	BEGIN
		DELETE TOP (3000) #CustPTGroup_Member OUTPUT DELETED.* INTO #CustPTGroup_MemberTemp

		IF @@ROWCOUNT=0
			BREAK	
			
		DELETE cg
		FROM CustPTGroupSetting3rd_Member cg WITH(ROWLOCK)	
			INNER JOIN #CustPTGroup_MemberTemp ci ON ci.CustID = cg.AgentID	
		WHERE SportType = @Sporttype
		
		TRUNCATE TABLE #CustPTGroup_MemberTemp
	END
		
	WHILE EXISTS(SELECT TOP 1 1 FROM #CustBet_Agent)
	BEGIN
		DELETE TOP (3000) #CustBet_Agent OUTPUT DELETED.* INTO #CustBet_AgentTemp

		IF @@ROWCOUNT=0
			BREAK	
						
		DELETE cg
		FROM dbo.CustStakeLevel_Agent cg WITH(ROWLOCK)
			INNER JOIN #CustBet_AgentTemp ci ON ci.custid = cg.CustID			
		WHERE SportType = @Sporttype
			
		TRUNCATE TABLE #CustBet_AgentTemp
	END

	WHILE EXISTS(SELECT TOP 1 1 FROM #CustBet_Member)
	BEGIN
		DELETE TOP (3000) #CustBet_Member OUTPUT DELETED.* INTO #CustBet_MemberTemp

		IF @@ROWCOUNT=0
			BREAK	
				
		DELETE cg
		FROM dbo.CustStakeLevel_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustBet_MemberTemp ci ON ci.custid = cg.CustID	
		WHERE SportType = @Sporttype
			
		TRUNCATE TABLE #CustBet_MemberTemp
	END

	WHILE EXISTS(SELECT TOP 1 1 FROM #CustWinLoss_Agent)
	BEGIN
		DELETE TOP (3000) #CustWinLoss_Agent OUTPUT DELETED.* INTO #CustWinLoss_AgentTemp

		IF @@ROWCOUNT=0
			BREAK	
				
		DELETE cg
		FROM dbo.CustWinLossLimit_Agent cg WITH(ROWLOCK)		
			INNER JOIN #CustWinLoss_AgentTemp ci ON ci.custid = cg.CustID	
		WHERE SportType = @Sporttype
			
		TRUNCATE TABLE #CustWinLoss_AgentTemp
	END

	WHILE EXISTS(SELECT TOP 1 1 FROM #CustWinLoss_Member)
	BEGIN
		DELETE TOP (3000) #CustWinLoss_Member OUTPUT DELETED.* INTO #CustWinLoss_MemberTemp

		IF @@ROWCOUNT=0
			BREAK	
			
		DELETE cg
		FROM dbo.CustWinLossLimit_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustWinLoss_MemberTemp ci ON ci.custid = cg.CustID	
		WHERE SportType = @Sporttype
			
		TRUNCATE TABLE #CustWinLoss_MemberTemp
	END

END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	


-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS AND DBCUST(run finally)
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = @target

PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

