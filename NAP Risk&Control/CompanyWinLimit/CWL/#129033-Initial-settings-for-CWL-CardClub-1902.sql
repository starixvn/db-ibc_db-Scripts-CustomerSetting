/*
	Creator:	20200314@Robert
	Task:	Initial settings for CWL - Add new Card Club games into CWL system [129033]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20200314@Robert:	Initial settings  - [Redmine: #129033]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings
	@ProductID = 34
   , @BetTypeID_Begin = 0
   , @BetTypeID_End = 0
   , @BettypeIds = '1902'
   , @GroupID = 21
   , @GroupName = 'Card Club'
   , @Level101 = -20000
   , @Level102 = -50000
   , @Level1 = 20000
   , @Level2 = 50000
   , @Level3 = 100000
   , @IsBlockedTransfer_DepositSite_Level3 = 1
   , @RepresentativeBettype = 4001


   

