/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230426@Johnson
	Task: Data patch ParlayMaxPayout Setting [#RedmineID:#187509]
	DB: DBCUST/CustDB
*/

WITH tmp AS (
SELECT custid, recommend, currency
FROM custinfo ci WITH(NOLOCK)
WHERE custid IN (86458082,86458083,86458084,86458085,86458087,86462506,86462507,86462509,86462511,86462513,86462515,86462516,86462518,86462519,86462520,86499689,86636028,86776796,86776797,86776799,86776800,86776802,86776803,86776804,86776805,86776806,86776807,86911654,86911655,86911741,86912474)
)
INSERT INTO CustMaxPayoutSetting_Member(CustID,SportType,BetType,SingleMatchParlay,Combo2,Combo35,ComboOver6)
SELECT tmp.custid , cs.SportType, cs.BetType, 
		CASE WHEN cs.SingleMatchParlay = 0 THEN mps.SingleMatchParlay  ELSE cs.SingleMatchParlay END AS SingleMatchParlay, 
		CASE WHEN cs.Combo2 = 0 THEN mps.Combo2  ELSE cs.Combo2 END AS Combo2,
		CASE WHEN cs.Combo35 = 0 THEN mps.Combo35  ELSE cs.Combo35 END AS Combo35,
		CASE WHEN cs.ComboOver6 = 0 THEN mps.ComboOver6  ELSE cs.ComboOver6 END AS ComboOver6
FROM dbo.CustMaxPayoutSetting_Agent cs  WITH(NOLOCK)
	INNER JOIN tmp ON cs.custid = tmp.recommend
	LEFT JOIN MaxPayoutGlobalSetting mps WITH(NOLOCK) ON cs.BetType = mps.BetType  AND cs.SportType = mps.SportType AND mps.Currency = tmp.currency
	

