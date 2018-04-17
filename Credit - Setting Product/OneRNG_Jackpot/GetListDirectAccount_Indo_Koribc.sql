DECLARE @srecommend INT = 15

CREATE TABLE #OfferedSite (site VARCHAR(10))
INSERT INTO #OfferedSite (site)
VALUES  ('Indo'), ('KORIBC')
	          
CREATE TABLE #DirectMaster (CustID INT PRIMARY KEY,roleid INT)
CREATE TABLE #DirectAgent (CustID INT PRIMARY KEY,mrecommend INT,roleid INT)
CREATE TABLE #DirectMember (CustID INT PRIMARY KEY,recommend INT,mrecommend INT,roleid INT)			

--- get direct master
INSERT INTO #DirectMaster (CustID,roleid)
SELECT ci.custid, ci.roleid
FROM Customer ci with(nolock)
INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
WHERE  EXISTS (SELECT 1 FROM #OfferedSite WHERE site = ci.site)
	AND  EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
	AND ci.roleid=3 AND ci.srecommend = @srecommend 
	AND c.Enabled=1
		
--- get direct agent
INSERT INTO #DirectAgent (CustID,mrecommend,roleid)
SELECT ci.custid, ci.mrecommend,ci.roleid
FROM Customer ci WITH(NOLOCK)
INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
WHERE  EXISTS (SELECT 1 FROM #OfferedSite WHERE site = ci.site)
	AND  EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
	and ci.roleid = 2 AND ci.srecommend = @srecommend 
	AND c.Enabled=1

INSERT INTO #DirectMember(CustID,recommend,mrecommend,roleid)
SELECT c.custid, c.recommend,c.mrecommend,c.roleid
FROM Customer c WITH(NOLOCK)
INNER JOIN Customer ca (nolock) on c.recommend=ca.custid 
INNER JOIN custInfo ci WITH(NOLOCK) ON ci.custid=c.custid
WHERE EXISTS (SELECT 1 FROM #OfferedSite WHERE site = ca.site)
	AND EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
	AND c.roleid=1 AND c.srecommend = @srecommend 		
	AND ci.Enabled=1

SELECT * FROM #DirectAgent

SELECT * FROM #DirectMaster

SELECT * FROM #DirectMember