/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Tina@20201210
	Task: Correct StakeLevel [RedmineID: #144105]
	DB: DBCUST/CustDB
	Description: this script only run on SIT
*/ 


UPDATE SL SET MaxLabel = '20,000',
			  MaxStake = 20000
FROM StakeLevel SL WITH (ROWLOCK)
WHERE SL.GameTypeID = 5701 AND ExchangeId = 43 -- THB(THB)
	AND MinStake = 30 AND MaxStake = 15000

UPDATE SL SET MaxLabel = '800',
			  MaxStake = 800
FROM StakeLevel SL WITH (ROWLOCK)
WHERE SL.GameTypeID = 5701 AND ExchangeId = 69 --MMK(MMK)
	AND MinStake = 5 AND MaxStake = 250