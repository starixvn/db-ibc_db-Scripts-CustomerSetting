/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220106
	Task:  Delete existed setting SG Jackpot RedmineID:#165587
	DB: DBCust/CustDB
	P/s :  Step 1 delete existed setting SG Jackpot
*/

 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB-60\DEVDBCUST')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('site') = 0 RETURN
	IF dbo.f_CheckRepTable('customer') = 0 RETURN	
	IF dbo.f_CheckRepTable('custsuper') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_CustSuper') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN			

	DECLARE @Sporttype SMALLINT = 247, @Bettype INT = 4599
	CREATE TABLE #supers (custid INT)
	CREATE TABLE #CustPT_AgentTemp(custid INT)
	CREATE TABLE #CustPT_MemberTemp(custid INT)
	CREATE TABLE #CustPTGroup_MemberTemp(custid INT)

	DECLARE @ProductSettingID INT

	SELECT @ProductSettingID = p.ProductSettingID
	FROM Dep_ProductSettingDetail ps WITH (NOLOCK)
		INNER JOIN Dep_ProductSetting p WITH (NOLOCK) ON p.ProductSettingID = ps.ProductSettingID
	WHERE sporttype = @Sporttype AND SettingType = 1 AND bettype = @Bettype

	INSERT INTO #supers(custid)
	SELECT c.custid
	FROM custinfo c WITH (NOLOCK) 
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON c.custid = cs.custid
		INNER JOIN Dep_LicenseeProductSetting ls WITH (NOLOCK) ON c.custid = ls.custid
	WHERE c.roleid = 4  
		AND c.username NOT LIKE '3rdSuper%'
		AND c.Enabled = 1
		AND ls.ProductSettingID = @ProductSettingID
		AND ( cs.site NOT IN ('Athena000', 'Spondemo') OR ( c.currency NOT IN (20) AND cs.site IN ('Athena000', 'Spondemo')))
		
	SELECT DISTINCT cg.custid 
	INTO #CustPT_Agent
	FROM CustPTSetting3rd_Agent cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype AND BetType = @Bettype
						
	SELECT DISTINCT cg.custid 
	INTO #CustPT_Member
	FROM CustPTSetting3rd_Member cg WITH(NOLOCK)	
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid	
	WHERE SportType = @Sporttype AND BetType = @Bettype
		
	SELECT DISTINCT cg.AgentID AS CustID
	INTO #CustPTGroup_Member
	FROM CustPTGroupSetting3rd_Member cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.AgentID	
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype AND BetType = @Bettype

	WHILE EXISTS(SELECT TOP 1 1 FROM #CustPT_Agent)
	BEGIN
		DELETE TOP (3000) #CustPT_Agent OUTPUT DELETED.* INTO #CustPT_AgentTemp

		IF @@ROWCOUNT=0
			BREAK

		DELETE cg
		FROM CustPTSetting3rd_Agent cg WITH(ROWLOCK)		
			INNER JOIN #CustPT_AgentTemp ci ON ci.custid = cg.CustID
		WHERE SportType = @Sporttype AND BetType = @Bettype

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
		WHERE SportType = @Sporttype AND BetType = @Bettype

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
		WHERE SportType = @Sporttype AND BetType = @Bettype
		
		TRUNCATE TABLE #CustPTGroup_MemberTemp
	END

	DROP TABLE #CustPT_Agent
	DROP TABLE #CustPT_AgentTemp
	DROP TABLE #CustPT_Member
	DROP TABLE #CustPT_MemberTemp
	DROP TABLE #CustPTGroup_Member
	DROP TABLE #CustPTGroup_MemberTemp
	DROP TABLE #supers
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 3.2: RUN THIS SCRIPT AT REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
EXEC Acc_Dep_DynamicCustSetting_09 @target = 'REPLICATED'

-- BEGIN STEP 3.3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
EXEC Acc_Dep_DynamicCustSetting_09 @target = 'DBCUST'

