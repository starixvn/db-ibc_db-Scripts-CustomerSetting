/*
	Created: Winnie
	Task: Adjust Setting for Esports Deposit RedmineID: #101526
	DB: DBCUST/CustDB
	Date: 20181015
*/ 

	SET NOCOUNT ON

	DECLARE @msgDone NVARCHAR(200) = 'Done for sporttype %d, bettype %d.'

	
	DECLARE @fSportType SMALLINT, @fBetType SMALLINT, @tSportType SMALLINT, @tBetType SMALLINT

	DECLARE @MaxCustIDUM INT =xxx
	
	--------------------------------------Bet Setting-------------------------------------------------		
	SELECT @tSporttype =43,@fSportType  = 99,@fBetType =1,@tBetType=1	
	
	CREATE TABLE #SMAList_BetSetting (custid INT, minBet MONEY, MaxBet MONEY, MaxPerMatch MONEY)
	CREATE TABLE #MemberList_BetSetting (custid INT, minBet MONEY, MaxBet MONEY, MaxPerMatch MONEY)
	CREATE TABLE #MemberList_BetSetting5k (custid INT, minBet MONEY, MaxBet MONEY, MaxPerMatch MONEY)

	--Agent Level
	INSERT INTO #SMAList_BetSetting (custid, minBet, MaxBet, MaxPerMatch)
	SELECT c.custid, cs.minBet, cs.MaxBet, c.maxpermatch99
	FROM dbo.Dep_CustSetting cs WITH(NOLOCK)
		INNER JOIN custInfo c WITH(NOLOCK) ON cs.CustID = c.custid
		INNER JOIN dbo.Dep_CustBetSetting_Agent csa WITH(NOLOCK) ON csa.custid = cs.custid
	WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType AND csa.SportType = @tSportType AND csa.BetType = @tBetType
			AND c.roleid IN (2,3,4) AND Enabled = 1
			AND cs.custid<=@MaxCustIDUM
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
			AND cs.custid<=@MaxCustIDUM
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


	RAISERROR(@msgDone, 0, 1, @tSportType, @tBetType)  WITH NOWAIT

	WHILE EXISTS(SELECT 1 FROM #MemberList_BetSetting)
	BEGIN
		DELETE TOP (5000) #MemberList_BetSetting OUTPUT DELETED.* INTO #MemberList_BetSetting5k

		IF @@ROWCOUNT=0
			BREAK
				
		--Member Level
		UPDATE csm
		SET csm.minBet = cs.minbet,       
			csm.MaxBet = cs.MaxBet,   
			csm.maxperMatch = cs.MaxPerMatch
		FROM dbo.Dep_CustBetSetting_Member csm WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #MemberList_BetSetting5k cs WITH(NOLOCK) ON csm.CustID = cs.custid
		WHERE csm.SportType = @tSportType AND csm.BetType = @tBetType
		
		TRUNCATE TABLE #MemberList_BetSetting5k
	END
	
	RAISERROR('Done: Update the affected member list for bet setting', 0, 1)  WITH NOWAIT

	DROP TABLE #SMAList_BetSetting
	DROP TABLE #MemberList_BetSetting
	DROP TABLE #MemberList_BetSetting5k


	
