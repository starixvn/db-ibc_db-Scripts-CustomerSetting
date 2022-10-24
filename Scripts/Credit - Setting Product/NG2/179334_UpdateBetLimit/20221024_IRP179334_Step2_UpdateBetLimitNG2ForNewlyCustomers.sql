/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Johnson
	Date: 20221024
	Task: Update bet limit for NG2  [RedmineID:#179334]
	DB: DBCust/CustDB
*/


CREATE TABLE #supers (custid int PRIMARY KEY ,isfinished bit default(0))
CREATE TABLE #tmpSupers (custid int PRIMARY KEY)

SELECT 	2502 bettype	,	1 minbet	,	250	maxbet,	2500 MaxPerMatch
INTO #tmpSetting
UNION SELECT 	2503	,	1	,	250	,	2500
UNION SELECT 	2504	,	1	,	250	,	2500
UNION SELECT 	2505	,	1	,	250	,	2500
/*UNION SELECT 	2506	,	1	,	250	,	1000
UNION SELECT 	2507	,	1	,	250	,	1250
UNION SELECT 	2508	,	1	,	250	,	1250
UNION SELECT 	2509	,	1	,	250	,	1250
UNION SELECT 	2510	,	1	,	250	,	1250
UNION SELECT 	2511	,	1	,	250	,	1250*/
UNION SELECT 	2512	,	1	,	250	,	1250
UNION SELECT 	2513	,	1	,	250	,	1250
UNION SELECT 	2514	,	1	,	250	,	1250
UNION SELECT 	2515	,	1	,	135	,	675
UNION SELECT 	2516	,	1	,	100	,	500
UNION SELECT 	2517	,	1	,	200	,	1000
UNION SELECT 	2518	,	1	,	250	,	1250
UNION SELECT 	2519	,	1	,	250	,	1250
UNION SELECT 	2520	,	1	,	250	,	1250
UNION SELECT 	2521	,	1	,	250	,	1250
UNION SELECT 	2522	,	1	,	250	,	1250	

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #tmpSupers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid	
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0	
	AND s.islicensee = 0
	AND ci.site = '789y'
	AND ci.currency <> 20 

INSERT INTO #Supers(custid)			
SELECT DISTINCT cs.custid 
FROM CustBetSetting3rd_Agent cs WITH(NOLOCK)
	INNER JOIN #tmpSupers s ON cs.custid = s.custid
	INNER JOIN #tmpSetting t ON cs.sporttype = 213 AND cs.bettype = t.bettype
WHERE (cs.MaxBet > t.MaxBet OR cs.MaxPerMatch > t.MaxPerMatch)	

CREATE TABLE #tblCust (custid INT PRIMARY KEY, roleid TINYINT)
CREATE TABLE #tblCustUpdated (custid INT PRIMARY KEY)
DECLARE @tmpCust TABLE (custid INT PRIMARY KEY)
DECLARE @tmpCustBetSetting_History TABLE (
				[CustID] [int] NOT NULL,
				[SportType] [smallint] NOT NULL,
				[BetType] [int] NOT NULL,
				[OldMaxBet] [money] NULL,
				[OldMaxPerMatch] [money] NULL,
				PRIMARY KEY 
					(
						[CustID] ASC,
						[SportType] ASC,
						[BetType] ASC
					)
				)
				
INSERT INTO #tblCust(custid, roleid)
SELECT custid, roleid
FROM custinfo WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers)
	AND custid > @max_custid
	AND enabled = 1
	
INSERT INTO #tblCustUpdated(custid)
SELECT DISTINCT custid
FROM CustBetSetting3rd_Agent cs WITH(NOLOCK)
	INNER JOIN #tmpSetting t ON cs.bettype = t.bettype AND cs.sporttype = 213
