/*
	Created: 20210113@Tina
	Task: Group PT Setting for Saba.club [RedmineID: 148472] - Test currrency
	DB: DBCUST/CustDB
*/  
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE Acc_DynamicCustSetting3rd_09
	@target VARCHAR(20)
AS
BEGIN  
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 1
	   AND dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 1
	   AND dbo.f_CheckRepTable('CustSettingMode3rd') = 1
	   AND dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 1
	   AND dbo.f_CheckRepTable('ProductSettingDetail') = 1
	   )
	  RETURN	

	CREATE TABLE #AgentList (CustID INT)
	DECLARE @AgentTmp TABLE (CustID INT)

	DECLARE @ProductID TINYINT = 42
	CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT, IsFinished BIT)
	INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
	SELECT	245, 4601, SportType, BetType, 0, SettingType, 0
	FROM dbo.ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SettingType IN (1)

	INSERT INTO #AgentList (CustID)
	SELECT DISTINCT AgentID
	FROM CustPTGroupSetting3rd_Member cs WITH (NOLOCK)
		INNER JOIN dbo.custInfo ci ON ci.custid = cs.AgentID
		INNER JOIN dbo.customer c ON ci.custid = c.custid
	WHERE ci.Enabled = 1 
		AND c.site IN ('222223', '611111', '722222', '733333', '7aa666', 'BEST-ODDS', 'KORIBC', 'XYZBET')
		AND c.currency = 20  --UUS

	DECLARE @fSportType SMALLINT, @fBetType SMALLINT
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType 
	FROM #DestinationSportBetType		
	WHERE SettingType = 1

	WHILE (1=1)
	BEGIN
		DELETE TOP (4000) t 
		OUTPUT Deleted.custid
		INTO @AgentTmp
		FROM #AgentList t

		IF @@ROWCOUNT = 0 BREAK

		--MEMBER LEVEL
		INSERT INTO dbo.CustPTGroupSetting3rd_Member
			(	[AgentID]
				,	[sporttype]
				,	[bettype]
				,	[islive]
				,	[superPT]
				,	[masterPT]
				,	[agentPT]
				,	[IsAutoMasterPT]
				,	[AutoMasterPT]
				,	[IsAutoSuperPT]
				,	[AutoSuperPT])
		SELECT 
			cs.AgentID, dest.tSportType, dest.tBetType, dest.IsLive
			,cs.SuperPT
			,cs.MasterPT
			,cs.AgentPT
			,cs.IsAutoMasterPT
			,cs.AutoMasterPT
			,cs.IsAutoSuperPT
			,cs.AutoSuperPT
		FROM dbo.CustPTGroupSetting3rd_Member cs WITH(NOLOCK)
			INNER JOIN @AgentTmp a ON a.CustID = cs.AgentID
			CROSS APPLY #DestinationSportBetType dest
		WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType
			AND dest.SettingType = 1

		DELETE @AgentTmp
	END
END
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = 'REPLICATED'


-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = 'DBCUST'

PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'