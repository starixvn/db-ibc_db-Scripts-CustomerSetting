/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 202209152
	Task: Macau Games - Remove commission [#RM:174513]
	DB: DBCUST/CustDB And all subscriber of CustDB_Custsetting Publication
*/
 
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@target VARCHAR(20)
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
	IF dbo.f_CheckRepTable('CustDiscount3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 0 RETURN			

	DECLARE @Sporttype SMALLINT = 171,@bettype SMALLINT = 4001
	CREATE TABLE #supers (custid INT)
	CREATE TABLE #CustDiscount3rd_AgentTemp(custid INT)
	CREATE TABLE #CustDiscount3rd_MemberTemp(custid INT)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM dbo.customer c WITH (NOLOCK) 
		INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
		INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
		INNER JOIN  dbo.custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
		INNER JOIN dbo.CustDiscount3rd_Agent cdis WITH (NOLOCK) ON cdis.CustID = c.custid AND cdis.sporttype = 212 AND cdis.bettype = 4001
	WHERE ci.roleid = 4
		AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))
		AND cs.isinternal = 0 	
		AND ci.Enabled = 1
		AND s.islicensee = 0
		AND c.username NOT LIKE '3rdSuper%'
		AND cdis.Discount <> 0
						
	SELECT DISTINCT cg.custid 
	INTO #CustDiscoun_Agent
	FROM CustDiscount3rd_Agent cg WITH(NOLOCK)	
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid	
	WHERE SportType = @Sporttype AND BetType = @BetType
		
	SELECT DISTINCT cg.CustID AS CustID
	INTO #CustDiscoun_Member
	FROM CustDiscount3rd_Member cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID	
		INNER JOIN #supers s ON ci.srecommend = s.custid	
	WHERE SportType = @Sporttype AND BetType = @BetType
	

	WHILE EXISTS(SELECT TOP 1 1 FROM #CustDiscoun_Agent)
	BEGIN
		DELETE TOP (3000) #CustDiscoun_Agent OUTPUT DELETED.* INTO #CustDiscount3rd_AgentTemp

		IF @@ROWCOUNT=0
			BREAK

		DELETE cg
		FROM CustDiscount3rd_Agent cg WITH(ROWLOCK)		
			INNER JOIN #CustDiscount3rd_AgentTemp ci ON ci.custid = cg.CustID
		WHERE SportType = @Sporttype  AND BetType = @BetType

		TRUNCATE TABLE #CustDiscount3rd_AgentTemp
	END

	WHILE EXISTS(SELECT TOP 1 1 FROM #CustDiscoun_Member)
	BEGIN
		DELETE TOP (3000) #CustDiscoun_Member OUTPUT DELETED.* INTO #CustDiscount3rd_MemberTemp

		IF @@ROWCOUNT=0
			BREAK	
							
		DELETE cg
		FROM CustPTSetting3rd_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustDiscount3rd_MemberTemp ci ON ci.custid = cg.CustID
		WHERE SportType = @Sporttype  AND BetType = @BetType

		TRUNCATE TABLE #CustDiscount3rd_MemberTemp
	END

	
	DROP TABLE #CustDiscoun_Member
	DROP TABLE #CustDiscount3rd_MemberTemp
	DROP TABLE #CustDiscoun_Agent
	DROP TABLE #CustDiscount3rd_AgentTemp
	DROP TABLE #supers
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

