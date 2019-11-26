/*
	Creator:	20191126@Robert
	Task:	Initial settings for CWL - Integrate Pragmatic Tournament and 5 new games - [Redmine: #123659]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20191126@Robert:	Initial settings for CWL - Integrate Pragmatic Tournament and 5 new games - [Redmine: #123659]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 32
   , @BetTypeID_Begin = 0
   , @BetTypeID_End = 0
   , @BettypeIDs = '4198,4199,4200,4201,4202'
   , @RepresentativeBettype = 4001
   , @GroupID = 16
   , @GroupName = 'PP - Normal Games'
   , @Level101 = -20000
   , @Level102 = -50000
   , @Level1 = 20000
   , @Level2 = 50000
   , @Level3 = 100000
   , @IsBlockedTransfer_DepositSite_Level3 = 1;

GO

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 32
   , @BetTypeID_Begin = 0
   , @BetTypeID_End = 0
   , @BettypeIDs = '4299'
   , @RepresentativeBettype = 4001
   , @GroupID = 23
   , @GroupName = 'PP - Tournament Prize'
   , @Level101 = 0
   , @Level102 = 0
   , @Level1 = 0
   , @Level2 = 1
   , @Level3 = 0;

