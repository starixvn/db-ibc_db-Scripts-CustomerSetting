/*
	Creator:	20181120@Robert
	Task:	Initial settings for CWL - Happy 5 Integration[#103496]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20181120@Robert:	Initial settings  - [Redmine: #103496]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 3, 
	@BetTypeID_Begin = 0, 
	@BetTypeID_End = 0, 
	@BettypeIds = '8101,8102,8103,8104,8105',
	@GroupID = 1, 
	@GroupName = 'Number Game', 
	@Level101 = -100000, 
	@Level102 = -300000, 
	@Level1 = 100000, 
	@Level2 = 300000, 
	@Level3 = 500000 
	


	