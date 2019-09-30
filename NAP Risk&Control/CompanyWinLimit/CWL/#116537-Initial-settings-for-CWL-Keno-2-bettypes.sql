/*
	Creator:	20190819@Robert
	Task:	Initial settings for CWL - Keno- Add new bet types [#116537]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20180424@Robert:	Initial settings  - [Redmine: #116537]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 8, 
	@BetTypeID_Begin = 0, 
	@BetTypeID_End = 0, 
	@BettypeIds = '1525,1526',
	@GroupID = 4, 
	@GroupName = 'Keno', 
	@Level101 = -100000, 
	@Level102 = -300000, 
	@Level1 = 100000, 
	@Level2 = 300000, 
	@Level3 = 500000, 
	@IsBlockedTransfer_DepositSite_Level3 = 0;


