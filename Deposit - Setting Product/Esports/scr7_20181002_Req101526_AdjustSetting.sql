/*
	Created: Winnie
	Task: Adjust Setting for Esports Deposit RedmineID: #101526
	DB: DBCUST/CustDB
	Date: 20181015
*/ 
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
AS
BEGIN
	
	SET NOCOUNT ON

	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustSettingMode') = 0 RETURN		
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN

	DECLARE @msgDone NVARCHAR(200) = 'Done for sporttype %d, bettype %d.'

	
	DECLARE @fSportType SMALLINT, @fBetType SMALLINT, @tSportType SMALLINT, @tBetType SMALLINT, @IsLive BIT
	DECLARE @Sporttype INT = 43

	SELECT @fSportType  = 99, @fBetType =1		

	--------------------------------------PT Setting-------------------------------------------------	
	
	CREATE TABLE #SMAList_PT (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY)
	CREATE TABLE #MemberList_PT (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY)	
			
		--------------------------------------Get Affected Cust List-------------------------------------------------	
		--Agent Level
		INSERT INTO #SMAList_PT (custid, SPositionTaking, MPositionTaking, APositionTaking)
		SELECT ci.custid, SPositionTaking, MPositionTaking, APositionTaking
		FROM dbo.Dep_CustSetting cs WITH(NOLOCK) 
			INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cs.custid			
			INNER JOIN dbo.Dep_CustPTSetting_Agent csa WITH(NOLOCK) ON csa.custid = cs.custid
		WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType AND csa.SportType = @tSportType AND csa.BetType = @tBetType
				AND ci.roleid IN (2,3,4) AND Enabled = 1			
				AND (
					cs.SPositionTaking * 100 <> csa.SuperPT
					OR cs.MPositionTaking * 100 <> csa.MasterPT
					OR cs.APositionTaking * 100 <> csa.AgentPT				
					)

		RAISERROR('Done: Get the affected SMA list for PT', 0, 1)  WITH NOWAIT
		SELECT * FROM #SMAList_PT
		--Member Level
		INSERT INTO #MemberList_PT (custid, SPositionTaking, MPositionTaking, APositionTaking)
		SELECT ci.custid, SPositionTaking, MPositionTaking, APositionTaking
		FROM dbo.Dep_CustSetting cs WITH(NOLOCK)
			INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cs.custid
			INNER JOIN dbo.Dep_CustPTSetting_Member csm WITH(NOLOCK) ON csm.custid = cs.custid
		WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType AND csm.SportType = @tSportType AND csm.BetType = @tBetType
				AND ci.roleid = 1 AND Enabled = 1
				AND (
					cs.SPositionTaking  * 100 <> csm.SuperPT
					OR cs.MPositionTaking  * 100 <> csm.MasterPT
					OR cs.APositionTaking  * 100 <> csm.AgentPT				
					)

		RAISERROR('Done: Get the affected member list for PT', 0, 1)  WITH NOWAIT
		SELECT * FROM #MemberList_PT
		-------------------------------------------------Adjust data----------------------------------------------------
		--Agent Level
		UPDATE csa
		SET	csa.SuperPT = cs.spositiontaking  *100
			,csa.MasterPT =  cs.mpositiontaking  *100
			,csa.AgentPT = cs.apositiontaking  *100			
		FROM dbo.Dep_CustPTSetting_Agent csa WITH(ROWLOCK,UPDLOCK) 
			INNER JOIN #SMAList_PT cs WITH (NOLOCK) ON cs.custid = csa.custid
		WHERE csa.SportType = @tSportType AND csa.BetType = @tBetType
	
		RAISERROR('Done: Update the affected SMA list for PT', 0, 1)  WITH NOWAIT

		--MEMBER LEVEL
		UPDATE csm
		SET	csm.SuperPT = cs.spositiontaking  *100
			,csm.MasterPT =  cs.mpositiontaking  *100
			,csm.AgentPT = cs.apositiontaking  *100		
		FROM dbo.Dep_CustPTSetting_Member csm WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #MemberList_PT cs WITH (NOLOCK) ON cs.custid = csm.custid
		WHERE csm.SportType = @tSportType AND csm.BetType = @tBetType	

		RAISERROR('Done: Update the affected member list for PT', 0, 1)  WITH NOWAIT

		RAISERROR(@msgDone, 0, 1, @tSportType, @tBetType)  WITH NOWAIT

		DROP TABLE #SMAList_PT
		DROP TABLE #MemberList_PT

	--------------------------------------Bet Setting-------------------------------------------------		
		SELECT @Sporttype =43,@fSportType  = 99,@fBetType =1,@tBetType=1	
	
		CREATE TABLE #SMAList_BetSetting (custid INT, minBet MONEY, MaxBet MONEY, MaxPerMatch MONEY)
		CREATE TABLE #MemberList_BetSetting (custid INT, minBet MONEY, MaxBet MONEY, MaxPerMatch MONEY)

		--Agent Level
		INSERT INTO #SMAList_BetSetting (custid, minBet, MaxBet, MaxPerMatch)
		SELECT c.custid, cs.minBet, cs.MaxBet, c.maxpermatch99
		FROM dbo.Dep_CustSetting cs WITH(NOLOCK)
			INNER JOIN custInfo c WITH(NOLOCK) ON cs.CustID = c.custid
			INNER JOIN dbo.Dep_CustBetSetting_Agent csa WITH(NOLOCK) ON csa.custid = cs.custid
		WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType AND csa.SportType = @tSportType AND csa.BetType = @tBetType
				AND c.roleid IN (2,3,4) AND Enabled = 1
				AND (
					cs.minBet <> csa.minBet
					OR cs.MaxBet <> csa.MaxBet
					OR c.maxpermatch99 <> csa.maxperMatch			
					)

		RAISERROR('Done: Get the affected SMA list for bet setting', 0, 1)  WITH NOWAIT
		SELECT * FROM #SMAList_BetSetting
		--Member Level
		INSERT INTO #MemberList_BetSetting (custid, minBet, MaxBet, MaxPerMatch)
		SELECT c.custid, cs.minBet, cs.MaxBet, c.maxpermatch99
		FROM dbo.Dep_CustSetting cs WITH(NOLOCK)
			INNER JOIN custInfo c WITH(NOLOCK) ON cs.CustID = c.custid		
			INNER JOIN dbo.Dep_CustBetSetting_Member csm WITH(NOLOCK) ON csm.custid = cs.custid
		WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType AND csm.SportType = @tSportType AND csm.BetType = @tBetType
				AND c.roleid = 1 AND Enabled = 1
				AND (
					cs.minBet <> csm.minBet
					OR cs.MaxBet <> csm.MaxBet
					OR c.maxpermatch99 <> csm.maxperMatch			
					)
	
		RAISERROR('Done: Get the affected member list for bet setting', 0, 1)  WITH NOWAIT

		SELECT * FROM #MemberList_BetSetting
		--------------------------------------Bet Setting-------------------------------------------------		
		--Agent Level
		UPDATE csa
		SET csa.minBet = cs.minbet,       
			csa.MaxBet = cs.MaxBet,   
			csa.maxperMatch = cs.MaxPerMatch
		FROM dbo.Dep_CustBetSetting_Agent csa WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #SMAList_BetSetting cs WITH(NOLOCK) ON csa.CustID = cs.custid
		WHERE csa.SportType = @tSportType AND csa.BetType = @tBetType

		RAISERROR('Done: Update the affected SMA list for bet setting', 0, 1)  WITH NOWAIT

		--Member Level
		UPDATE csm
		SET csm.minBet = cs.minbet,       
			csm.MaxBet = cs.MaxBet,   
			csm.maxperMatch = cs.MaxPerMatch
		FROM dbo.Dep_CustBetSetting_Member csm WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #MemberList_BetSetting cs WITH(NOLOCK) ON csm.CustID = cs.custid
		WHERE csm.SportType = @tSportType AND csm.BetType = @tBetType

		RAISERROR('Done: Update the affected member list for bet setting', 0, 1)  WITH NOWAIT

		RAISERROR(@msgDone, 0, 1, @tSportType, @tBetType)  WITH NOWAIT

		DROP TABLE #SMAList_BetSetting
		DROP TABLE #MemberList_BetSetting
	
END		
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
EXEC dbo.Acc_DynamicCustSetting3rd_09 

