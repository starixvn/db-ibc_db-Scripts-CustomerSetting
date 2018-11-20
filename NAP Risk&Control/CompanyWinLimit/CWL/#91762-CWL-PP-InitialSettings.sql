/*
	Creator:	20180424@Robert
	Task:	Initial settings for CWL - Pragmatic Integration - [Redmine: #91762]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20180424@Robert:	Initial settings  - [Redmine: #91762]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings
	@ProductID = 32
   , @BetTypeID_Begin = 4101
   , @BetTypeID_End = 4122
   , @GroupID = 16
   , @GroupName = 'PP'
   , @Level101 = -10000
   , @Level102 = -30000
   , @Level1 = 10000
   , @Level2 = 30000
   , @Level3 = 100000
   , @IsBlockedTransfer_DepositSite_Level3 = 1;