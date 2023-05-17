/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created by: 20230309@Helios
	Task : Update data BackEndStatus Bet Restriction Setting Release
	DB: DBCUST/CustDB
	Original:

	Revisions:  
	- 20230309@Helios:  Seize Bet League Group Tennis/Badminton [RedmineID: #183662]

	Example: 
	select * from dbo.f_BetRestrictionSettingSel('BetRestriction_Site',0) 
    
*/

USE [CustDB]
GO

UPDATE bs SET BackEndStatus = 0
FROM BetRestriction_Setting bs WITH (ROWLOCK , UPDLOCK) 
WHERE RestrictionLevel = 'BetRestriction_Customer' AND SportType IN (5,9)