WHERE cs.custid IN (SELECT custid FROM #tblCust WHERE roleid IN (2,3,4))
	AND (cs.MaxBet > t.MaxBet OR cs.MaxPerMatch > t.MaxPerMatch)

--masters/agents dont belong to list supers update but break global settings
--2 rows affects
INSERT INTO #tblCustUpdated(custid)
select DISTINCT cs.custid
FROM CustBetSetting3rd_Agent cs WITH(NOLOCK)
	INNER JOIN #tmpSetting t ON cs.bettype = t.bettype AND cs.sporttype = 213
	INNER JOIN custinfo ci (NOLOCK) ON cs.custid = ci.custid
WHERE ci.srecommend IN (SELECT custid FROM #tmpSupers WHERE custid NOT IN (SELECT custid FROM #supers))
	and ci.roleid IN (2,3,4)
	and ci.enabled =1
	AND (cs.MaxBet > t.MaxBet OR cs.MaxPerMatch > t.MaxPerMatch)
	
WHILE(1=1)
BEGIN
	DELETE TOP (100) t
	OUTPUT DELETED.custid INTO @tmpCust(custid)
	FROM #tblCustUpdated t
	
	IF @@ROWCOUNT = 0
		BREAK;
		
	UPDATE cs
	SET cs.MaxBet = CASE WHEN cs.MaxBet > t.MaxBet THEN t.MaxBet ELSE cs.MaxBet END,
		cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch > t.MaxPerMatch THEN t.MaxPerMatch ELSE cs.MaxPerMatch END
	FROM CustBetSetting3rd_Agent cs WITH(ROWLOCK)
		INNER JOIN #tmpSetting t ON cs.bettype = t.bettype AND cs.sporttype = 213
	WHERE cs.custid IN (SELECT custid FROM @tmpCust)
		AND (cs.MaxBet > t.MaxBet OR cs.MaxPerMatch > t.MaxPerMatch)	
	
	DELETE @tmpCust	
	
	WAITFOR DELAY '0:0:0.1'
END
	
DELETE #tblCustUpdated

INSERT INTO #tblCustUpdated(custid)
SELECT DISTINCT custid
FROM CustBetSetting3rd_Member cs WITH(NOLOCK)
	INNER JOIN #tmpSetting t ON cs.bettype = t.bettype AND cs.sporttype = 213
WHERE cs.custid IN (SELECT custid FROM #tblCust WHERE roleid IN (1))
	AND (cs.MaxBet > t.MaxBet OR cs.MaxPerMatch > t.MaxPerMatch)

--members dont belong to list supers update but break global settings
--6 rows affects
INSERT INTO #tblCustUpdated(custid)
SELECT DISTINCT ci.custid
FROM CustBetSetting3rd_Member cs WITH(NOLOCK)
	INNER JOIN #tmpSetting t ON cs.bettype = t.bettype AND cs.sporttype = 213
	INNER JOIN custinfo ci (NOLOCK) ON cs.custid = ci.custid
WHERE ci.srecommend IN (SELECT custid FROM #tmpSupers WHERE custid NOT IN (SELECT custid FROM #supers))
	and ci.roleid = 1
	and ci.enabled =1
	AND (cs.MaxBet > t.MaxBet OR cs.MaxPerMatch > t.MaxPerMatch)
	
WHILE(1=1)
BEGIN
	DELETE TOP (100) t
	OUTPUT DELETED.custid INTO @tmpCust(custid)
	FROM #tblCustUpdated t
	
	IF @@ROWCOUNT = 0
		BREAK;
	
	UPDATE cs
	SET cs.MaxBet = CASE WHEN cs.MaxBet > t.MaxBet THEN t.MaxBet ELSE cs.MaxBet END,
		cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch > t.MaxPerMatch THEN t.MaxPerMatch ELSE cs.MaxPerMatch END
		OUTPUT DELETED.custid, DELETED.sporttype, DELETED.bettype,DELETED.MaxBet,DELETED.MaxPerMatch
		INTO @tmpCustBetSetting_History(custid,sporttype,bettype,OldMaxBet,OldMaxPerMatch)
	FROM CustBetSetting3rd_Member cs WITH(ROWLOCK)
		INNER JOIN #tmpSetting t ON cs.bettype = t.bettype AND cs.sporttype = 213
	WHERE cs.custid IN (SELECT custid FROM @tmpCust)
		AND (cs.MaxBet > t.MaxBet OR cs.MaxPerMatch > t.MaxPerMatch)	
				
	INSERT INTO [dbo].[CustMaxBetSetting_History]
			   ([CustID]
			   ,[SportType]
			   ,[BetType]
			   ,[OldMaxBet]
			   ,[OldMaxPerMatch]
			   ,[OldStakeLevelList]
			   ,[UpdateTime])
	SELECT custid,sporttype,bettype,OldMaxBet,OldMaxPerMatch,NULL,GETDATE()
	FROM @tmpCustBetSetting_History
	
	DELETE @tmpCustBetSetting_History	
	DELETE @tmpCust	
	
	WAITFOR DELAY '0:0:0.1'
END

--Update global bet limit 
UPDATE cs
SET cs.MinBet = CASE WHEN cs.MinBet > t.MinBet THEN t.MinBet ELSE cs.MinBet END,
	cs.MaxBet = CASE WHEN cs.MaxBet > t.MaxBet THEN t.MaxBet ELSE cs.MaxBet END,
	cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch > t.MaxPerMatch THEN t.MaxPerMatch ELSE cs.MaxPerMatch END,
	cs.DefaultMinBet = CASE WHEN cs.DefaultMinBet > t.MinBet THEN t.MinBet ELSE cs.DefaultMinBet END,
	cs.DefaultMaxBet = CASE WHEN cs.DefaultMaxBet > t.MaxBet THEN t.MaxBet ELSE cs.DefaultMaxBet END,
	cs.DefaultMaxPerMatch = CASE WHEN cs.DefaultMaxPerMatch > t.MaxPerMatch THEN t.MaxPerMatch ELSE cs.DefaultMaxPerMatch END
FROM ProductBetSetting cs WITH(ROWLOCK)
	INNER JOIN #tmpsetting t on cs.Bettype = t.bettype and sporttype = 213
where (cs.MinBet > t.MinBet OR cs.MaxBet > t.MaxBet OR cs.MaxPerMatch > t.MaxPerMatch)	
and cs.Currency <> 20

DROP TABLE #tblCustUpdated
DROP TABLE #tblCust
DROP TABLE #tmpSetting	