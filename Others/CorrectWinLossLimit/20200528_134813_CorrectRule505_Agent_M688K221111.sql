/*
	Created: 20200605@Elodie
	DB: DBCUST/CustDB
	Task: Correct rule 505
*/
USE CustDB
GO

UPDATE cs 
SET MaxLossLimit = 100000
FROM Custwinlimit cs WITH (ROWLOCK)
WHERE cs.SportType = 208 AND cs.BetType = 2101
	AND custid = 972611
