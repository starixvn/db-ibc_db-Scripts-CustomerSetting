/*
	Created: Tiara
	Date: 2020-01-16
	Task: Update StakeLevel of Allbet for defined currency
	DB: DBCUST/CUSTDB
*/
UPDATE S
SET S.ResourceId = 25, S.MinStake = 2, S.MinLabel='2', S.MaxStake=200, S.MaxLabel='200'
FROM StakeLevel S WITH(UPDLOCK,ROWLOCK)
WHERE S.ResourceId = 2 
	AND S.MinStake = 50 
	AND S.MaxStake = 5000
	AND S.ExchangeId IN (35,3,17,64,16,40,6,1,12,74)--$US, NTD, US$, UT, Yen, IRR, EURO, SD$, GBP, TH
	AND GameTypeID = 2401
