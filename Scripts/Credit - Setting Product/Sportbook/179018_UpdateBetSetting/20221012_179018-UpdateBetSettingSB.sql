/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: Elodie
	Date: 20221012
	Task: Adjust BetSetting SB for WP11
	DB: DBCust/CustDB
*/
DECLARE @SuperID INT = 36428160

CREATE TABLE #SMAList  (CustID INT, RoleId TINYINT, Sporttype SMALLINT, Bettype INT, MaxBet MONEY, MaxPerMatch MONEY, IsUpdated BIT DEFAULT(0))

CREATE TABLE #MemberList  (CustID INT, RoleId TINYINT, Sporttype SMALLINT, Bettype INT, MaxBet MONEY, MaxPerMatch MONEY, IsUpdated BIT DEFAULT(0))

INSERT INTO #SMAList (CustID, RoleId, Sporttype, Bettype, MaxBet, MaxPerMatch)
SELECT ci.CustID, RoleId,  Sporttype, Bettype, MaxBet, cs.MaxPerMatch
FROM CustInfo ci WITH (NOLOCK)
	INNER JOIn CustBetSetting_Agent cs WITH (NOLOCK) ON ci.custid = cs.CustID 
WHERE ci.srecommend = @SuperID
	AND roleid <> 4
	AND SportType NOT IN (164,161)
	
INSERT INTO #MemberList (CustID, RoleId, Sporttype, Bettype, MaxBet, MaxPerMatch)
SELECT ci.CustID, RoleId,  Sporttype, Bettype, MaxBet, cs.MaxPerMatch
FROM CustInfo ci WITH (NOLOCK)
	INNER JOIn CustBetSetting_Member cs WITH (NOLOCK) ON ci.custid = cs.CustID 
WHERE ci.srecommend = @SuperID
	AND SportType NOT IN (164,161)

UPDATE d
SET d.MaxBet = b.MaxBet,
	d.MaxPerMatch = b.MaxPerMatch,
	d.IsUpdated = 1
FROM #SMAList d
	CROSS APPLY (SELECT TOP 1 CustId, Sporttype, bettype, MinBet, MaxBet, MaxPerMatch, MaxPayoutPerMatch
				FROM DBTP.bodb_CustHistory.dbo.CustBetSetting_Agent_History a WITH (NOLOCK) 
				WHERE UpdateTime>='10/11/2022 3:35:21 AM'
					AND UpdateTime<='2022-10-12 03:49:20.300'
					AND d.CustID = a.CustId AND d.Sporttype = a.Sporttype AND d.Bettype = a.Bettype
				ORDER BY Updatetime) b
WHERE RoleId IN (2,3,4)
	AND (d.MaxBet <> b.MaxBet OR d.MaxPerMatch <> b.MaxPerMatch)

UPDATE d
SET d.MaxBet = b.MaxBet,
	d.MaxPerMatch = b.MaxPerMatch,
	d.IsUpdated = 1
FROM #MemberList d
	CROSS APPLY (SELECT TOP 1 CustId, Sporttype, bettype, MinBet, MaxBet, MaxPerMatch, MaxPayoutPerMatch
				FROM DBTP.bodb_CustHistory.dbo.CustBetSetting_Member_History a WITH (NOLOCK) 
				WHERE UpdateTime>='10/11/2022 3:35:21 AM'
					AND UpdateTime<='2022-10-12 03:49:20.300'	
					AND d.CustID = a.CustId AND d.Sporttype = a.Sporttype AND d.Bettype = a.Bettype
				ORDER BY Updatetime) b
WHERE RoleId = 1
	AND (d.MaxBet <> b.MaxBet OR d.MaxPerMatch <> b.MaxPerMatch)

UPDATE cs 
SET	cs.MaxBet = s.MaxBet,
	cs.MaxPerMatch = s.MaxPerMatch
FROM CustBetSetting_Agent cs WITH (ROWLOCK)
	INNER JOIN #SMAList s ON cs.custid = s.custid AND cs.sporttype = s.sporttype AND cs.bettype = s.bettype
WHERE s.IsUpdated = 1 

UPDATE cs 
SET	cs.MaxBet = s.MaxBet,
	cs.MaxPerMatch = s.MaxPerMatch
FROM CustBetSetting_Member cs WITH (ROWLOCK)
	INNER JOIN #MemberList s ON cs.custid = s.custid AND cs.sporttype = s.sporttype AND cs.bettype = s.bettype
WHERE s.IsUpdated = 1 

DROP TABLE #SMAList
DROP TABLE #MemberList