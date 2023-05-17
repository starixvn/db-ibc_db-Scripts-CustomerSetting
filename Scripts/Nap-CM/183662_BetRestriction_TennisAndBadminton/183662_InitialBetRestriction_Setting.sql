/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: 20230309@Helios
	Date: 2023/03/02
	Task : Initial data Bet Restriction Setting 
	DB: DBCUST/CustDB
	Original:

	Revisions:  
	- 20230309@Helios:  Seize Bet League Group Tennis/Badminton [RedmineID: #183662]

	Example: 
	select * from dbo.f_BetRestrictionSettingSel('BetRestriction_Site',0) 
    
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
           ,[BetLimitStatus])
SELECT 5 , 'BetRestriction_Customer' , 0 , 1 , 1 , 1 , 0
UNION ALL
SELECT 5 , 'BetRestriction_Customer' , 1 , 1 , 1 , 1 , 0
UNION ALL
SELECT 9 , 'BetRestriction_Customer' , 0 , 1 , 1 , 1 , 0
UNION ALL
SELECT 9 , 'BetRestriction_Customer' , 1 , 1 , 1 , 1 , 0
