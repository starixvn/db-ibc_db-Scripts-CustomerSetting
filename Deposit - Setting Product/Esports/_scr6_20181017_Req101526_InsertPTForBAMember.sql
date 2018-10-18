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

	DECLARE @Sporttype INT = 43, @BetType INT = 1

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
	FROM Dep_CustBAActive BA WITH(NOLOCK)
		WHERE BA.CustId<=@maxcustid

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
           ,0
           ,[SuperPT]
           ,[MasterPT]
           ,[AgentPT]
	FROM Dep_CustBAActive BA WITH(NOLOCK)
		INNER JOIN Customer c WITH(NOLOCK) ON BA.CustId=c.custid
		INNER JOIN [Dep_CustPTGroupSetting_Member] s WITH(NOLOCK) ON c.recommend=s.AgentID
	WHERE s.SportType<>@Sporttype AND s.BetType<>@BetType AND BA.CustId<=@maxcustid

	UPDATE m
		SET m.IsGroupedPT=0
	FROM Dep_CustSettingMode m WITH(NOLOCK)
		INNER JOIN Dep_CustBAActive ba WITH(NOLOCK) ON m.CustID=ba.CustId
	WHERE BA.CustId<=@maxcustid

	INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
	SELECT ba.CustId,1
	FROM Dep_CustBAActive ba WITH(NOLOCK)
	WHERE NOT EXISTS(SELECT 1 FROM Dep_CustSettingMode m WITH(NOLOCK) WHERE m.CustID=ba.CustId)
		AND ba.CustId<=@maxcustid
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
