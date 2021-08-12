/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Winfred
	Date: 20210518
	Task: Delete existing data of Parlay Max Payout [Redmine: 154104]
	DB: DBCUST/CustDB
	
	P/s : Step 1 Delete existing data
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
	IF dbo.f_CheckRepTable('MaxPayoutGlobalSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('CustMaxPayoutSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustMaxPayoutSetting_Member') = 0 RETURN

	IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;
	
	CREATE TABLE #supers (custid INT)
	
	CREATE TABLE #CustMaxPayoutSetting_AgentTemp(custid INT)
	CREATE TABLE #CustMaxPayoutSetting_MemberTemp(custid INT)

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
		AND ci.currency IN (2,3,5,6,7,9,12,13,15,16,22,33,34,35,41,43,45,47,50,51,52,53,54,57,58,64,67,69,71,81,95,20,72) 

	SELECT DISTINCT cg.custid 
	INTO #CustMaxPayoutSetting_Agent
	FROM dbo.CustMaxPayoutSetting_Agent cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE  BetType = 9 AND SportType in (1,99)
	
	SELECT DISTINCT cg.custid 
	INTO #CustMaxPayoutSetting_Member
	FROM dbo.CustMaxPayoutSetting_Member cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE  BetType = 9 AND SportType in (1,99)
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #CustMaxPayoutSetting_Agent)
	BEGIN
		DELETE TOP (3000) #CustMaxPayoutSetting_Agent OUTPUT DELETED.* INTO #CustMaxPayoutSetting_AgentTemp

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.CustMaxPayoutSetting_Agent cg WITH(ROWLOCK)		
			INNER JOIN #CustMaxPayoutSetting_AgentTemp ci ON ci.custid = cg.CustID	
		WHERE  BetType = 9 AND SportType in (1,99)

		TRUNCATE TABLE #CustMaxPayoutSetting_AgentTemp
	END
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #CustMaxPayoutSetting_Member)
	BEGIN
		DELETE TOP (3000) #CustMaxPayoutSetting_Member OUTPUT DELETED.* INTO #CustMaxPayoutSetting_MemberTemp

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.CustMaxPayoutSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustMaxPayoutSetting_MemberTemp ci ON ci.custid = cg.CustID	
		WHERE  BetType = 9 AND SportType in (1,99)

		TRUNCATE TABLE #CustMaxPayoutSetting_MemberTemp
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

