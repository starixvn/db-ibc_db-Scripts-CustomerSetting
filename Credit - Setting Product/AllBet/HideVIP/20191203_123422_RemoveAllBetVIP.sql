
/*
	Created: 20191203@Winnie
	Task: Allbet - VIP Bac Customer Setting RedmineID:#124422	
	DB: DBCUST/CUSTDB
*/


DELETE  FROM ProductSettingDetail WITH(ROWLOCK) WHERE BetType=2402
DELETE  FROM ProductStatusProfile WITH(ROWLOCK) WHERE BetType=2402