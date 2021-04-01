/*
	Created: 20210224@Tina
	Task: Delete existing data of StakeLevelGroupDetail for Habanero - Credit - UUS
	Redmine: https://nexdev.net/issues/145459
	DB: DBCUST/CustDB
*/

USE CustDB
GO

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@target VARCHAR(20)

AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('StakeLevel') = 1
	   AND dbo.f_CheckRepTable('StakeLevelGroupDetail') = 1
	   AND dbo.f_CheckRepTable('CustStakeLevel_Agent') = 1
	   AND dbo.f_CheckRepTable('CustStakeLevel_Member') = 1
	   )
		RETURN
		
	DECLARE @Sporttype SMALLINT 
	CREATE TABLE #supers (custid INT)
	CREATE TABLE #CustStakeLevel_AgentTemp(custid INT)
	CREATE TABLE #CustStakeLevel_MemberTemp(custid INT)

	SELECT @Sporttype = 238

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
		AND ci.currency IN (20,72) --Test Currency


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

END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
PRINT N'Step 3: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = 'REPLICATED'
PRINT N'Step 3: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 3: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = 'DBCUST'
PRINT N'Step 3: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
		