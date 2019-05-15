/*
	Creator:	20190321@Robert
	Task:	Initial settings for CWL - Add new Allbet games into CWL system [109773]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20190107@Robert:	Initial settings  - [Redmine: #109773]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings
	@ProductID = 21
   , @BetTypeID_Begin = 0
   , @BetTypeID_End = 0
   , @BettypeIds = '2406'
   , @GroupID = 9
   , @GroupName = 'Allbet Casino'
   , @Level101 = -100000
   , @Level102 = -300000
   , @Level1 = 100000
   , @Level2 = 300000
   , @Level3 = 500000;