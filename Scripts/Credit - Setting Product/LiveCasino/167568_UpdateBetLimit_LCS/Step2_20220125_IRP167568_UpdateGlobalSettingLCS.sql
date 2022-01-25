/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220125@Johnson
	Task: BigGaming & WM Live Casino - Request to remove bet limit range for THB, HKK, HK$, RM		
	DB: DBCust/CustDB
*/

--run this step after done verify step 1
DELETE s
FROM StakeLevel s WITH(ROWLOCK)
WHERE GameTypeID IN (3401,3501)
AND ExchangeId IN (2,5,43,67)
AND 1= CASE WHEN ExchangeId = 43 AND ((GameTypeID = 3401 AND MinStake = 500 AND MaxStake = 50000)
									OR (GameTypeID = 3501 AND MinStake = 5000 AND MaxStake = 100000)) THEN 1
			WHEN ExchangeId IN (2,5,67) AND MinStake = 100 AND MaxStake = 10000 THEN 1
			ELSE 0 END