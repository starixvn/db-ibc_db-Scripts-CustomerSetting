/*
	Created: 20190530@Johnson
	DB: DBCUST/CUSTDB
	Task: correct PT setting for newly customers under direct masters for custsettinggame table
*/


DECLARE @max_custid INT, @srecommend INT
SELECT  @max_custid= xxx ---input maxcustid

CREATE TABLE #Supers (custid INT)
CREATE TABLE #DirectMaster (CustID INT)

CREATE TABLE #tblCust (custid INT, roleid TINYINT, sporttype SMALLINT, bettype SMALLINT, spositiontaking SMALLMONEY, mpositiontaking SMALLMONEY)
DECLARE @tmpCust TABLE(Custid INT, roleid TINYINT, sporttype SMALLINT, bettype SMALLINT, spositiontaking SMALLMONEY, mpositiontaking SMALLMONEY)
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

INSERT INTO #tblCust (custid,roleid,sporttype,bettype,spositiontaking,mpositiontaking)			
SELECT ci.custid,roleid,sporttype,bettype,spositiontaking,mpositiontaking
FROM dbo.custinfo ci WITH(NOLOCK)
	INNER JOIN CustSettingGame cs WITH(NOLOCK) ON ci.custid = cs.custid
WHERE mrecommend IN (SELECT custid FROM #DirectMaster)	
	AND roleid IN (1,3)
	AND enabled = 1
	AND ci.custid > @max_custid
	AND sporttype <> 162
	AND spositiontaking <> 0	
	
WHILE(1=1)
BEGIN			
	DELETE TOP (5000) t
	OUTPUT DELETED.custid, DELETED.roleid, DELETED.sporttype, DELETED.bettype, DELETED.spositiontaking, DELETED.mpositiontaking 
	INTO @tmpCust(custid,roleid,sporttype,bettype,spositiontaking,mpositiontaking)
	FROM #tblCust t
	
	SELECT @rowcount = @@rowcount	
	
	UPDATE cs
	SET cs.spositiontaking = 0,
		cs.mpositiontaking = CASE WHEN roleid = 3 THEN t.mpositiontaking + t.spositiontaking ELSE cs.mpositiontaking END
	FROM custsettinggame cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN @tmpCust t ON cs.custid = t.custID
								AND cs.sporttype = t.sporttype
								AND cs.bettype = t.bettype
		
	IF @rowcount < 5000
		BREAK;
	
	DELETE @tmpCust
	
	WAITFOR DELAY '0:0:2'--wait 2s for replicate others cmd
END

DROP TABLE #tblCust
DROP TABLE #DirectMaster	
DROP TABLE #Supers