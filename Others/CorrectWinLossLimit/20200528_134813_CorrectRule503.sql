/*
	Created: 20200528@Elodie
	DB: DBCUST/CustDB
	Task: Correct rule 503
*/
USE CustDB
GO

UPDATE cs 
SET MaxWinLimit = ucs.MaxWinLimit
FROM Custwinlimit cs WITH (ROWLOCK)
	INNER JOIN CustWinLimit ucs WITH (NOLOCK) ON cs.SportType = ucs.SportType AND cs.BetType = ucs.BetType
WHERE cs.custid = 19984266
	AND ucs.CustId = 14231202
	AND cs.SportType = 255 AND cs.BetType = 1701