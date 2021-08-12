/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210513@Winfred
	Task: update global setting MaxPayoutGlobalSetting For Mix Sports Parlay [#RM:154104]
	DB: DBCUST/CustDB 
*/


USE CUSTDB
GO

UPDATE MaxPayoutGlobalSetting 
SET SingleMatchParlay = 200000 , Combo2 = 300000 ,Combo35 = 1000000 , ComboOver6 = 4000000
WHERE SportType = 99 AND BetType = 9 AND Currency = 20

--select * from MaxPayoutGlobalSetting