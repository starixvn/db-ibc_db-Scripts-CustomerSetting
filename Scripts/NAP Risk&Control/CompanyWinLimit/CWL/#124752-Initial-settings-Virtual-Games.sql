/*
	Creator:	20200225@Robert
	Task:	Initial settings for #124752 - CWL - Integrate Virtual Games
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20200225@Robert:	Initial settings for #124752 - CWL - Integrate Virtual Games
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 38
   , @BetTypeID_Begin = 0
   , @BetTypeID_End = 0
   , @BettypeIDs = '4601,4602,4603,4604'
   , @RepresentativeBettype = 4601
   , @GroupID = 24
   , @GroupName = 'Virtual Games'
   , @Level101 = -100000
   , @Level102 = -300000
   , @Level1 = 100000
   , @Level2 = 300000
   , @Level3 = 500000
   , @IsBlockedTransfer_DepositSite_Level3 = 0;