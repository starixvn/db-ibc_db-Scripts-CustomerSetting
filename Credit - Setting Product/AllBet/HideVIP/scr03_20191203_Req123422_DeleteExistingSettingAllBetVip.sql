/*
	Created: Winnie
	Date: 20191203
	Task: Delete existing data of Sporttype=211 bettype 2402 RedmineID:#124422
	DB: DBCust/CustDB
*/
 
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
DECLARE @maxcustid INT,@Sporttype SMALLINT,@Bettype INT 
	
SELECT @Sporttype = 211
SELECT @Bettype=2402
SELECT @maxcustid=xxx

CREATE TABLE #supers (custid int,isfinished bit default(0))

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
 INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
 LEFT JOIN custsuper cs WITH (NOLOCK) ON c.custid = cs.custid
WHERE c.roleid = 4  
 AND c.username NOT LIKE '3rdSuper%'
 AND cs.isinternal = 0
 AND c.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
 AND s.islicensee = 0  
 AND c.Site<>'CN88'

CREATE TABLE #TempCust(CustID INT)
INSERT INTO  #TempCust(CustID)
SELECT c.custid
FROM Custinfo c WITH (NOLOCK)
WHERE c.srecommend IN(SELECT CustID FROM #supers)
	AND c.custid>@maxcustid

DELETE  a 
FROM CustStakeLevel_Agent a WITH(ROWLOCK) 
	INNER JOIN #TempCust t ON a.CustID=t.CustID
WHERE SportType=@Sporttype AND Bettype=@Bettype

DELETE  a 
FROM CustStakeLevel_Member a WITH(ROWLOCK) 
	INNER JOIN #TempCust t ON a.CustID=t.CustID
WHERE SportType=@Sporttype AND Bettype=@Bettype
