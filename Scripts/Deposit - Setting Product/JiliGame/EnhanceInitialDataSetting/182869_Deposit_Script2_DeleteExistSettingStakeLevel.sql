/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Helios@20230308
	Task: Delete Exist Setting StakeLevel for Jili Game [RM:#181791]
	DB: DBCUST/CUSTDB

	Revisions:
		- 20230308@Helios: Insert new Product profile for Jili Games [redmine:#182869]
*/
--ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
DECLARE
	@target VARCHAR(20)

--AS
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
		
	DECLARE @Sporttype SMALLINT  = 158  -- Changed SportType JiliGame
	
	IF OBJECT_ID('tempdb..#tmp_Exchange') IS NOT NULL
    DROP TABLE #tmp_Exchange ;  

	SELECT ExchangeId , currency 
	INTO #tmp_Exchange
	FROM exchange WITH (NOLOCK) WHERE currency IN ('RM','TB','US$','USDT','UUS','PE')  -- ALL Currency approved for JiliGame Deposit PRO & LOCAL


	CREATE TABLE #supers (custid INT)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM customer ci WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
		LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE 
		ci.roleid = 4  AND 
		ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM CustSuper WITH(NOLOCK))
		AND s.islicensee = 1			
		AND ci.currency IN  (SELECT ExchangeId FROM #tmp_Exchange ) 

	select * from #supers

	SELECT DISTINCT cg.custid 
	INTO #Dep_CustStakeLevel_Agent
	FROM dbo.Dep_CustStakeLevel_Agent cg WITH(NOLOCK)	
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID	
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype and BetType = 5100

	SELECT DISTINCT cg.custid 
	INTO #Dep_CustStakeLevel_Member
	FROM dbo.Dep_CustStakeLevel_Member cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype and BetType = 5100	

	SELECT cg.*
	--DELETE cg
	FROM dbo.Dep_CustStakeLevel_Agent cg WITH(ROWLOCK)		
		INNER JOIN #Dep_CustStakeLevel_Agent ci ON ci.custid = cg.CustID	
	WHERE SportType = @Sporttype and BetType = 5100

	SELECT cg.*
	--DELETE cg
	FROM dbo.Dep_CustStakeLevel_Member cg WITH(ROWLOCK)		
		INNER JOIN #Dep_CustStakeLevel_Member ci ON ci.custid = cg.CustID	
	WHERE SportType = @Sporttype and BetType = 5100


	DROP TABLE #supers
	DROP TABLE #Dep_CustStakeLevel_Agent
	DROP TABLE #Dep_CustStakeLevel_Member
END	
GO
 --END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
----------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
--EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = 'REPLICATED'


---- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
----------------------------------------------------------------------------------------
--EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = 'DBCUST'

		