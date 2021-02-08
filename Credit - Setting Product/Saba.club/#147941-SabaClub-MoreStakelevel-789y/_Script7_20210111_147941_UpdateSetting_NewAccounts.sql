/*
	Created: Eden@20210111
	Task: UPDATE CustStakeLevel_Agent for Saba.Club - New accounts [#147941]
	DB: DBCust/CustDB
*/
USE CustDB
GO

DECLARE @max_custid INT = xxx

DECLARE @SportType SMALLINT = 200, 
		@BetType SMALLINT = 1611

CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED
	   ,Currency INT
	)

--CREATE TABLE #MemberTemp
--	(
--		CustID INT PRIMARY KEY CLUSTERED
--	   ,Currency INT
--	)


CREATE TABLE #supers (custid int)

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid 
WHERE c.roleid = 4  
	AND s.islicensee = 0
	AND cs.isinternal = 0
	AND ci.username NOT LIKE '3rdSuper%'
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND ci.Enabled = 1
	AND c.site = '789y'
	AND ci.currency IN ( 3
						,16
						,17
						,35
						,36
						,40
						,64
						,65
						,68
						,74)
	
INSERT INTO #SMATemp(CustID,Currency)
SELECT custid, currency
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @max_custid 

--INSERT INTO #MemberTemp(CustID,Currency)
--SELECT custid, currency
--FROM Custinfo WITH (NOLOCK)
--WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 1  AND Enabled = 1 AND custid > @max_custid

--> Update StakeLevelList SMA(s)
UPDATE cs
SET StakeLevelList = SUBSTRING((	SELECT ',' + CONVERT(VARCHAR(5),s.StakeLevelID) 
									FROM StakeLevel s WITH(NOLOCK) 
									WHERE s.ExchangeId = tmp.Currency AND s.GameTypeID = @BetType
									FOR XML PATH(''))
						,2,200)
FROM CustStakeLevel_Agent cs WITH(ROWLOCK)
	INNER JOIN #SMATemp tmp ON cs.CustID = tmp.CustID
WHERE cs.SportType = @SportType
	AND cs.BetType = @BetType

----> Update StakeLevelList Members
--UPDATE cs
--SET StakeLevelList = (	SELECT TOP 1 CONVERT(VARCHAR(5),s.StakeLevelID)
--						FROM StakeLevel s WITH(NOLOCK) 
--						WHERE s.ExchangeId = tmp.Currency AND s.GameTypeID = @BetType
--						ORDER BY s.GameGroupID
--					  )
--	,LastUpdated = GETDATE()
--FROM CustStakeLevel_Member cs WITH(ROWLOCK)
--	INNER JOIN #MemberTemp tmp ON cs.CustID = tmp.CustID
--WHERE cs.SportType = @SportType
--	AND cs.BetType = @BetType

DROP TABLE #SMATemp
--DROP TABLE #MemberTemp
DROP TABLE #supers

