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

INSERT INTO [dbo].[BetRestriction_Setting]
           ([SportType]
           ,[RestrictionLevel]
           ,[IsLicensee]
           ,[BackEndStatus]
           ,[LiveBetAcceptStatus]
           ,[SeizeBetTicketStatus]
           ,[BetLimitStatus]
		   ,[RepUpdateTime])
SELECT 43 , 'BetRestriction_Customer' , 0 , 1 , 1 , 1 , 0, [dbo].[f_GetDateTime2]()
UNION ALL
SELECT 43 , 'BetRestriction_Customer' , 1 , 1 , 1 , 1 , 0, [dbo].[f_GetDateTime2]()
