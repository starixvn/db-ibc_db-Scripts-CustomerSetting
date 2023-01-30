/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20221205
	Created: Johnson 
	Task: Seal Entertainment - Incorporate to Licensee Sites for real licensees [redmine : #180380]
	DB: DBCUST/CUSTDB
*/

ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	@target VARCHAR(20)	
AS
BEGIN	
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbtrans only
	
	IF (dbo.f_CheckRepTable('Dep_CustSettingMode') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0
		
		OR dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 
		
		OR dbo.f_CheckRepTable('CustInfo') = 0 
		OR dbo.f_CheckRepTable('Customer') = 0 
		OR dbo.f_CheckRepTable('site') = 0 

		OR dbo.f_CheckRepTable('Dep_CustStakeLevel_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustStakeLevel_Member') = 0 		
	   )
		RETURN
		
	CREATE TABLE #supers (custid int, currency int, isfinished bit default(0))
	DECLARE @sporttype SMALLINT = 156, @BetType SMALLINT = 8900
	
	INSERT INTO #supers(custid, currency)
	SELECT c.custid, c.currency
	FROM customer c WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
		INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
	WHERE c.roleid = 4  
		AND s.islicensee = 1
		AND ci.Enabled = 1		
		AND c.custid IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK)
						WHERE currency IN (2,3,4,6,12,13,15,20,32,45,46,49,51,61,70,82,96,97,121,123))
		AND ((s.site IN ('spondemo','Athena000','SampleSite') AND c.currency <> 20)
			OR s.site NOT IN ('spondemo','Athena000','SampleSite')
			)
		
	DELETE Dep_LicenseeProductSetting WITH(ROWLOCK)
	WHERE custid IN (SELECT custid FROM #supers)
		AND ProductSettingID IN (159,160,161)
	
	DELETE Dep_CustPTSetting_Agent WITH(ROWLOCK)
	WHERE custid IN (SELECT custid FROM custinfo WITH(NOLOCK)
					WHERE srecommend IN (SELECT custid FROM #supers)
						AND roleid IN (2,3,4)
					)
		AND sporttype = @sporttype
		AND bettype = @bettype
		
	DELETE Dep_CustPTGroupSetting_Member WITH(ROWLOCK)
	WHERE AgentID IN (SELECT custid FROM custinfo WITH(NOLOCK)
					WHERE srecommend IN (SELECT custid FROM #supers)
						AND roleid = 2
					)
		AND sporttype = @sporttype
		AND bettype = @bettype	
		
	DELETE Dep_CustPTSetting_Member WITH(ROWLOCK)
	WHERE custid IN (SELECT custid FROM custinfo WITH(NOLOCK)
					WHERE srecommend IN (SELECT custid FROM #supers)
						AND roleid = 1
					)
		AND sporttype = @sporttype
		AND bettype = @bettype

	DELETE Dep_CustStakeLevel_Agent WITH(ROWLOCK)
	WHERE custid IN (SELECT custid FROM custinfo WITH(NOLOCK)
					WHERE srecommend IN (SELECT custid FROM #supers)
						AND roleid IN (2,3,4)
					)
		AND sporttype = @sporttype
		AND bettype = @bettype	
		
	DELETE Dep_CustStakeLevel_Member WITH(ROWLOCK)
	WHERE custid IN (SELECT custid FROM custinfo WITH(NOLOCK)
					WHERE srecommend IN (SELECT custid FROM #supers)
						AND roleid = 1
					)
		AND sporttype = @sporttype
		AND bettype = @bettype	
		
	DROP TABLE #supers
END		
GO


------------------------------------------------------	
-- BEGIN STEP 2: Initial settings
--------------------------------------------------------------------------------------
SET NOCOUNT ON
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

DECLARE @target VARCHAR(20)
	
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

EXEC Acc_Dep_DynamicCustSetting_09 @target = @target

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

GO
