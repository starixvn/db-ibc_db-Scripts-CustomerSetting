/*
	Creator:	20190321@Robert
	Task:	Initial settings for CWL - Add new PP games into CWL system [109202]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20190107@Robert:	Initial settings  - [Redmine: #109202]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

UPDATE Winlimit_Group WITH(ROWLOCK, UPDLOCK)
	  SET
		 GroupName = 'PP - Normal Games'
WHERE GroupID = 16;

UPDATE Winlimit_ProductGlobalSetting WITH(ROWLOCK, UPDLOCK)
	  SET
		 GroupName = 'PP - Normal Games'
WHERE GroupID = 16;



EXEC NAP_CWL_Initialize_Settings
	@ProductID = 32
   , @BetTypeID_Begin = 0
   , @BetTypeID_End = 0
   , @BettypeIds = '4300'
   , @GroupID = 20
   , @GroupName = 'PP - Promotion Prize'
   , @Level101 = 0
   , @Level102 = 0
   , @Level1 = 0
   , @Level2 = 0
   , @Level3 = 1
   , @IsBlockedTransfer_DepositSite_Level3 = 1;