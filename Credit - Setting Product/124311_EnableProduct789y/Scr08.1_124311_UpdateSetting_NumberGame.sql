/*
	Created: Elodie	
	Task: Enable Product Status for all disabled customers under 789y Headline - RedmineID: #124311
	DB: DBCUST/CustDB
	Date: 20200221
*/ 
--	Number Game & Happy 5
DECLARE @MinBetDefault SMALLMONEY, @MaxBetDefault SMALLMONEY, @MaxPerMatchDefault SMALLMONEY, @MaxPerBallDefault SMALLMONEY
SELECT @MinBetDefault = 3, @MaxBetDefault = 500, @MaxPerMatchDefault = 2000, @MaxPerBallDefault = 1000

CREATE TABLE #supers (custid int,isfinished bit default(0))

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN custInfo C WITH (NOLOCK) ON C.custid = ci.custid
	--INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	--INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND ci.site IN ('789y')
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	--AND s.islicensee = 0
	AND Enabled = 1 

SELECT DISTINCT ci.custid, cs.sporttype, cs.bettype INTO #CustList
FROM dbo.CustSetting3rd cs WITH (NOLOCK) 
	INNER JOIN dbo.custInfo ci WITH (ROWLOCK)ON ci.CustID = cs.custid
	INNER JOIN #supers s ON ci.srecommend = s.custid
WHERE cs.sporttype IN (161,164)
	AND cs.maxbet < 1 
	AND ci.DisableNumber = 0
	AND ((cs.sporttype = 161 AND ci.maxpermatch161 > 1 AND ci.MaxPerBall161 > 1) OR (cs.sporttype = 164 AND ci.maxpermatch164 > 1))

UPDATE ci
SET ci.maxpermatch161 = CASE WHEN c.sporttype = 161 THEN @MaxPerMatchDefault ELSE ci.maxpermatch161 END, 			
	ci.MaxPerBall161 = CASE WHEN c.sporttype = 161 THEN @MaxPerBallDefault ELSE ci.MaxPerBall161 END,
	ci.maxpermatch164 = CASE WHEN c.sporttype = 164 THEN @MaxPerMatchDefault ELSE ci.maxpermatch164 END
FROM dbo.custInfo ci WITH (ROWLOCK)
	INNER JOIN #CustList c ON ci.custid = c.custid

UPDATE cs
SET cs.MinBet = @MinBetDefault,
	cs.MaxBet = @MaxBetDefault
FROM dbo.CustSetting3rd cs WITH (ROWLOCK) 
	INNER JOIN #CustList ci WITH (NOLOCK) ON ci.CustID = cs.custid AND ci.sporttype = cs.sporttype AND ci.bettype = cs.bettype
