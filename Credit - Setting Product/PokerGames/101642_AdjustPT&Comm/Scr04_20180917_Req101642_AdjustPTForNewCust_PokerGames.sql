/*
	Created: Elodie
	Task: Adjust Setting for newly created customer
	DB: DBCUST/CustDB
	Date: 20180917
*/ 
PRINT N'Step 4: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx
	
CREATE TABLE #supers (custid INT)

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.site IN ('789y')
	AND ci.currency <> 20
	AND ci.custid NOT IN (16) -- dummy account
	AND ci.currency IN (16,64)
	AND ci.username <> 'MPK'

DECLARE @MaxPT TINYINT, @MinPT TINYINT, @Sporttype SMALLINT

SELECT @MaxPT = 80, @Sporttype = 163
	

CREATE TABLE #MemberTemp
(
	CustID INT PRIMARY KEY CLUSTERED,	
	MinPT TINYINT
)

CREATE TABLE #SMATemp
(
	CustID INT PRIMARY KEY CLUSTERED,
	roleid TINYINT,
	MinPT TINYINT
)
	
INSERT INTO #MemberTemp (CustID, MinPT)
SELECT ci.custid, @MaxPT
FROM Custinfo ci WITH (NOLOCK)
	INNER JOIN CustPTSetting3rd_Member cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 1  AND Enabled = 1 AND ci.custid > @maxcustid	
	AND cs.SuperPT = 85 AND cs.SportType = @Sporttype

INSERT INTO #SMATemp (CustID, roleid, MinPT)
SELECT custid, roleid, @MaxPT
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @maxcustid 

UPDATE mem
SET mem.MinPT = 0
FROM #MemberTemp mem
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = mem.custid
	INNER JOIN dbo.custInfo s ON ci.srecommend = s.custid
WHERE s.username IN (	'ABS','ABB','ABW','BBA','BBD','BBE','BBF','SQ','SM','EE','ET','XE','XF','XL','XXC','XXF','EAL','SCV','EH5','EH6',
						'ZW1','ZW2','ZW3','ZW4','ZW5','ZW6','ZW7','ZW8','ZW9','ZW10','ZW11','ZW12','ZW13','ZW14','ZW15','ZW16','ZW17',
						'ZW18','ZW19','ZW20','ZW21','ZW22','ZW23','ZW24','ZW25','ZW26','ZW27','ZW28','ZW29','ZW30','KY48','S05','KP100',
						'KP200','KP300','PV100','TWW','TV','SJK.','XTV','COPA','TK','TKH','SJK','ED24','SC')

--------------------------------------PT Setting-------------------------------------------------	
--SUPER LEVEL
UPDATE cs
SET cs.SuperPT = @MaxPT, cs.MasterPT = @MaxPT, cs.AgentPT = @MaxPT, cs.MinPT = @MinPT
FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
	INNER JOIN #SMATemp ci ON ci.CustID = cs.CustID
WHERE cs.SportType = @Sporttype AND ci.roleid = 4
	
--MASTER, AGENT LEVEL
UPDATE cs
SET cs.SuperPT = CASE WHEN cs.SuperPT = 85 THEN @MaxPT ELSE cs.SuperPT END
FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
	INNER JOIN #SMATemp ci ON ci.CustID = cs.CustID
WHERE cs.SportType = @Sporttype AND ci.roleid IN (2,3)

UPDATE cs
SET cs.SuperPT = CASE WHEN cs.SuperPT = 85 THEN @MaxPT ELSE cs.SuperPT END
FROM dbo.CustPTGroupSetting3rd_Member cs WITH (ROWLOCK)
	INNER JOIN #SMATemp ci ON ci.CustID = cs.AgentID
WHERE cs.SportType = @Sporttype AND ci.roleid IN (2)

--MEMBER LEVEL
UPDATE cs
SET cs.SuperPT = @MaxPT
FROM dbo.CustPTSetting3rd_Member cs WITH (ROWLOCK)
	INNER JOIN #MemberTemp ci ON ci.CustID = cs.CustID
WHERE cs.SportType = @Sporttype

DROP TABLE #SMATemp
DROP TABLE #MemberTemp

PRINT N'Step 4: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 