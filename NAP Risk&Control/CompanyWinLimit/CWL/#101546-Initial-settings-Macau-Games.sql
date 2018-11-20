/*
	Creator:	20180917@Robert
	Task:	Initial settings for CWL - Macau Games - CWL Integration - [Redmine: #101546]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20180424@Robert:	Initial settings  - [Redmine: #101546]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings
	@ProductID = 22
   , @BetTypeID_Begin = 0
   , @BetTypeID_End = 0
   , @BettypeIDs = '4031,4032,4033,4034,4035,4036,4037'
   , @GroupID = 10
   , @GroupName = 'Macau Games'
   , @Level101 = -20000
   , @Level102 = -50000
   , @Level1 = 20000
   , @Level2 = 50000
   , @Level3 = 100000;