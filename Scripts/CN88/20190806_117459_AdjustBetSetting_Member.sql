/*
	Created: 20190816@Elodie	
	Task: Adjust bet setting for member[Redmine: #117459]
	DB: DBCUST/CustDB
*/

SELECT DISTINCT ci.custid, ci.roleid INTO #tmpCust
FROM CS_CustBetSetting_Member cs WITH (NOLOCK)
	INNER JOIN Custinfo ci WITH (NOLOCK) ON cs.custid = ci.custid
	INNER JOIN CS_ProductBetSetting ps WITH (NOLOCK) ON cs.SportType = ps.SportType AND cs.BetType = ps.BetType AND cs.IsLive = ps.IsLive AND ci.currency = ps.Currency
WHERE (cs.MaxBet > ps.MaxBet OR cs.MaxPerEvent > ps.MaxPerEvent)

UPDATE cs
SET cs.MaxBet = CASE WHEN cs.MaxBet > ps.MaxBet THEN ps.MaxBet ELSE cs.MaxBet END,
	cs.MaxPerEvent = CASE WHEN cs.MaxPerEvent > ps.MaxPerEvent THEN ps.MaxPerEvent ELSE cs.MaxPerEvent END
FROM dbo.CS_CustBetSetting_Member cs WITH (ROWLOCK)
	INNER JOIN Custinfo ci WITH (NOLOCK) ON cs.custid = ci.custid
	INNER JOIN #tmpCust t ON t.CustId = ci.custid
	INNER JOIN CS_ProductBetSetting ps WITH (NOLOCK) ON cs.SportType = ps.SportType AND cs.BetType = ps.BetType AND cs.IsLive = ps.IsLive AND ci.currency = ps.Currency

DROP TABLE #tmpCust