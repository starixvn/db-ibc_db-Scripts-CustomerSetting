/*
	Creator:	20180906@Robert
	Task:	Initial settings for CWL - Poker Games - CWL Integration add more bettype 1405 - [Redmine: #97810]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20180906@Robert:	Initial settings  - [Redmine: #97810]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings
	@ProductID = 33
   , @BetTypeID_Begin = 0
   , @BetTypeID_End = 0
   , @BettypeIDs = '1405'
   , @GroupID = 19
   , @GroupName = 'Poker Games'
   , @Level101 = 0
   , @Level102 = 0
   , @Level1 = 0
   , @Level2 = 0
   , @Level3 = 50000;