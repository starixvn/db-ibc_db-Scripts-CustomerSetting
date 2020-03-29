/*
	Created: Elodie
	Task: Adjust Setting for Table Games
	DB: DBCUST/CustDB
	Date: 20200329
*/ 
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_08] 
	@target VARCHAR(20)
AS
BEGIN
	
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN	

	DECLARE	  @fSportType SMALLINT	= 220
			, @fBetType SMALLINT	= 1024
			, @tSportType SMALLINT	= 222
			, @tBetType SMALLINT	= 4901

	--------------------------------------PT Setting-------------------------------------------------	
	SELECT f.CustID, f.IsLive, f.SuperPT, f.MasterPT, f.AgentPT, f.IsAutoMasterPT, f.AutoMasterPT, f.IsAutoSuperPT, f.AutoSuperPT, f.MinPT, f.MaxPT
	INTO #CustPTSetting3rd_Agent
	FROM CustPTSetting3rd_Agent f WITH (NOLOCK)
		INNER JOIN CustPTSetting3rd_Agent t  WITH (NOLOCK)
			ON f.CustID = t.CustID 
			AND f.IsLive = t.IsLive
			AND t.SportType = @tSportType 
			AND t.BetType = @tBetType
	WHERE f.SportType = @fSportType AND f.BetType = @fBetType
	AND(   f.SuperPT		<> t.SuperPT				
		OR f.MasterPT		<> t.MasterPT	
		OR f.AgentPT		<> t.AgentPT
		OR f.IsAutoMasterPT	<> t.IsAutoMasterPT
		OR f.AutoMasterPT	<> t.AutoMasterPT
		OR f.IsAutoSuperPT	<> t.IsAutoSuperPT
		OR f.AutoSuperPT	<> t.AutoSuperPT
		OR f.[MinPT]		<> t.MinPT
		OR f.[MaxPT]		<> t.MaxPT
		)

	SELECT f.CustID, f.IsLive, f.SuperPT, f.MasterPT, f.AgentPT, f.IsAutoMasterPT, f.AutoMasterPT, f.IsAutoSuperPT, f.AutoSuperPT	
	INTO #CustPTSetting3rd_Member
	FROM CustPTSetting3rd_Member f WITH (NOLOCK)
		INNER JOIN CustPTSetting3rd_Member t  WITH (NOLOCK)
			ON f.CustID = t.CustID 
			AND f.IsLive = t.IsLive
			AND t.SportType = @tSportType 
			AND t.BetType = @tBetType
	WHERE f.SportType = @fSportType AND f.BetType = @fBetType
	AND(   f.SuperPT		<> t.SuperPT				
		OR f.MasterPT		<> t.MasterPT	
		OR f.AgentPT		<> t.AgentPT
		OR f.IsAutoMasterPT	<> t.IsAutoMasterPT
		OR f.AutoMasterPT	<> t.AutoMasterPT
		OR f.IsAutoSuperPT	<> t.IsAutoSuperPT
		OR f.AutoSuperPT	<> t.AutoSuperPT)

	SELECT f.AgentID, f.IsLive, f.SuperPT, f.MasterPT, f.AgentPT, f.IsAutoMasterPT, f.AutoMasterPT, f.IsAutoSuperPT, f.AutoSuperPT	
	INTO #CustPTGroupSetting3rd_Member
	FROM CustPTGroupSetting3rd_Member f WITH (NOLOCK)
		INNER JOIN CustPTGroupSetting3rd_Member t  WITH (NOLOCK)
			ON f.AgentID = t.AgentID 
			AND f.IsLive = t.IsLive
			AND t.SportType = @tSportType 
			AND t.BetType = @tBetType
	WHERE f.SportType = @fSportType AND f.BetType = @fBetType
	AND(   f.SuperPT		<> t.SuperPT				
		OR f.MasterPT		<> t.MasterPT	
		OR f.AgentPT		<> t.AgentPT
		OR f.IsAutoMasterPT	<> t.IsAutoMasterPT
		OR f.AutoMasterPT	<> t.AutoMasterPT
		OR f.IsAutoSuperPT	<> t.IsAutoSuperPT
		OR f.AutoSuperPT	<> t.AutoSuperPT)

	UPDATE a
	SET a.SuperPT		= t.SuperPT		
	 ,a.MasterPT		= t.MasterPT	
	 ,a.AgentPT			= t.AgentPT
	 ,a.IsAutoMasterPT	= t.IsAutoMasterPT
	 ,a.AutoMasterPT	= t.AutoMasterPT
	 ,a.IsAutoSuperPT	= t.IsAutoSuperPT
	 ,a.AutoSuperPT		= t.AutoSuperPT
	 ,a.[MinPT]			= t.MinPT
	 ,a.[MaxPT]			= t.MaxPT
	FROM CustPTSetting3rd_Agent a WITH(ROWLOCK)
		INNER JOIN #CustPTSetting3rd_Agent t ON a.CustID = t.CustID
	WHERE a.SportType = @tSportType AND a.BetType = @tBetType

	UPDATE a
	SET a.SuperPT		= t.SuperPT		
	 ,a.MasterPT		= t.MasterPT	
	 ,a.AgentPT			= t.AgentPT
	 ,a.IsAutoMasterPT	= t.IsAutoMasterPT
	 ,a.AutoMasterPT	= t.AutoMasterPT
	 ,a.IsAutoSuperPT	= t.IsAutoSuperPT
	 ,a.AutoSuperPT		= t.AutoSuperPT
	FROM CustPTSetting3rd_Member a WITH(ROWLOCK)
		INNER JOIN #CustPTSetting3rd_Member t ON a.CustID = t.CustID
	WHERE a.SportType = @tSportType AND a.BetType = @tBetType

	UPDATE a
	SET a.SuperPT		= t.SuperPT		
	 ,a.MasterPT		= t.MasterPT	
	 ,a.AgentPT			= t.AgentPT
	 ,a.IsAutoMasterPT	= t.IsAutoMasterPT
	 ,a.AutoMasterPT	= t.AutoMasterPT
	 ,a.IsAutoSuperPT	= t.IsAutoSuperPT
	 ,a.AutoSuperPT		= t.AutoSuperPT
	FROM CustPTGroupSetting3rd_Member a WITH(ROWLOCK)
		INNER JOIN #CustPTGroupSetting3rd_Member t ON a.AgentID = t.AgentID
	WHERE a.SportType = @tSportType AND a.BetType = @tBetType

	----------------------------------------WinLoss Limit Setting-------------------------------------------------	
	SELECT f.CustID, f.MinBet, f.MaxBet, f.MaxPerMatch
	INTO #CustBetSetting_Agent
	FROM dbo.CustBetSetting3rd_Agent f WITH (NOLOCK)
		INNER JOIN CustBetSetting3rd_Agent t  WITH (NOLOCK)
			ON f.CustID = t.CustID 
			AND t.SportType = @tSportType 
			AND t.BetType = @tBetType
	WHERE f.SportType = @fSportType AND f.BetType = @fBetType
	AND(   f.MinBet		<> t.MinBet				
		OR f.MaxBet		<> t.MaxBet		
		OR f.MaxPerMatch<> t.MaxPerMatch)

	SELECT f.CustID, f.MinBet, f.MaxBet, f.MaxPerMatch
	INTO #CustBetSetting_Member
	FROM dbo.CustBetSetting3rd_Member f WITH (NOLOCK)
		INNER JOIN CustBetSetting3rd_Member t  WITH (NOLOCK)
			ON f.CustID = t.CustID 
			AND t.SportType = @tSportType 
			AND t.BetType = @tBetType
	WHERE f.SportType = @fSportType AND f.BetType = @fBetType
	AND(   f.MinBet		<> t.MinBet				
		OR f.MaxBet		<> t.MaxBet		
		OR f.MaxPerMatch<> t.MaxPerMatch)

	UPDATE a
	SET	a.MinBet		= t.MinBet		
		 ,a.MaxBet		= t.MaxBet	
		 ,a.MaxPerMatch	= t.MaxPerMatch
	FROM CustBetSetting3rd_Agent a WITH(ROWLOCK)
		INNER JOIN #CustBetSetting_Agent t ON a.CustId = t.CustId
	WHERE a.SportType = @tSportType AND a.BetType = @tBetType

	UPDATE a
	SET	a.MinBet		= t.MinBet		
		 ,a.MaxBet		= t.MaxBet	
		 ,a.MaxPerMatch	= t.MaxPerMatch
	FROM CustBetSetting3rd_Member a WITH(ROWLOCK)
		INNER JOIN #CustBetSetting_Member t ON a.CustId = t.CustId
	WHERE a.SportType = @tSportType AND a.BetType = @tBetType

	----------------------------------------WinLoss Limit Setting-------------------------------------------------	
	SELECT f.CustID, f.MaxWinLimit, f.MaxLossLimit, f.IsAutoReset	
	INTO #CustWinLossLimit_Agent
	FROM CustWinLossLimit_Agent f WITH (NOLOCK)
		INNER JOIN CustWinLossLimit_Agent t  WITH (NOLOCK)
			ON f.CustID = t.CustID 
			AND t.SportType = @tSportType 
			AND t.BetType = @tBetType
	WHERE f.SportType = @fSportType AND f.BetType = @fBetType
	AND(   ISNULL(f.MaxWinLimit,0)		<> ISNULL(t.MaxWinLimit,0)			
		OR ISNULL(f.MaxLossLimit,0)		<> ISNULL(t.MaxLossLimit,0)	
		OR ISNULL(f.IsAutoReset,0)		<> ISNULL(t.IsAutoReset,0) )

	SELECT f.CustID, f.MaxWinLimit, f.MaxLossLimit, f.IsAutoReset	
	INTO #CustWinLossLimit_Member
	FROM CustWinLossLimit_Member f WITH (NOLOCK)
		INNER JOIN CustWinLossLimit_Member t  WITH (NOLOCK)
			ON f.CustID = t.CustID 
			AND t.SportType = @tSportType 
			AND t.BetType = @tBetType
	WHERE f.SportType = @fSportType AND f.BetType = @fBetType
	AND(   ISNULL(f.MaxWinLimit,0)		<> ISNULL(t.MaxWinLimit,0)			
		OR ISNULL(f.MaxLossLimit,0)		<> ISNULL(t.MaxLossLimit,0)	
		OR ISNULL(f.IsAutoReset,0)		<> ISNULL(t.IsAutoReset,0) )

	UPDATE a
	SET a.MaxWinLimit		= t.MaxWinLimit		
	 ,a.MaxLossLimit		= t.MaxLossLimit	
	 ,a.IsAutoReset			= t.IsAutoReset
	FROM CustWinLossLimit_Agent a WITH(ROWLOCK)
		INNER JOIN #CustWinLossLimit_Agent t ON a.CustId = t.CustId
	WHERE a.SportType = @tSportType AND a.BetType = @tBetType

	UPDATE a
	SET a.MaxWinLimit		= t.MaxWinLimit		
	 ,a.MaxLossLimit		= t.MaxLossLimit	
	 ,a.IsAutoReset			= t.IsAutoReset
	FROM CustWinLossLimit_Member a WITH(ROWLOCK)
		INNER JOIN #CustWinLossLimit_Member t ON a.CustId = t.CustId
	WHERE a.SportType = @tSportType AND a.BetType = @tBetType

	DROP TABLE #CustPTGroupSetting3rd_Member
	DROP TABLE #CustPTSetting3rd_Agent
	DROP TABLE #CustPTSetting3rd_Member
	DROP TABLE #CustWinLossLimit_Agent
	DROP TABLE #CustWinLossLimit_Member
	DROP TABLE #CustBetSetting_Agent
	DROP TABLE #CustBetSetting_Member

END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
PRINT N'Step 10: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

EXEC dbo.Acc_DynamicCustSetting3rd_08 @target = 'REPLICATED'

PRINT N'Step 10: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
PRINT N'Step 10: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

EXEC dbo.Acc_DynamicCustSetting3rd_08 @target = 'DBCUST'

PRINT N'Step 10: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'
 