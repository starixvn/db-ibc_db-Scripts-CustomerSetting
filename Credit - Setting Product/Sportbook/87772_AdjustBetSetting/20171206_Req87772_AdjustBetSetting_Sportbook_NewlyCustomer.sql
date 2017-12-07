/*
	Created: Elodie
	Task: Adjust Bet setting of Sportbook for newly customer
	DB: DBCUST/CustDB
	Date: 20171206
*/

DECLARE @MaxBet MONEY = 10000
DECLARE @MaxPerMatch MONEY = 30000

CREATE TABLE #supers (custid int)

DECLARE @max_custid INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
WHERE ci.roleid = 4  
	AND ci.username IN ('Ky1','Ky6','Nw52','Nw53','Nw63','Nw71','Nc9','Nc47','Nc66','Nc68','Nc69','Nc85')

SELECT ci.custid, cs.sporttype, cs.bettype
INTO #ListCust
FROM dbo.custSetting cs WITH (NOLOCK)
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cs.custid
	INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
WHERE cs.maxbet > @MaxBet 	
	AND ci.custid > @max_custid

UPDATE cs	
SET cs.maxbet = @MaxBet
FROM dbo.custSetting cs WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #ListCust ci WITH (NOLOCK) ON ci.custid = cs.custid AND ci.bettype = cs.bettype AND ci.sporttype = cs.sporttype
			
SELECT ci.custid,
	CASE WHEN ci.maxpermatch > @MaxPerMatch THEN 1 ELSE 0 END AS Soccer,
	CASE WHEN ci.MaxPerMatch1MP > @MaxPerMatch THEN 1 ELSE 0 END AS SoccerMP,
	CASE WHEN ci.maxpermatch2 > @MaxPerMatch THEN 1 ELSE 0 END AS Basketball,
	CASE WHEN ci.maxpermatch3 > @MaxPerMatch THEN 1 ELSE 0 END AS Football,
	CASE WHEN ci.maxpermatch5 > @MaxPerMatch THEN 1 ELSE 0 END AS Tennis,
	CASE WHEN ci.maxpermatch8 > @MaxPerMatch THEN 1 ELSE 0 END AS Baseball,
	CASE WHEN ci.maxpermatch10 > @MaxPerMatch THEN 1 ELSE 0 END AS Golf,
	CASE WHEN ci.maxpermatch11 > @MaxPerMatch THEN 1 ELSE 0 END AS MotoSports,
	CASE WHEN ci.maxpermatch99 > @MaxPerMatch THEN 1 ELSE 0 END AS OtherSports,
	CASE WHEN ci.MaxPerMatch99MP > @MaxPerMatch THEN 1 ELSE 0 END AS MixParlay, 
	CASE WHEN ci.maxpermatch154 > @MaxPerMatch THEN 1 ELSE 0 END AS HRFixedOdds
INTO #ListCustInfo
FROM dbo.custInfo ci WITH (NOLOCK)
	INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
WHERE (ci.maxpermatch > @MaxPerMatch
			OR ci.MaxPerMatch1MP > @MaxPerMatch
			OR ci.maxpermatch2 > @MaxPerMatch
			OR ci.maxpermatch3 > @MaxPerMatch
			OR ci.maxpermatch5 > @MaxPerMatch
			OR ci.maxpermatch8 > @MaxPerMatch
			OR ci.maxpermatch10 > @MaxPerMatch
			OR ci.maxpermatch11 > @MaxPerMatch
			OR ci.maxpermatch99 > @MaxPerMatch
			OR ci.MaxPerMatch99MP > @MaxPerMatch
			OR ci.maxpermatch154 > @MaxPerMatch				
		)
		AND ci.custid > @max_custid
	
UPDATE c	
SET c.maxpermatch = CASE WHEN Soccer = 1 THEN @MaxPerMatch ELSE c.maxpermatch END,
	c.MaxPerMatch1MP = CASE WHEN SoccerMP = 1 THEN @MaxPerMatch ELSE c.MaxPerMatch1MP END,
	c.maxpermatch2 = CASE WHEN Basketball = 1 THEN @MaxPerMatch ELSE c.maxpermatch2 END,
	c.maxpermatch3 = CASE WHEN Football = 1 THEN @MaxPerMatch ELSE c.maxpermatch3 END,
	c.maxpermatch5 = CASE WHEN Tennis = 1 THEN @MaxPerMatch ELSE c.maxpermatch5 END,
	c.maxpermatch8 = CASE WHEN Baseball = 1 THEN @MaxPerMatch ELSE c.maxpermatch8 END,
	c.MaxPerMatch10 = CASE WHEN Golf = 1 THEN @MaxPerMatch ELSE c.MaxPerMatch10 END,
	c.MaxPerMatch11 = CASE WHEN MotoSports = 1 THEN @MaxPerMatch ELSE c.MaxPerMatch11 END,
	c.maxpermatch99 = CASE WHEN OtherSports = 1 THEN @MaxPerMatch ELSE c.maxpermatch99 END,
	c.MaxPerMatch99MP = CASE WHEN MixParlay = 1 THEN @MaxPerMatch ELSE c.MaxPerMatch99MP END,
	c.maxpermatch154 = CASE WHEN HRFixedOdds = 1 THEN @MaxPerMatch ELSE c.maxpermatch154 END
FROM dbo.custInfo c WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #ListCustInfo ci WITH (NOLOCK) ON ci.custid = c.custid