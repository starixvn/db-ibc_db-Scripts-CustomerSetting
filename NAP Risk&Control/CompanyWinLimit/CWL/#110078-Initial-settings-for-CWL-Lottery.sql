/*
	Creator:	20190321@Robert
	Task:	Initial settings for CWL - Add new Allbet games into CWL system [110078]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20190107@Robert:	Initial settings  - [Redmine: #110078]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings
	@ProductID = 28
   , @BetTypeID_Begin = 0
   , @BetTypeID_End = 0
   , @BettypeIds = '1039,1040,1041,1042,1043,1044,1045,1046,1047,1048'
   , @GroupID = 13
   , @GroupName = 'Lottery'
   , @Level101 = -100000
   , @Level102 = -300000
   , @Level1 = 100000
   , @Level2 = 300000
   , @Level3 = 500000;