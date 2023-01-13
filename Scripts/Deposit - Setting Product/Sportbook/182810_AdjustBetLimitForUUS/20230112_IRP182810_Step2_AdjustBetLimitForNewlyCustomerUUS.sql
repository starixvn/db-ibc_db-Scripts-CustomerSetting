/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230112@Johnson
	Task: update bet limit for SB UUS customers [Redmine: #182810]
	DB: DBCUST/CustDB
*/

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
WHERE c.roleid = 4  
	AND s.islicensee = 1
	AND ci.Enabled = 1	
	AND c.currency = 20 
	AND s.site IN (SELECT LicenseeName FROM  bodb_Licensee.dbo.Licensees WITH(NOLOCK) WHERE IsActive = 1)
	
CREATE TABLE #tblmrecommend  (CustID INT PRIMARY KEY)
CREATE TABLE #tblSMA (custid INT PRIMARY KEY, roleid TINYINT)
CREATE TABLE #tblCust (CustID INT PRIMARY KEY)	
CREATE TABLE #SportBettype (SportType SMALLINT, Bettype SMALLINT)
DECLARE @tmpCust TABLE (custid INT PRIMARY KEY)

DECLARE @MinBet MONEY = 1,
	@MaxBet MONEY= 1000,
	@MaxPerMatch  MONEY = 10000,
	@MaxPayoutPerMatch MONEY = 80000

INSERT INTO #SportBettype (SportType,Bettype)
SELECT DISTINCT SportType,Bettype
FROM Dep_ProductSetting ps WITH(NOLOCK) 
	INNER JOIN Dep_ProductSettingDetail d WITH(NOLOCK) ON ps.ProductSettingID=d.ProductSettingID  
WHERE ProductID = 1 
	AND SettingType IN (10,12)

INSERT INTO #tblmrecommend(CustID)
SELECT c.custid 
FROM custinfo c WITH (NOLOCK) 
WHERE  c.srecommend IN (SELECT custid FROM #supers)
	AND roleid=3 
	and (username LIKE '%Acc%' OR username LIKE '%LocalBank%' 
					OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')	
					
INSERT INTO #tblSMA(custid,roleid)
SELECT custid, roleid
FROM custinfo ci WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers)
	AND mrecommend NOT IN (SELECT custid FROM #tblmrecommend)
	AND roleid> 1
	AND Enabled = 1
	AND custid > @max_custid	

UPDATE cs 
SET cs.MinBet = @MinBet,
	cs.MaxBet = @MaxBet,
	cs.MaxPerMatch = @MaxPerMatch,
	cs.MaxPayoutPerMatch = @MaxPayoutPerMatch
FROM Dep_CustBetSettingGame_Agent cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #SportBettype s ON cs.SportType = s.SportType AND cs.Bettype = s.Bettype
WHERE custid IN (SELECT custid FROM #tblSMA)

UPDATE cs 
SET cs.MinBet = @MinBet,
	cs.MaxBet = @MaxBet,
	cs.MaxPerMatch = @MaxPerMatch,
	cs.MaxPayoutPerMatch = @MaxPayoutPerMatch
FROM Dep_CustBetSettingGameGroup_Member cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #SportBettype s ON cs.SportType = s.SportType AND cs.Bettype = s.Bettype
WHERE AgentID IN (SELECT custid FROM #tblSMA WHERE roleid =2)	

INSERT INTO #tblCust(CustID)
SELECT c.CustID
FROM Customer c WITH(NOLOCK)				
	INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON c.custid = m.CustID
WHERE c.srecommend IN (SELECT custid FROM #supers)
	AND mrecommend NOT IN (SELECT custid FROM #tblmrecommend)
	AND c.roleid =1	
	AND ISNULL(m.IsGroupedBetLimit,0) = 0
	AND c.custid > @max_custid
	
WHILE(1=1)
BEGIN	
	DELETE TOP (300) t
	OUTPUT DELETED.custid INTO @tmpCust(custid)
	FROM #tblCust t
	
	IF @@ROWCOUNT = 0
		BREAK;
		
	UPDATE cs
	SET	cs.MinBet = @MinBet,
		cs.MaxBet = @MaxBet,
		cs.MaxPerMatch = @MaxPerMatch,
		cs.MaxPayoutPerMatch = @MaxPayoutPerMatch
	FROM Dep_CustBetSettingGame_Member cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #SportBettype s ON cs.SportType = s.SportType AND cs.Bettype = s.Bettype
	WHERE custid IN (SELECT custid FROM @tmpCust)	
	
	DELETE @tmpCust
END

DROP TABLE #tblSMA
DROP TABLE #tblmrecommend
DROP TABLE #tblCust
DROP TABLE #SportBettype	