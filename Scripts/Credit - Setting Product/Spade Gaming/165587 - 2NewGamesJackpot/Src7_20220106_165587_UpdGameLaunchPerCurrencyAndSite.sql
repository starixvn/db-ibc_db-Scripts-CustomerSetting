/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:  20220106
	Task:  Update data for GameLaunchPerCurrency, GameLaunchPerSite RedmineID:#165587
	DB:	   DBCust/CustDB
	P/s :  Step 7 Update data for GameLaunchPerCurrency, GameLaunchPerSite
*/

USE CustDB
GO

UPDATE glpc 
SET glpc.IsTest =  0
FROM GameLaunchPerCurrency glpc	WITH (ROWLOCK)
WHERE SportType = 247 AND BetType IN (4599)	 


UPDATE glps
SET glps.IsTest =  0
FROM GameLaunchPerSite glps	WITH (ROWLOCK)
WHERE SportType = 247 AND BetType IN (4599)	
