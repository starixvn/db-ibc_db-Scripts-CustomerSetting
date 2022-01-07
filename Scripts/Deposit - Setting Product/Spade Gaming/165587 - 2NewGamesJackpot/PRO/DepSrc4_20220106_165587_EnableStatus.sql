/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220106
	Task:  Update Setting Status for SG Jackpot RedmineID:#165587
	DB: DBCust/CustDB
	P/s :  Step 4 Update Setting Status for SG Jackpot
*/


DECLARE @Sporttype INT = 247

UPDATE dp
SET dp.SettingStatus = 0 
FROM Dep_ProductSettingDetail dp WITH(ROWLOCK, UPDLOCK)
WHERE Sporttype = @Sporttype