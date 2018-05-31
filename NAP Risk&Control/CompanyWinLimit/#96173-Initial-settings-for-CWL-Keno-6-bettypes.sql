/*
	Creator:	20180530@Robert
	Task:	Initial settings for CWL - Keno- Add new bet types and update setting for Macau Games, MG RNG, OneRNG [#96173]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20180424@Robert:	Initial settings  - [Redmine: #96173]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 8, 
	@BetTypeID_Begin = 0, 
	@BetTypeID_End = 0, 
	@BettypeIds = '1517,1524,1519,1520,1521,1522',
	@GroupID = 4, 
	@GroupName = 'Keno', 
	@Level101 = -100000, 
	@Level102 = -300000, 
	@Level1 = 100000, 
	@Level2 = 300000, 
	@Level3 = 500000, 
	@IsBlockedTransfer_DepositSite_Level3 = 0;


