/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created:	Winfred
	Date:		202200303
	Task:		adjust data WM for currency INR1 RedmineID:#169229
	DB:			DBCust/CustDB
*/

DELETE FROM StakeLevel WITH (ROWLOCK) 
WHERE GameTypeID = 3401 AND ExchangeId = 10  AND MinStake = 500 AND MaxStake = 50000.00000000

