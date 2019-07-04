/*
	Creator:	20190709@Robert
	Task:	Initial settings for CWL - Macau Games - CWL Integration - [Redmine: #116541]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20180424@Robert:	Initial settings  - [Redmine: #116541]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings
	@ProductID = 22
   , @BetTypeID_Begin = 0
   , @BetTypeID_End = 0
   , @BettypeIDs = '4038,4039,4040,4041,4042,4043'
   , @GroupID = 10
   , @GroupName = 'Macau Games'
   , @Level101 = -20000
   , @Level102 = -50000
   , @Level1 = 20000
   , @Level2 = 50000
   , @Level3 = 100000
   , @IsBlockedTransfer_DepositSite_Level3 = 1;