/*
	Created: 20200918@Winfred
	Task : Delete existing Comm for Myanmar Odds - UUS [Redmine: #141926]
	DB:  DBCUST/CustDB 
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
	IF dbo.f_CheckRepTable('CustCommRate') = 0 RETURN
	IF dbo.f_CheckRepTable('AgentCommRate') = 0 RETURN	
	IF dbo.f_CheckRepTable('site') = 0 RETURN
	IF dbo.f_CheckRepTable('customer') = 0 RETURN	
	IF dbo.f_CheckRepTable('custsuper') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_CustSuper') = 0 RETURN	

	DECLARE @Sporttype SMALLINT , @Bettype SMALLINT
	CREATE TABLE #supers (custid INT)

	SELECT @Sporttype = 1,@Bettype = 1

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
		AND ci.Site = '76666B'
		AND ci.currency IN (20) -- UUS


	SELECT DISTINCT cg.custid 
	INTO #AgentCommRate_Agent
	FROM dbo.AgentCommRate cg WITH(NOLOCK)	
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID	
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype AND Bettype = @Bettype

	SELECT DISTINCT cg.custid 
	INTO #CustCommRate_Member
	FROM dbo.CustCommRate cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype AND Bettype = @Bettype	

	DELETE cg
	FROM dbo.AgentCommRate cg WITH(ROWLOCK)		
		INNER JOIN #AgentCommRate_Agent ci ON ci.custid = cg.CustID	
	WHERE SportType = @Sporttype AND Bettype = @Bettype	

	DELETE cg
	FROM dbo.CustCommRate cg WITH(ROWLOCK)		
		INNER JOIN #CustCommRate_Member ci ON ci.custid = cg.CustID	
	WHERE SportType = @Sporttype AND Bettype = @Bettype	

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

