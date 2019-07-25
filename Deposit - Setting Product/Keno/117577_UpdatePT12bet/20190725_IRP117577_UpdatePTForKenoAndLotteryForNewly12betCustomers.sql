/*
	Created: 20190725@Johnson
	Task: update PT setting for keno & Lottery for newly 12bet customers
	DB: DBCUST/CustDB
*/

CREATE TABLE #tblCust (custid INT PRIMARY KEY, mrecommend INT, roleid TINYINT)
CREATE TABLE #SMA (custID INT, roleid TINYINT)
DECLARE @tmpCust TABLE(Custid INT PRIMARY KEY, roleid TINYINT)
DECLARE @rowcount INT,
		@max_custid INT	 =xxx

CREATE TABLE #Supers (custid INT, isFinished BIT DEFAULT(0))

INSERT INTO #supers(custid)
SELECT custid
FROM Dep_CustSuper s WITH(NOLOCK)
WHERE site = '12bet'

INSERT INTO #tblCust (custid,roleid,mrecommend)			
SELECT custid,roleid,mrecommend
FROM dbo.Customer WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers)
	AND custid > @max_custid

DELETE #tblCust 
WHERE mrecommend IN (SELECT custid 
					FROM dbo.custinfo WITH(NOLOCK)
					WHERE srecommend IN (SELECT custid FROM #supers)
					AND(username like '%Acc%'  OR username like '%AFF%' OR username like '%LocalBank%')
					AND roleid=3)


--update for Lottery
INSERT INTO #SMA(custid,roleid)
SELECT custid, roleid
FROM #tblCust 
WHERE roleid > 1
	
UPDATE cs
SET SuperPT = CASE WHEN roleid = 4 THEN 94 ELSE SuperPT END,
	MasterPT = CASE WHEN roleid IN (3,4) THEN 94 ELSE MasterPT END,
	AgentPT = CASE WHEN roleid IN (2,4) THEN 94 ELSE AgentPT END
FROM dbo.Dep_CustPTSetting_Agent cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #SMA s ON cs.custid = s.custid
WHERE cs.sporttype = 220
	AND cs.bettype = 1021

--update PT Group member for Lottery
UPDATE cs
SET AgentPT = 94
FROM dbo.Dep_CustPTGroupSetting_Member cs WITH(UPDLOCK,ROWLOCK)		
WHERE cs.custid IN (SELECT custid FROM #SMA WHERE roleid = 2)
	AND cs.sporttype = 220
	AND cs.bettype = 1021

--Update for Keno
WHILE(1=1)
BEGIN		
	DELETE TOP (5000) t
	OUTPUT DELETED.custid, DELETED.roleid INTO @tmpCust
	FROM #tblCust t
	
	SELECT @rowcount = @@rowcount
	
	UPDATE cs
	SET spositiontaking = CASE WHEN roleid IN (4) THEN 0.94 ELSE spositiontaking END,
		mpositiontaking = CASE WHEN roleid IN (4,3) THEN 0.94 ELSE mpositiontaking END,
		apositiontaking = CASE WHEN roleid IN (4,2,1) THEN 0.94 ELSE apositiontaking END
	FROM CustSettingGame cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN @tmpCust t ON cs.custid = t.custid
	WHERE sporttype = 202
		AND bettype = 1501
	
	IF @rowcount < 5000 
		BREAK;
	
	DELETE @tmpCust
	
	WAITFOR DELAY '0:0:0.01'
END	
	
DROP TABLE #tblCust
DROP TABLE #SMA