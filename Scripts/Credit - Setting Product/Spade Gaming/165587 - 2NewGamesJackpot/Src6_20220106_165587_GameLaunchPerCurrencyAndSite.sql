/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:  20220106
	Task:  initial data for GameLaunchPerCurrency, GameLaunchPerSite RedmineID:#165587
	DB:	   DBCust/CustDB
	P/s :  Step 6 initial data for GameLaunchPerCurrency, GameLaunchPerSite
*/
USE CustDB
GO

DECLARE @SportBettype TABLE (SportType SMALLINT, BetType SMALLINT)
INSERT INTO @SportBettype(SportType, BetType) VALUES (247, 4599)

INSERT INTO GameLaunchPerCurrency(SportType,BetType,Currency,IsLaunched,IsTest)
SELECT t.SportType ,t.BetType,exchangeid,1,1
FROM exchange d WITH(NOLOCK)
CROSS APPLY @SportBetType t


INSERT INTO GameLaunchPerSite(SportType,BetType,[SiteId],IsLaunched,IsTest)
SELECT t.SportType ,t.BetType,[siteId],1,1
FROM [Site] d WITH(NOLOCK)
CROSS APPLY @SportBetType t
