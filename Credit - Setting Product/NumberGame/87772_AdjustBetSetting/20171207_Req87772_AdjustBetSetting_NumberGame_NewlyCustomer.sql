/*
	Created: Elodie
	Task: Adjust Bet setting of NumberGame for newly customer
	DB: DBCUST/CustDB
	Date: 20171207
*/

DECLARE @MaxBet MONEY = 10000
DECLARE @MaxPerMatch MONEY = 30000
DECLARE @Sporttype SMALLINT = 161

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
FROM dbo.custSetting3rd cs WITH (NOLOCK)
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cs.custid
	INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
WHERE cs.maxbet > @MaxBet 	
	AND ci.custid > @max_custid
	AND cs.sporttype = @Sporttype

UPDATE cs	
SET cs.maxbet = @MaxBet
FROM dbo.custSetting3rd cs WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #ListCust ci WITH (NOLOCK) ON ci.custid = cs.custid AND ci.bettype = cs.bettype AND ci.sporttype = cs.sporttype
			
SELECT ci.custid
INTO #ListCustInfo
FROM dbo.custInfo ci WITH (NOLOCK)
	INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
WHERE ci.maxpermatch161 > @MaxPerMatch		
		AND ci.custid > @max_custid

UPDATE c	
SET c.maxpermatch161 = @MaxPerMatch		
FROM dbo.custInfo c WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #ListCustInfo ci ON ci.custid = c.custid			