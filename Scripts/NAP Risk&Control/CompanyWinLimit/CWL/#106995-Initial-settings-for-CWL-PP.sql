/*
	Creator:	20190107@Robert
	Task:	Initial settings for CWL - Add new PP games into CWL system [106995]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20190107@Robert:	Initial settings  - [Redmine: #106995]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 32, 
	@BetTypeID_Begin = 0, 
	@BetTypeID_End = 0, 
	@BettypeIds = '4175,4176,4177,4178',
	@GroupID = 16, 
	@GroupName = 'PP', 
	@Level101 = -10000, 
	@Level102 = -30000, 
	@Level1 = 10000, 
	@Level2 = 30000, 
	@Level3 = 100000,
	@IsBlockedTransfer_DepositSite_Level3 = 1; 
	


	