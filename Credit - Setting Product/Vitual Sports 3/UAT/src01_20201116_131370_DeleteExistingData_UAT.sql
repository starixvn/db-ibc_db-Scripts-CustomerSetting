/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20201116
	Task: Delete existing data of Leap Gaming Virtual Sports - UAT [RedmineID:#131370]
	DB: DBCust/CustDB
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
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN	

	DECLARE @Sporttype SMALLINT ,@betType SMALLINT
	CREATE TABLE #supers (custid INT)

	SELECT @Sporttype = 231 , @betType = 5301 

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
		AND ci.Site NOT IN ('CN88')
		AND ci.currency IN (20,72)

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

	SELECT DISTINCT cg.custid 
	INTO #CustBetSetting3rd_Agent 
	FROM dbo.CustBetSetting3rd_Agent  cg WITH(NOLOCK)	
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID	
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype AND BetType = @betType

	SELECT DISTINCT cg.custid 
	INTO #CustBetSetting3rd_Member 
	FROM dbo.CustBetSetting3rd_Member cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype AND BetType = @betType

	DELETE cg
	FROM dbo.CustPTSetting3rd_Agent cg WITH(ROWLOCK)		
		INNER JOIN #CustPTSetting3rd_Agent ci ON ci.custid = cg.CustID	
	WHERE SportType = @Sporttype AND BetType = @betType

	DELETE cg
	FROM dbo.CustPTSetting3rd_Member cg WITH(ROWLOCK)		
		INNER JOIN #CustPTSetting3rd_Member ci ON ci.custid = cg.CustID	
	WHERE SportType = @Sporttype AND BetType = @betType

	DELETE cg
	FROM dbo.CustPTGroupSetting3rd_Member cg WITH(ROWLOCK)		
		INNER JOIN #CustPTGroupSetting3rd_Member ci ON ci.AgentID = cg.AgentID	
	WHERE SportType = @Sporttype AND BetType = @betType

	DELETE cg
	FROM dbo.CustBetSetting3rd_Agent  cg WITH(ROWLOCK)		
		INNER JOIN #CustBetSetting3rd_Agent  ci ON ci.custid = cg.CustID	
	WHERE SportType = @Sporttype AND BetType = @betType

	DELETE cg
	FROM dbo.CustBetSetting3rd_Member cg WITH(ROWLOCK)		
		INNER JOIN #CustBetSetting3rd_Member ci ON ci.custid = cg.CustID	
	WHERE SportType = @Sporttype AND BetType = @betType

END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = 'REPLICATED'
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = 'DBCUST'
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

