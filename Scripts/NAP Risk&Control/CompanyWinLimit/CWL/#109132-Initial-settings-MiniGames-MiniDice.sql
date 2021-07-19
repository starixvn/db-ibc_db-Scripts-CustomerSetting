/*
	Creator:	20190220@Robert
	Task:	Initial settings for CWL - CWL - Integrate Mini Games - Mini Dice - [Redmine: #109132]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20190220@Robert:	Initial settings  - [Redmine: #109132]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings
	@ProductID = 6
   , @BetTypeID_Begin = 0
   , @BetTypeID_End = 0
   , @BettypeIDs = '2207'
   , @GroupID = 3
   , @GroupName = 'RNG Casino - Normal Games'
   , @IsBlockedTransfer_DepositSite_Level1 = 1
   , @IsBlockedTransfer_DepositSite_Level2 = 1
   , @IsBlockedTransfer_DepositSite_Level3 = 1
   , @IsBlockedTransfer_DepositSite_Level101 = 1
   , @IsBlockedTransfer_DepositSite_Level102 = 1
   , @Level101 = -20000
   , @Level102 = -50000
   , @Level1 = 20000
   , @Level2 = 50000
   , @Level3 = 100000;