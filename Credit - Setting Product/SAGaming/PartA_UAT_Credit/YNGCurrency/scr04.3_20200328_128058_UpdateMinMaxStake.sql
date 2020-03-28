/*
	Created: 20200321@Tiara
	Date: 20200321
	Task: Update StakeLevel for Sexy Gaming and SA Gaming [Redmine: #130678]
	DB: DBCUST/CustDB
*/


UPDATE t
SET MinLabel = REVERSE(STUFF (REVERSE(t.MinLabel),4,0,','))
FROM StakeLevel t
WHERE MinStake > 999 AND T.GameTypeID IN (3001,3101)

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM StakeLevel t
WHERE MaxStake > 999 AND T.GameTypeID IN (3001,3101)

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),8,0,','))
FROM StakeLevel t
WHERE MaxStake > 999999 AND T.GameTypeID IN (3001,3101)
