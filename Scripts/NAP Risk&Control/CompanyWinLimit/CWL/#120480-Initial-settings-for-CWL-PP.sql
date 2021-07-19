/*
	Creator:	20190930@Robert
	Task:	Initial settings for CWL - Add new PP games into CWL system [120480]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20190930@Robert:	Initial settings  - [Redmine: #120480]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings
	@ProductID = 32
   , @BetTypeID_Begin = 0
   , @BetTypeID_End = 0
   , @BettypeIds = '4190,4191,4192,4193,4194,4195,4196,4197'
   , @GroupID = 16
   , @GroupName = 'PP - Normal Games'
   , @Level101 = -20000
   , @Level102 = -50000
   , @Level1 = 20000
   , @Level2 = 50000
   , @Level3 = 100000
   , @IsBlockedTransfer_DepositSite_Level3 = 1;