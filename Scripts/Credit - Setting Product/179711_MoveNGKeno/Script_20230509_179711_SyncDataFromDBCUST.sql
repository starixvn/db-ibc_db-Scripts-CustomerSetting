/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230509@Eden
	Task: sync data from dbcust to replicated [Redmine: #179711]
	DB: Replicated server only
*/ 

CREATE TABLE #SMA_BetLimit(CustID int,SportType smallint,BetType smallint,MinBet money,MaxBet money,MaxPerMatch money)
CREATE TABLE #Member_BetLimit(CustID int,SportType smallint,BetType smallint,MinBet money,MaxBet money,MaxPerMatch money)
CREATE TABLE #Tmpbatch_BetLimit(CustID int,SportType smallint,BetType smallint,MinBet money,MaxBet money,MaxPerMatch money)

DECLARE @BatchSize INT = 2500

INSERT INTO #SMA_BetLimit(CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch)
SELECT s.CustID,s.SportType,s.BetType,s.MinBet,s.MaxBet,s.MaxPerMatch
FROM DBCUST.CUSTDB.dbo.CustBetSetting3rd_Agent s WITH(NOLOCK)
	INNER JOIN dbo.CustBetSetting3rd_Agent d WITH(NOLOCK) 
		ON s.custid = d.custid 
		and s.sporttype = d.sporttype
		and s.BetType = d.BetType
WHERE s.SportType = 202
	AND ( s.MinBet <> d.MaxBet 
		OR s.MaxBet <> d.MaxBet
		OR s.MaxPerMatch <> d.MaxPerMatch
		)

INSERT INTO #Member_BetLimit(CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch)
SELECT s.CustID,s.SportType,s.BetType,s.MinBet,s.MaxBet,s.MaxPerMatch
FROM DBCUST.CUSTDB.dbo.CustBetSetting3rd_Member s WITH(NOLOCK)
	INNER JOIN dbo.CustBetSetting3rd_Member d WITH(NOLOCK) 
		ON s.custid = d.custid 
		and s.sporttype = d.sporttype
		and s.BetType = d.BetType
WHERE s.SportType = 202
	AND ( s.MinBet <> d.MaxBet 
		OR s.MaxBet <> d.MaxBet
		OR s.MaxPerMatch <> d.MaxPerMatch
		)

--Adjust Bet Setting 
	--Agent
	WHILE 1 = 1
	BEGIN
		DELETE TOP(@BatchSize) t
		OUTPUT deleted.custid,deleted.SportType,deleted.BetType,deleted.MinBet,deleted.MaxBet,deleted.MaxPerMatch
		INTO #Tmpbatch_BetLimit(custid,SportType,BetType,MinBet,MaxBet,MaxPerMatch)
		FROM #SMA_BetLimit t

		IF @@ROWCOUNT = 0
			BREAK

		UPDATE cs
		SET cs.MinBet = ci.MinBet,
			cs.MaxBet = ci.MaxBet,
			cs.MaxPerMatch = ci.MaxPerMatch
		FROM [dbo].CustBetSetting3rd_Agent cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #Tmpbatch_BetLimit ci 
				ON cs.CustID = ci.CustID 
				AND cs.SportType = ci.SportType 
				AND cs.BetType = ci.BetType

		TRUNCATE TABLE #Tmpbatch_BetLimit
	END

	--Member
	WHILE 1 = 1
	BEGIN
		DELETE TOP(@BatchSize) t
		OUTPUT deleted.custid,deleted.SportType,deleted.BetType,deleted.MinBet,deleted.MaxBet,deleted.MaxPerMatch
		INTO #Tmpbatch_BetLimit(custid,SportType,BetType,MinBet,MaxBet,MaxPerMatch)
		FROM #Member_BetLimit t

		IF @@ROWCOUNT = 0
			BREAK

		UPDATE cs
		SET cs.MinBet = ci.MinBet,
			cs.MaxBet = ci.MaxBet,
			cs.MaxPerMatch = ci.MaxPerMatch
		FROM [dbo].CustBetSetting3rd_Member cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #Tmpbatch_BetLimit ci 
				ON cs.CustID = ci.CustID 
				AND cs.SportType = ci.SportType 
				AND cs.BetType = ci.BetType

		TRUNCATE TABLE #Tmpbatch_BetLimit
	END

DROP TABLE #Member_BetLimit
drop table #SMA_BetLimit
drop table #Tmpbatch_BetLimit