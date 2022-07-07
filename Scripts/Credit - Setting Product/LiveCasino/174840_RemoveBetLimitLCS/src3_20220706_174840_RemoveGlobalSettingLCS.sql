/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220706
	Task: WM - Remove highest bet limit of IDR currency (DDD, IDD, IND, IN, IDR) for IBCIndo and INDO RedmineID:#174840
	DB: DBCust/CustDB
*/

--run this step after done verify step 2
DELETE s
FROM StakeLevel s WITH(ROWLOCK)
WHERE GameTypeID IN (3401)
AND ExchangeId IN (15,22,33,34,47) --IN,IND,IDD,IDR,DDD
AND MinStake = 500 AND MaxStake = 50000