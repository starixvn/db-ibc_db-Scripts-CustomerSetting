/*
	Created: 20190523@Johnson
	Task: Adjust PT = 0.94 for Keno & Lottery for offered licensees
	DB: DBCUST/CustDB
*/
DECLARE @max_custid INT, @srecommend INT
SELECT  @max_custid= xxx ---input maxcustid
CREATE TABLE #Supers (custid INT, isFinished BIT DEFAULT(0))


INSERT INTO #supers(custid)
SELECT s.custid
FROM Dep_CustSuper s WITH(NOLOCK) 
WHERE site IN ('AE88','iBET','Brown888','ANGbet','Hong88')

CREATE TABLE #tblCust (custid INT PRIMARY KEY, mrecommend INT, roleid TINYINT)
DECLARE @tmpSMA TABLE(custid INT PRIMARY KEY, roleid TINYINT)
DECLARE @tmpCust TABLE(Custid INT PRIMARY KEY, roleid TINYINT)
DECLARE @rowcount INT

INSERT INTO #tblCust (custid,roleid,mrecommend)			
SELECT custid,roleid,mrecommend
FROM dbo.Customer WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers)
	AND custid > @max_custid

DELETE #tblCust 
WHERE mrecommend IN (SELECT custid 
					FROM dbo.custinfo WITH(NOLOCK)
					WHERE srecommend=@srecommend 
					AND(username like '%Acc%'  OR username like '%AFF%' OR username like '%LocalBank%')
					AND roleid=3)

--get dummy SMA
INSERT INTO @tmpSMA(custid,roleid)
SELECT custid, roleid
FROM #tblCust
WHERE roleid > 1

--update lottery for dummy SMA
UPDATE cs
SET SuperPT = CASE WHEN roleid = 4 THEN 94 ELSE 0 END,
	MasterPT = CASE WHEN roleid IN (4,3) THEN 94 ELSE 0 END,
	AgentPT = CASE WHEN roleid  IN (4,2) THEN 94 ELSE 0 END
FROM Dep_CustPTSetting_Agent cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN @tmpSMA t ON cs.custid = t.custid
							AND cs.sporttype = 220
							AND cs.bettype = 1021

--update PT group for lottery
UPDATE cs
SET AgentPT = 94 
FROM Dep_CustPTGroupSetting_Member cs WITH(UPDLOCK,ROWLOCK)
WHERE AgentID IN (SELECT custid FROM @tmpSMA WHERE roleid = 2)
	AND cs.sporttype = 220
	AND cs.bettype = 1021
	

WHILE(1=1)
BEGIN		
	DELETE TOP (5000) t
	OUTPUT DELETED.custid, DELETED.roleid INTO @tmpCust
	FROM #tblCust t
	
	SELECT @rowcount = @@rowcount	
	
	--update for keno
	UPDATE cs
	SET spositiontaking = CASE WHEN roleid = 4 THEN 0.94 ELSE 0 END,
		mpositiontaking = CASE WHEN roleid IN (4,3) THEN 0.94 ELSE 0 END,
		apositiontaking = CASE WHEN roleid  IN (4,2,1) THEN 0.94 ELSE 0 END
	FROM CustSettingGame cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN @tmpCust t ON cs.custid = t.custid
								AND cs.sporttype = 202
								AND cs.bettype = 1501
	
	--update for lottery for member level
	UPDATE cs
	SET AgentPT = 94
	FROM Dep_CustPTSetting_Member cs WITH(UPDLOCK,ROWLOCK)
	WHERE custid IN (SELECT custid FROM @tmpCust WHERE roleid = 1)
		AND sporttype = 220
		AND bettype = 1021		
	
	IF @rowcount < 5000
		BREAK;
	
	DELETE @tmpCust
	
	WAITFOR DELAY '0:0:2'		
END			
