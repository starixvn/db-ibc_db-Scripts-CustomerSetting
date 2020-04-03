/*
	Created: Elodie
	Task: Adjust Setting for Table Games
	DB: DBCUST/CustDB
	Date: 20200329
*/ 
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09] 
	@target VARCHAR(20)
AS
BEGIN
	
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductStatusProfile') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 RETURN

	DECLARE	  @fSportType SMALLINT	= 220
			, @fBetType SMALLINT	= 1021
			, @tSportType SMALLINT	= 222
			, @tBetType SMALLINT	= 4901

	----------------------------------------Bet Setting-------------------------------------------------	
	SELECT f.CustID, f.MinBet, f.MaxBet, f.MaxPerMatch
	INTO #CustBetSetting_Agent
	FROM dbo.Dep_CustBetSetting_Agent f WITH (NOLOCK)
		INNER JOIN Dep_CustBetSetting_Agent t  WITH (NOLOCK)
			ON f.CustID = t.CustID 
			AND t.SportType = @tSportType 
			AND t.BetType = @tBetType
	WHERE f.SportType = @fSportType AND f.BetType = @fBetType
	AND(   f.MinBet		<> t.MinBet				
		OR f.MaxBet		<> t.MaxBet		
		OR f.MaxPerMatch<> t.MaxPerMatch)

	SELECT f.CustID, f.MinBet, f.MaxBet, f.MaxPerMatch
	INTO #CustBetSetting_Member
	FROM dbo.Dep_CustBetSetting_Member f WITH (NOLOCK)
		INNER JOIN Dep_CustBetSetting_Member t  WITH (NOLOCK)
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
	FROM Dep_CustBetSetting_Agent a WITH(ROWLOCK)
		INNER JOIN #CustBetSetting_Agent t ON a.CustId = t.CustId
	WHERE a.SportType = @tSportType AND a.BetType = @tBetType

	UPDATE a
	SET	a.MinBet		= t.MinBet		
		 ,a.MaxBet		= t.MaxBet	
		 ,a.MaxPerMatch	= t.MaxPerMatch
	FROM Dep_CustBetSetting_Member a WITH(ROWLOCK)
		INNER JOIN #CustBetSetting_Member t ON a.CustId = t.CustId
	WHERE a.SportType = @tSportType AND a.BetType = @tBetType

	DROP TABLE #CustBetSetting_Agent
	DROP TABLE #CustBetSetting_Member

END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
PRINT N'Step 10: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

EXEC dbo.Acc_Dep_DynamicCustSetting_09 @target = 'REPLICATED'

PRINT N'Step 10: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
PRINT N'Step 10: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

EXEC dbo.Acc_Dep_DynamicCustSetting_09 @target = 'DBCUST'

PRINT N'Step 10: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'
 