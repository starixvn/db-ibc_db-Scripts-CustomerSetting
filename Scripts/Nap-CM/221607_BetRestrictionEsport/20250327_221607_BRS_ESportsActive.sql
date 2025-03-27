/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: 20250327@Winfred
	Task : Seize Bet Customer - Bet Restriction - E-Sports 
	DB: DBCUST/CustDB
	Original:

	Revisions:  
	- 20250327@Winfred:  Seize Bet Customer - Bet Restriction - E-Sports [RedmineID: #221607]

	Sports: 
	select * from dbo.f_BetRestrictionSettingSel('BetRestriction_Customer',0) 
    
*/
USE CustDB 
GO

UPDATE bs 
SET BackEndStatus = 0
	,[RepUpdateTime] = [dbo].[f_GetDateTime2]()
FROM BetRestriction_Setting bs WITH (ROWLOCK , UPDLOCK) 
WHERE RestrictionLevel = 'BetRestriction_Customer' AND SportType IN (43)
