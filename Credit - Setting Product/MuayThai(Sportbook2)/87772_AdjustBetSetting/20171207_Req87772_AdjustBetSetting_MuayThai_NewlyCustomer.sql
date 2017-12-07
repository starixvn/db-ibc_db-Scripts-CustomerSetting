/*
	Created: Elodie
	Task: Adjust Bet setting of MuayThai for newly customer
	DB: DBCUST/CustDB
	Date: 20171207
*/

DECLARE @MaxBet MONEY = 10000
DECLARE @MaxPerMatch MONEY = 30000
DECLARE @Sporttype SMALLINT = 44

CREATE TABLE #supers (custid int)

DECLARE @max_custid INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
WHERE ci.roleid = 4  
	AND ci.username IN ('Ky1','Ky6','Nw52','Nw53','Nw63','Nw71','Nc9','Nc47','Nc66','Nc68','Nc69','Nc85')

SELECT ci.custid, cs.sporttype, cs.bettype,
	CASE WHEN cs.MaxBet > @MaxBet THEN 1 ELSE 0 END AS MaxBet,
	CASE WHEN cs.MaxPerMatch > @MaxPerMatch THEN 1 ELSE 0 END AS MaxPerMatch
INTO #ListSMA
FROM dbo.CustBetSetting3rd_Agent cs WITH (NOLOCK)
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cs.custid
	INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
WHERE cs.custid > @max_custid
	AND ci.roleid BETWEEN 2 AND 4
	AND cs.sporttype = @Sporttype
	AND (cs.maxbet > @MaxBet OR cs.MaxPerMatch > @MaxPerMatch)

SELECT ci.custid, cs.sporttype, cs.bettype,
	CASE WHEN cs.MaxBet > @MaxBet THEN 1 ELSE 0 END AS MaxBet,
	CASE WHEN cs.MaxPerMatch > @MaxPerMatch THEN 1 ELSE 0 END AS MaxPerMatch
INTO #ListMember
FROM dbo.CustBetSetting3rd_Member cs WITH (NOLOCK)
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cs.custid
	INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
WHERE cs.custid > @max_custid
	AND ci.roleid = 1
	AND cs.sporttype = @Sporttype
	AND (cs.maxbet > @MaxBet OR cs.MaxPerMatch > @MaxPerMatch)

UPDATE cs	
SET cs.MaxBet = CASE WHEN ci.MaxBet = 1 THEN @MaxBet ELSE cs.MaxBet END,
	cs.MaxPerMatch = CASE WHEN ci.MaxPerMatch = 1 THEN @MaxPerMatch ELSE cs.MaxPerMatch END
FROM dbo.CustBetSetting3rd_Agent cs WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #ListSMA ci WITH (NOLOCK) ON ci.custid = cs.custid AND ci.bettype = cs.bettype AND ci.sporttype = cs.sporttype

UPDATE cs	
SET cs.MaxBet = CASE WHEN ci.MaxBet = 1 THEN @MaxBet ELSE cs.MaxBet END,
	cs.MaxPerMatch = CASE WHEN ci.MaxPerMatch = 1 THEN @MaxPerMatch ELSE cs.MaxPerMatch END
FROM dbo.CustBetSetting3rd_Member cs WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #ListMember ci WITH (NOLOCK) ON ci.custid = cs.custid AND ci.bettype = cs.bettype AND ci.sporttype = cs.sporttype
	