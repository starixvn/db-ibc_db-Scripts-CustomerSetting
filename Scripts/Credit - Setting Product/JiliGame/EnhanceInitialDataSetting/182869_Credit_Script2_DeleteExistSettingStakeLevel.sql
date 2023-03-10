/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Helios@20230308
	Task: Delete Exist Setting StakeLevel for Jili Game [RM:#181791]
	DB: DBCUST/CUSTDB

	Revisions:
		- 20230308@Helios: Insert new Product profile for Jili Games [redmine:#182869]
*/
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@target VARCHAR(20)

AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

-----Check Replicate	
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('StakeLevel') = 1
	   AND dbo.f_CheckRepTable('StakeLevelGroupDetail') = 1
	   AND dbo.f_CheckRepTable('CustStakeLevel_Agent') = 1
	   AND dbo.f_CheckRepTable('CustStakeLevel_Member') = 1
	   )
		RETURN
-----Collect Data Cust by Currency	
	DECLARE @Sporttype SMALLINT  = 158  -- Changed SportType JiliGame
	
	IF OBJECT_ID('tempdb..#tmp_Exchange') IS NOT NULL
    DROP TABLE #tmp_Exchange ;  

	SELECT ExchangeId , currency 
	INTO #tmp_Exchange
	FROM exchange WITH (NOLOCK) WHERE currency IN ('$US','HKK','RM','THB','US$','USD','USTM','UT','UUS','Yen')  -- ALL Currency approved for JiliGame Credit SIT & LOCAL


	CREATE TABLE #supers (custid INT)

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
		AND ci.currency IN  (SELECT ExchangeId FROM #tmp_Exchange ) 

	DECLARE @batch int = 3000      

	IF EXISTS (SELECT TOP 1 1 FROM #supers)
	BEGIN
		CREATE TABLE #CustStakeLevel_Agent  (CustID INT	 PRIMARY KEY(CustID))
		CREATE TABLE #CustStakeLevel_Member (CustID INT	 PRIMARY KEY(CustID))

		CREATE TABLE #CustStakeLevel_Agent_Temp  (CustID INT	 PRIMARY KEY(CustID))
		CREATE TABLE #CustStakeLevel_Member_Temp (CustID INT	 PRIMARY KEY(CustID))

-----Collect Data Sample
-----CustStakeLevel_Agent
	INSERT INTO #CustStakeLevel_Agent
	SELECT DISTINCT cg.custid 
	FROM dbo.CustStakeLevel_Agent cg WITH(NOLOCK)	
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID	
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype and BetType = 5100

-----CustStakeLevel_Member
	INSERT INTO #CustStakeLevel_Member
	SELECT DISTINCT cg.custid 
	FROM dbo.CustStakeLevel_Member cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype and BetType = 5100	

-----DELETE CustStakeLevel_Agent
	WHILE EXISTS (SELECT TOP 1 1 FROM #CustStakeLevel_Agent)
		BEGIN
			DELETE TOP (@batch) FROM #CustStakeLevel_Agent OUTPUT DELETED.CustID
			INTO #CustStakeLevel_Agent_Temp

			IF @@ROWCOUNT = 0
				BREAK
			
			DELETE cg
			FROM dbo.CustStakeLevel_Agent cg WITH(ROWLOCK)		
				INNER JOIN #CustStakeLevel_Agent_Temp ci ON ci.custid = cg.CustID	
			WHERE SportType = @Sporttype and BetType = 5100

			TRUNCATE TABLE #CustStakeLevel_Agent_Temp
		END
-----DELETE CustStakeLevel_Member
	WHILE EXISTS (SELECT TOP 1 1 FROM #CustStakeLevel_Member)
		BEGIN
			DELETE TOP (@batch) FROM #CustStakeLevel_Member OUTPUT DELETED.CustID
			INTO #CustStakeLevel_Member_Temp

			IF @@ROWCOUNT = 0
				BREAK
			
			DELETE cM
			FROM dbo.CustStakeLevel_Member cM WITH(ROWLOCK)		
				INNER JOIN #CustStakeLevel_Member_Temp ci ON ci.custid = cM.CustID	
			WHERE SportType = @Sporttype and BetType = 5100

			TRUNCATE TABLE #CustStakeLevel_Member_Temp
		END

	END
	
	DROP TABLE #CustStakeLevel_Agent
	DROP TABLE #CustStakeLevel_Member
	DROP TABLE #CustStakeLevel_Agent_Temp
	DROP TABLE #CustStakeLevel_Member_Temp
	DROP TABLE #supers
	

END	
GO
--END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
----------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
----------------------------------------------------------------------------------
EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = 'REPLICATED'


-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = 'DBCUST'

		