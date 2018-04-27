/*
	Created: Johnson
	Date: 2018-04-24
	Task: update stakelevel global setting for GD
	DB: DBCUST/CustDB
*/

UPDATE sl
SET sl.MaxStake = 20000,
	sl.MaxLabel = '20,000'
FROM dbo.StakeLevel st WITH(UPDLOCK,ROWLOCK)
WHERE GameTypeID IN (1701,1702)
	AND exchangeid IN (5,13,67)--HK$, HKK, RMB
	AND maxStake = 25000
				
DELETE dbo.StakeLevel st WITH(UPDLOCK,ROWLOCK)
WHERE exchangeid IN (3,6,9,12,16,17,35,40,64,74)--UT, Yen, US$, $US, TH, NTD, EURO,IRR, AUD, GBP, SD
	AND GameTypeID IN (1701,1702)
	AND 1 = CASE WHEN (MinStake = 100 AND MaxStake = 5000 )
					OR (MinStake = 5 AND MaxStake = 5000) THEN 1 ELSE 0 END