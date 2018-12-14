/*
	Created: Winnie
	Date: 20181011
	Task: Insert setting Esport for BA member
	DB: DBCust/CustDB
*/
 
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@target VARCHAR(20)
	,@maxcustid INT
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
	IF dbo.f_CheckRepTable('Dep_CustBAActive') = 0 RETURN		
	IF dbo.f_CheckRepTable('Dep_custsuper') = 0 RETURN
	IF dbo.f_CheckRepTable('custInfo') = 0 RETURN

	DECLARE @Sporttype INT = 43, @BetType INT = 1

	CREATE TABLE #supers			(custid INT)
	CREATE TABLE #supersAsiabet88	(custid INT)
	CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY,recommend INT)
	CREATE TABLE #tmpCustAsiabet88	(CustID INT PRIMARY KEY,recommend INT)
	CREATE TABLE #tmpCustInsert		(CustID INT PRIMARY KEY,recommend INT)	

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'	
		AND ci.Enabled=1
		AND cs.site IN ('368Cash','Abcasino','Aoncash','e8casino','Arlocash')

	INSERT INTO #tmpCust(CustID,recommend)
	SELECT BA.custID,c.recommend
	FROM Dep_CustBAActive BA WITH(NOLOCK)
		INNER JOIN Customer c WITH(NOLOCK) ON BA.CustId=c.custid
	WHERE BA.CustId<=@maxcustid AND c.srecommend IN(SELECT CustId FROM #supers)

	WHILE EXISTS(SELECT 1 FROM #tmpCust)
	BEGIN
		DELETE TOP (1000) #tmpCust OUTPUT DELETED.* INTO #tmpCustInsert

		INSERT INTO [dbo].[Dep_CustPTSetting_Member]
			   (CustID
			   ,[SportType]
			   ,[BetType]
			   ,[IsLive]
			   ,[SuperPT]
			   ,[MasterPT]
			   ,[AgentPT])
		SELECT 
				BA.CustId
			   ,@Sporttype
			   ,@BetType
			   ,0
			   ,0
			   ,0
			   ,0
		FROM #tmpCustInsert BA WITH(NOLOCK)		

		INSERT INTO [dbo].[Dep_CustPTSetting_Member]
			   (CustID
			   ,[SportType]
			   ,[BetType]
			   ,[IsLive]
			   ,[SuperPT]
			   ,[MasterPT]
			   ,[AgentPT])
		SELECT 
				BA.CustId
			   ,SportType
			   ,BetType
			   ,[IsLive]
			   ,[SuperPT]
			   ,[MasterPT]
			   ,[AgentPT]
		FROM #tmpCustInsert BA WITH(NOLOCK)		
			INNER JOIN [Dep_CustPTGroupSetting_Member] s WITH(NOLOCK) ON BA.recommend=s.AgentID
		WHERE s.SportType<>@Sporttype AND s.BetType<>@BetType

		UPDATE m
			SET m.IsGroupedPT=0
		FROM Dep_CustSettingMode m WITH(NOLOCK)
			INNER JOIN #tmpCustInsert ba WITH(NOLOCK) ON m.CustID=ba.CustId				
		
		TRUNCATE TABLE #tmpCustInsert
	END	
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @max_custid INT
SELECT @max_custid = xxx

EXEC Acc_DynamicCustSetting3rd_09	@target = 'REPLICATED'
									,@maxcustid = @max_custid

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
DECLARE @max_custid INT
SELECT @max_custid = xxx
EXEC Acc_DynamicCustSetting3rd_09	@target = 'DBCUST'
									,@maxcustid = @max_custid
