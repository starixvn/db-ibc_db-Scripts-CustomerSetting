/*
	Created: 20190808@Elodie	
	Task: Adjust bet setting [Redmine: #117459]
	DB: DBCUST/CustDB
*/

UPDATE pb 
SET pb.MaxPerEvent = MaxPerEvent * 1000, 
	pb.MaxBet = MaxBet * 1000
FROM CS_ProductBetSetting pb WITH (ROWLOCK)
WHERE Currency = 20

SELECT DISTINCT ci.custid, ci.roleid INTO #tmpCust
FROM CS_CustBetSetting_Agent cs WITH (NOLOCK)
	INNER JOIN Custinfo ci WITH (NOLOCK) ON cs.custid = ci.custid
	INNER JOIN CS_ProductBetSetting ps WITH (NOLOCK) ON cs.SportType = ps.SportType AND cs.BetType = ps.BetType AND cs.IsLive = ps.IsLive AND ci.currency = ps.Currency
WHERE (cs.MaxBet > ps.MaxBet OR cs.MaxPerEvent > ps.MaxPerEvent)
	AND ci.currency = 20 
	AND ci.username NOT IN ('SupertestTE41', 'SupertestTE31')
	
INSERT INTO #tmpCust (CustId, roleid)
SELECT DISTINCT ci.CustId, ci.roleid
FROM CS_CustBetSetting_Agent cs WITH (NOLOCK)
	INNER JOIN Custinfo ci WITH (NOLOCK) ON cs.custid = ci.custid
	INNER JOIN CS_ProductBetSetting ps WITH (NOLOCK) ON cs.SportType = ps.SportType AND cs.BetType = ps.BetType AND cs.IsLive = ps.IsLive AND ci.currency = ps.Currency
WHERE (cs.MaxBet > ps.MaxBet OR cs.MaxPerEvent > ps.MaxPerEvent)
	AND ci.currency <> 20
	AND ci.username IN ('OPSTestCY1','OPSTestCY2','OPSTestCY3','OPSTestCY4','OPSTestCY100','OPSTestCY10000','OPSTestCY200','OPSTestCY20000','OPSTestCY300',
						'OPSTestCY30000','OPSTestCY400','OPSTestCY40000','OPSTestCY10002','OPSTestCY10003')

UPDATE cs
SET cs.MaxBet = CASE WHEN cs.MaxBet > ps.MaxBet THEN ps.MaxBet ELSE cs.MaxBet END,
	cs.MaxPerEvent = CASE WHEN cs.MaxPerEvent > ps.MaxPerEvent THEN ps.MaxPerEvent ELSE cs.MaxPerEvent END
FROM CS_CustBetSetting_Agent cs WITH (ROWLOCK)
	INNER JOIN Custinfo ci WITH (NOLOCK) ON cs.custid = ci.custid
	INNER JOIN #tmpCust t ON t.CustId = ci.custid
	INNER JOIN CS_ProductBetSetting ps WITH (NOLOCK) ON cs.SportType = ps.SportType AND cs.BetType = ps.BetType AND cs.IsLive = ps.IsLive AND ci.currency = ps.Currency

UPDATE cs
SET cs.MaxBet = CASE WHEN cs.MaxBet > ps.MaxBet THEN ps.MaxBet ELSE cs.MaxBet END,
	cs.MaxPerEvent = CASE WHEN cs.MaxPerEvent > ps.MaxPerEvent THEN ps.MaxPerEvent ELSE cs.MaxPerEvent END
FROM dbo.CS_CustBetSetting_Member cs WITH (ROWLOCK)
	INNER JOIN Custinfo ci WITH (NOLOCK) ON cs.custid = ci.custid
	INNER JOIN #tmpCust t ON t.CustId = ci.custid
	INNER JOIN CS_ProductBetSetting ps WITH (NOLOCK) ON cs.SportType = ps.SportType AND cs.BetType = ps.BetType AND cs.IsLive = ps.IsLive AND ci.currency = ps.Currency

DROP TABLE #tmpCust