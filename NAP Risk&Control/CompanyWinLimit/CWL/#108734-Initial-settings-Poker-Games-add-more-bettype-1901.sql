/*
	Creator:	20190213@Robert
	Task:	Initial settings for CWL - Poker Games - CWL Integration add more bettype 1901 - [Redmine: #108734]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20190213@Robert:	Initial settings  - [Redmine: #108734]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings
	@ProductID = 33
   , @BetTypeID_Begin = 0
   , @BetTypeID_End = 0
   , @BettypeIDs = '1901'
   , @GroupID = 19
   , @GroupName = 'Poker Games'
   , @Level101 = 0
   , @Level102 = 0
   , @Level1 = 0
   , @Level2 = 0
   , @Level3 = 50000;