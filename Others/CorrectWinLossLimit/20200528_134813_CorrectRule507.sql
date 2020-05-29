/*
	Created: 20200528@Elodie
	DB: DBCUST/CustDB
	Task: Correct rule 507
*/
USE CustDB
GO

UPDATE cs 
SET MaxWinLimit = ucs.MaxWinLimit
FROM CustWinLossLimit_Agent cs WITH (ROWLOCK)
	INNER JOIN Custinfo ci WITH (NOLOCK) ON cs.CustId = ci.custid
	INNER JOIN CustWinLossLimit_Agent ucs WITH (NOLOCK) ON ci.srecommend = ucs.CustId AND cs.SportType = ucs.SportType AND cs.BetType = ucs.BetType
WHERE cs.custid IN (26985540)
	AND ((cs.SportType = 211 AND cs.BetType = 2401) OR (cs.SportType = 241 AND cs.BetType = 3300)
		OR (cs.SportType = 244 AND cs.BetType = 3001) OR (cs.SportType = 243 AND cs.BetType = 3101))

UPDATE cs 
SET MaxWinLimit = ucs.MaxWinLimit
FROM Custwinlimit cs WITH (ROWLOCK)
	INNER JOIN Custinfo ci WITH (NOLOCK) ON cs.CustId = ci.custid
	INNER JOIN CustWinLimit ucs WITH (NOLOCK) ON ci.srecommend = ucs.CustId AND cs.SportType = ucs.SportType AND cs.BetType = ucs.BetType
WHERE cs.custid IN (397965
,406706
,406736
,406746
,838369
,850213
,850221
,854930
,855024
,1308248
,1320187
,1334588
,1686658
,1804147
,2136689
,2143468
,2254733
,2405002
,2469127
,2513404
,2951403
,2959247
,3506381
,5044511
,5363273
,7764600
,10225026
,14067548
,17852986
,17985057
,18557267
)
	AND cs.SportType = 208 AND cs.BetType = 2101