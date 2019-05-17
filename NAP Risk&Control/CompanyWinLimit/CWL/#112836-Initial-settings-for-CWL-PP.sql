/*
	Creator:	20190517@Robert
	Task:	Initial settings for CWL - Add new PP games into CWL system [113414]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20190517@Robert:	Initial settings  - [Redmine: #113414]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings
	@ProductID = 32
   , @BetTypeID_Begin = 0
   , @BetTypeID_End = 0
   , @BettypeIds = '4179,4180,4181,4182,4183,4184,4185,4186'
   , @GroupID = 16
   , @GroupName = 'PP - Normal Games'
   , @Level101 = -10000
   , @Level102 = -30000
   , @Level1 = 10000
   , @Level2 = 30000
   , @Level3 = 100000
   , @IsBlockedTransfer_DepositSite_Level3 = 1;