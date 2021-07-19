/*
	Creator:	20180718@Robert
	Task:	Initial settings for CWL - Poker Games - CWL Integration - [Redmine: #97810]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20180424@Robert:	Initial settings  - [Redmine: #97810]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings
	@ProductID = 33
   , @BetTypeID_Begin = 0
   , @BetTypeID_End = 0
   , @BettypeIDs = '1401,1402,1403,1404,1499'
   , @GroupID = 19
   , @GroupName = 'Poker Games'
   , @Level101 = 0
   , @Level102 = 0
   , @Level1 = 0
   , @Level2 = 0
   , @Level3 = 50000;