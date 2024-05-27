/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 2024-05-27
	Created: @Helios
	Task: Database - Initialize Other RNG Casino for PT and Win Loss Limit - Get data  [#205649]
	DB: DBCust/CustDB 
*/

DECLARE
@Srecommend INT = 1201561 

-- Get ProductStatus
SELECT * FROM ProductStatusProfile psp WITH(NOLOCK)  WHERE psp.Sporttype = 208

SELECT roleid, cpa.* 
FROM custInfo i WITH (NOLOCK)
INNER JOIN CustProductStatus cpa WITH (NOLOCK) ON i.custid = cpa.CustID
WHERE i.Enabled = 1
AND	i.roleid IN (1,2,3,4)
AND	i.srecommend = @Srecommend

-- Get PT
SELECT cpa.*
FROM custInfo i WITH (NOLOCK)
INNER JOIN CustPTSetting3rd_Agent cpa WITH (NOLOCK) ON i.custid = cpa.CustID
WHERE i.Enabled = 1
AND	i.roleid IN (2,3,4)
AND	i.srecommend = @Srecommend
AND	cpa.IsLive = 0
AND	cpa.SportType = 208
AND   cpa.BetType = 2101

SELECT cpa.*
FROM custInfo i WITH (NOLOCK)
INNER JOIN CustPTSetting3rd_Member cpa WITH (NOLOCK) ON i.custid = cpa.CustID
WHERE i.Enabled = 1
AND	i.roleid = 1
AND	i.srecommend = @Srecommend
AND	cpa.IsLive = 0
AND	cpa.SportType = 208
AND   cpa.BetType = 2101


-- Get WL
SELECT cpa.*
FROM custInfo i WITH (NOLOCK)
INNER JOIN CustWinLossLimit_Agent cpa WITH (NOLOCK) ON i.custid = cpa.CustID
WHERE i.Enabled = 1
AND	i.roleid IN (2,3,4)
AND	i.srecommend = @Srecommend
AND	cpa.SportType = 208
AND   cpa.BetType = 2101

SELECT cpa.*
FROM custInfo i WITH (NOLOCK)
INNER JOIN CustWinLossLimit_Member cpa WITH (NOLOCK) ON i.custid = cpa.CustID
WHERE i.Enabled = 1
AND	i.roleid = 1
AND	i.srecommend = @Srecommend
AND	cpa.SportType = 208
AND   cpa.BetType = 2101
