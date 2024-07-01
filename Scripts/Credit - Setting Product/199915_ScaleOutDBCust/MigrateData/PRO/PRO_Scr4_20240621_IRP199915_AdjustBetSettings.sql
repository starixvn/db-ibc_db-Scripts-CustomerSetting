/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240620@Johnson
	Task: Migrate data for bet setting SB [redmine: #199915]
	DB: DBCUST-CustDB
*/ 
DECLARE @max_custid INT = xxx

CREATE TABLE #tblCust(CustID INT, Sporttype SMALLINT, Bettype SMALLINT PRIMARY KEY (custid,sporttype,bettype))
DECLARE @tmpCust TABLE(CustID INT, Sporttype SMALLINT, Bettype SMALLINT PRIMARY KEY (custid,sporttype,bettype))

INSERT INTO #tblCust(custid,sporttype,bettype)
SELECT cs.custid, cs.sporttype, cs.bettype
FROM CustBetSetting_Agent cs WITH(NOLOCK)
	INNER JOIN BetSetting_Agent cs2 WITH(NOLOCK) ON cs.custid = cs2.custid
												AND cs.sporttype = cs2.sporttype
												AND cs.bettype = cs2.bettype
WHERE cs.custid <= @max_custid
	AND (cs.MinBet <> cs2.MinBet
	OR cs.MaxBet <> cs2.MaxBet
	OR cs.MaxPerMatch <> cs2.MaxPerMatch
	OR cs.MaxPayoutPerMatch <> cs2.MaxPayoutPerMatch
	)
	
IF @@ROWCOUNT <> 0
BEGIN
	WHILE(1=1)
	BEGIN	
		DELETE TOP (200) #tblCust
		OUTPUT DELETED.custid, DELETED.sporttype,DELETED.bettype 
		INTO @tmpCust(custid,sporttype,bettype)
		
		IF @@ROWCOUNT = 0
			BREAK;
		
		UPDATE cs
		SET cs.MinBet = cs2.MinBet,
			cs.MaxBet = cs2.MaxBet,
			cs.MaxPerMatch = cs2.MaxPerMatch,
			cs.MaxPayoutPerMatch = cs2.MaxPayoutPerMatch,
			cs.RepUpdateTime = SYSDATETIME()
		FROM BetSetting_Agent cs WITH(ROWLOCK)
			INNER JOIN CustBetSetting_Agent cs2 WITH(NOLOCK) ON cs.custid = cs2.custid
															AND cs.sporttype = cs2.sporttype
															AND cs.bettype = cs2.bettype
			INNER JOIN @tmpCust t ON cs.custid = t.custid
												AND cs.sporttype = t.sporttype
												AND cs.bettype = t.bettype	
		WHERE (cs.MinBet <> cs2.MinBet
			OR cs.MaxBet <> cs2.MaxBet
			OR cs.MaxPerMatch <> cs2.MaxPerMatch
			OR cs.MaxPayoutPerMatch <> cs2.MaxPayoutPerMatch
			)
			
		DELETE @tmpCust	
	END
END


INSERT INTO #tblCust(custid,sporttype,bettype)
SELECT cs.custid, cs.sporttype, cs.bettype
FROM CustBetSetting_Member cs WITH(NOLOCK)
	INNER JOIN BetSetting_Member cs2 WITH(NOLOCK) ON cs.custid = cs2.custid
												AND cs.sporttype = cs2.sporttype
												AND cs.bettype = cs2.bettype
WHERE cs.custid <= @max_custid
	AND (cs.MinBet <> cs2.MinBet
	OR cs.MaxBet <> cs2.MaxBet
	OR cs.MaxPerMatch <> cs2.MaxPerMatch
	OR cs.MaxPayoutPerMatch <> cs2.MaxPayoutPerMatch
	)
	
IF @@ROWCOUNT <> 0
BEGIN
	WHILE(1=1)
	BEGIN	
		DELETE TOP (200) #tblCust
		OUTPUT DELETED.custid, DELETED.sporttype,DELETED.bettype 
		INTO @tmpCust(custid,sporttype,bettype)
		
		IF @@ROWCOUNT = 0
			BREAK;
		
		UPDATE cs
		SET cs.MinBet = cs2.MinBet,
			cs.MaxBet = cs2.MaxBet,
			cs.MaxPerMatch = cs2.MaxPerMatch,
			cs.MaxPayoutPerMatch = cs2.MaxPayoutPerMatch,
			cs.RepUpdateTime = SYSDATETIME()
		FROM BetSetting_Member cs WITH(ROWLOCK)
			INNER JOIN CustBetSetting_Member cs2 WITH(NOLOCK) ON cs.custid = cs2.custid
															AND cs.sporttype = cs2.sporttype
															AND cs.bettype = cs2.bettype
			INNER JOIN @tmpCust t ON cs.custid = t.custid
												AND cs.sporttype = t.sporttype
												AND cs.bettype = t.bettype	
		WHERE (cs.MinBet <> cs2.MinBet
			OR cs.MaxBet <> cs2.MaxBet
			OR cs.MaxPerMatch <> cs2.MaxPerMatch
			OR cs.MaxPayoutPerMatch <> cs2.MaxPayoutPerMatch
			)
			
		DELETE @tmpCust	
	END
END