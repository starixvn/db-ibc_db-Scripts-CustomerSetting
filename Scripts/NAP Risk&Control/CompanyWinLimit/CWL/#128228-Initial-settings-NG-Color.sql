/*
	Creator:	20200225@Robert
	Task:	Initial settings for #128228 - CWL - Integrate NG Color Ball
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20200225@Robert:	Initial settings for #128228 - CWL - Integrate NG Color Ball
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 3
   , @BetTypeID_Begin = 0
   , @BetTypeID_End = 0
   , @BettypeIDs = '91'
   , @RepresentativeBettype = 81
   , @GroupID = 1
   , @GroupName = 'Number Game'
   , @Level101 = -100000
   , @Level102 = -300000
   , @Level1 = 100000
   , @Level2 = 300000
   , @Level3 = 500000
   , @IsBlockedTransfer_DepositSite_Level3 = 0;

   