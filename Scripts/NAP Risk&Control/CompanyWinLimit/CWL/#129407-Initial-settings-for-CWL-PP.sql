/*
	Creator:	20200310@Robert
	Task:	Initial settings for CWL - Add new PP games into CWL system [129407]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20200310@Robert:	Initial settings  - [Redmine: #129407]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings
	@ProductID = 32
   , @BetTypeID_Begin = 0
   , @BetTypeID_End = 0
   , @BettypeIds = '4203,4204,4205,4206,4207,4208,4209,4210,4211'
   , @GroupID = 16
   , @GroupName = 'PP - Normal Games'
   , @Level101 = -20000
   , @Level102 = -50000
   , @Level1 = 20000
   , @Level2 = 50000
   , @Level3 = 100000
   , @IsBlockedTransfer_DepositSite_Level3 = 1
   , @RepresentativeBettype = 4001


   