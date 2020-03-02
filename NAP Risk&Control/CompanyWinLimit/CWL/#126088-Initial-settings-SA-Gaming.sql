/*
	Creator:	20200225@Robert
	Task:	Initial settings for #126088 - CWL - Integrate SA Gaming
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20200225@Robert:	Initial settings for #126088 - CWL - Integrate SA Gaming
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 39
   , @BetTypeID_Begin = 0
   , @BetTypeID_End = 0
   , @BettypeIDs = '3001,3002,3003,3004,3005,3006'
   , @RepresentativeBettype = 3001
   , @GroupID = 25
   , @GroupName = 'SA Gaming'
   , @Level101 = -100000
   , @Level102 = -300000
   , @Level1 = 100000
   , @Level2 = 300000
   , @Level3 = 500000
   , @IsBlockedTransfer_DepositSite_Level3 = 0;

   