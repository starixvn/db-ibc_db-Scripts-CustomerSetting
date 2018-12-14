/*
	Created: Winnie
	Date: 20181011
	Task: Delete existing data of Deposit Esports
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

	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 RETURN		
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN		

	CREATE TABLE #supers (custid INT)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'			
		AND ci.Enabled=1
		AND cs.site IN ('368Cash','Abcasino','Aoncash','e8casino','Arlocash')

	IF EXISTS(SELECT 1 FROM Dep_CustPTSetting_Agent cg 		
		 INNER JOIN Customer c WITH(NOLOCK) ON c.custid=cg.CustID
		WHERE SportType =43 AND c.srecommend IN (SELECT custid FROM #supers))
	BEGIN
		DELETE cg
		FROM Dep_CustPTSetting_Agent cg 		
		 INNER JOIN Customer c WITH(NOLOCK) ON c.custid=cg.CustID
		WHERE SportType =43 AND c.srecommend IN (SELECT custid FROM #supers)
	END
	
	IF EXISTS(SELECT 1 FROM Dep_CustPTSetting_Member cg
			INNER JOIN Customer c WITH(NOLOCK) ON c.custid=cg.CustID
		WHERE c.srecommend IN (SELECT custid FROM #supers))		
	BEGIN				
		DELETE cg
		FROM Dep_CustPTSetting_Member cg
			INNER JOIN Customer c WITH(NOLOCK) ON c.custid=cg.CustID
		WHERE c.srecommend IN (SELECT custid FROM #supers)
	END

	IF EXISTS(SELECT 1 	FROM Dep_CustPTGroupSetting_Member cg 
		INNER JOIN Customer c WITH(NOLOCK) ON c.custid=cg.AgentID
	WHERE SportType  =43 
		AND c.srecommend IN (SELECT custid FROM #supers))
	BEGIN		
		DELETE cg
		FROM Dep_CustPTGroupSetting_Member cg 
			INNER JOIN Customer c WITH(NOLOCK) ON c.custid=cg.AgentID
		WHERE SportType  =43 
			AND c.srecommend IN (SELECT custid FROM #supers) 	
	END
		
	IF EXISTS(SELECT 1 	FROM Dep_CustBetSetting_Agent cg
		INNER JOIN Customer c WITH(NOLOCK) ON c.custid=cg.CustID
	WHERE SportType  =43  AND c.srecommend IN (SELECT custid FROM #supers))
	BEGIN				
		DELETE cg
		FROM Dep_CustBetSetting_Agent cg
			INNER JOIN Customer c WITH(NOLOCK) ON c.custid=cg.CustID
		WHERE SportType  =43  AND c.srecommend IN (SELECT custid FROM #supers)		
	END

	IF EXISTS(SELECT 1 FROM Dep_CustBetSetting_Member cg	
			INNER JOIN Customer c WITH(NOLOCK) ON c.custid=cg.CustID
		WHERE SportType  =43 AND c.srecommend IN (SELECT custid FROM #supers)	 )
	BEGIN
		DELETE cg
		FROM Dep_CustBetSetting_Member cg	
			INNER JOIN Customer c WITH(NOLOCK) ON c.custid=cg.CustID
		WHERE SportType  =43 AND c.srecommend IN (SELECT custid FROM #supers)	
		OPTION(MAXDOP 1)	 		
	END

	DELETE cg
	FROM Dep_LicenseeProductSetting cg 		
	WHERE ProductSettingID IN(24,25)
	 AND cg.CustID NOT IN (SELECT custid FROM #supers)	
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
EXEC Acc_DynamicCustSetting3rd_09 @target = 'REPLICATED'

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
EXEC Acc_DynamicCustSetting3rd_09 @target = 'DBCUST'
