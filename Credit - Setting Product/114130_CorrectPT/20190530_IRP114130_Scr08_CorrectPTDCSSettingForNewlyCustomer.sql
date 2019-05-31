/*
	Created: 20190530@Johnson
	DB: DBCUST/CUSTDB
	Task: correct PT setting for newly customers under dummy masters for DCS setting table
*/
DECLARE @max_custid INT, @srecommend INT
SELECT  @max_custid= xxx ---input maxcustid

CREATE TABLE #Supers (custid INT)
CREATE TABLE #DirectMaster (CustID INT)
CREATE TABLE #tblCust (custid INT, sporttype SMALLINT, bettype SMALLINT)
DECLARE @tmpCust TABLE(Custid INT, sporttype SMALLINT, bettype SMALLINT)
DECLARE @rowcount INT
	
	
INSERT INTO #Supers(custid)				
SELECT ci.custid				
FROM Customer ci WITH (NOLOCK)				
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site				
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid				
WHERE ci.roleid = 4				
	AND ci.username NOT LIKE '3rdSuper%'				
	AND cs.isinternal = 0				
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))				
	AND s.islicensee = 0				
	AND ci.currency <> 20				
	AND ci.site<>'CN88'	
														
--- get direct master													
INSERT INTO #DirectMaster (CustID)													
SELECT ci.custid												
FROM custInfo ci WITH(NOLOCK) 										
WHERE  EXISTS (SELECT custid 
				FROM dbo.CustDirectAccount WITH(NOLOCK) 
				WHERE CustID = ci.custid)													
	AND ci.roleid=3 
	AND ci.srecommend in (select custid from #Supers)												

INSERT INTO #tblCust (custid,sporttype,bettype)			
SELECT ci.custid,sporttype,bettype
FROM dbo.custinfo ci WITH(NOLOCK)
	INNER JOIN CustPTSetting3rd_Member cs WITH(NOLOCK) ON ci.custid = cs.custid
WHERE ci.custid > @max_custid
	AND mrecommend IN (SELECT custid FROM #DirectMaster)
	AND roleid = 1
	AND enabled = 1
	AND SuperPT <> 0	

DECLARE @new_m3 TINYINT

--correct PT on master if any
UPDATE cs
SET @new_m3 = SuperPT + MasterPT,
	SuperPT = 0,
	MasterPT = @new_m3
FROM CustPTSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
WHERE custid IN (SELECT custid FROM #DirectMaster)
	AND SuperPT <> 0
	AND custid > @max_custid
	
WHILE(1=1)
BEGIN			
	DELETE TOP (5000) t
	OUTPUT DELETED.custid, DELETED.sporttype, DELETED.bettype
	INTO @tmpCust(custid,sporttype,bettype)
	FROM #tblCust t
	
	SELECT @rowcount = @@rowcount	
	
	UPDATE cs
	SET SuperPT = 0		
	FROM CustPTSetting3rd_Member cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN @tmpCust t ON cs.custid = t.custID
								AND cs.sporttype = t.sporttype
								AND cs.bettype = t.bettype
		
	IF @rowcount < 5000
		BREAK;
	
	DELETE @tmpCust
		
	WAITFOR DELAY '0:0:2'
END

DROP TABLE #tblCust
DROP TABLE #DirectMaster	
DROP TABLE #Supers