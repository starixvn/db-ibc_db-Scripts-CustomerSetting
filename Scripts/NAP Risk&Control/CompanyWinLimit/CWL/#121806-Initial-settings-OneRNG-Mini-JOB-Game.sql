/*
	Creator:	20191011@Robert
	Task:	Initial settings for CWL - Integrate OneRNG Mini JOB Game - [Redmine: #121806]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20191011@Robert:	Initial settings  - [Redmine: #121806]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings
	@ProductID = 6
   , @BetTypeID_Begin = 0
   , @BetTypeID_End = 0
   , @BettypeIDs = '2208'
   , @GroupID = 3
   , @GroupName = 'RNG Casino - Normal Games'
   , @Level101 = -20000
   , @Level102 = -50000
   , @Level1 = 20000
   , @Level2 = 50000
   , @Level3 = 100000
   , @IsBlockedTransfer_DepositSite_Level3 = 1;


   