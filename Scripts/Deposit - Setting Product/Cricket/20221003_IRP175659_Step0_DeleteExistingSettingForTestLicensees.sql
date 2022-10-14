/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221003@Johnson
	Task: Initial setting for Cricket & Saba Cricket for Deposit customers [#RedmineID:#175659]
	DB: DBCUST/CustDB
*/ 

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	@target VARCHAR(20)	
AS
BEGIN	
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbtrans only
	
	IF (dbo.f_CheckRepTable('Dep_CustSettingMode') = 0
		
		OR dbo.f_CheckRepTable('Dep_CustBetSettingGame_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSettingGame_Member') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSettingGameGroup_Member') = 0
		OR dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0					
	   )
	RETURN
	
	CREATE TABLE #supers (custid int, isfinished bit default(0))

	INSERT INTO #supers(custid)
	SELECT c.custid
	FROM customer c WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
		INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
	WHERE c.roleid = 4  
		AND s.islicensee = 1
		AND ci.Enabled = 1		
		AND c.custid IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.site IN ('spondemo','Athena000','SampleSite') AND c.currency = 20
			
			
	DELETE Dep_LicenseeProductSetting WITH(ROWLOCK)
	WHERE custid IN (SELECT custid FROM #supers)
		AND ProductSettingID IN (154,155)
			
	DELETE Dep_CustBetSettingGame_Agent cs WITH(ROWLOCK)		
	WHERE custid IN (SELECT custid FROM custinfo (NOLOCK) 
					WHERE srecommend IN (SELECT custid FROM #supers)
					AND roleid IN (2,3,4))
		AND cs.sporttype IN (50,9907)
		AND cs.bettype = 1
	
	DELETE Dep_CustBetSettingGameGroup_Member cs WITH(ROWLOCK)		
	WHERE custid IN (SELECT custid FROM custinfo (NOLOCK) 
					WHERE srecommend IN (SELECT custid FROM #supers)
					AND roleid IN (2))
		AND cs.sporttype IN (50,9907)
		AND cs.bettype = 1	
	
	DELETE Dep_CustBetSettingGame_Member cs WITH(ROWLOCK)		
	WHERE custid IN (SELECT custid FROM custinfo (NOLOCK) 
					WHERE srecommend IN (SELECT custid FROM #supers)
					AND roleid = 1)
		AND cs.sporttype IN (50,9907)
		AND cs.bettype = 1
END
GO


DECLARE @target VARCHAR(20)
	
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

EXEC dbo.Acc_Dep_DynamicCustSetting_09 @target = @target