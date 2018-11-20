/*
	Creator:	20181025@Robert
	Task:	Initial settings for CWL - CWL - GD Sicbo & Bidme integration[103495]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20181025@Robert:	Initial settings  - [Redmine: #103495]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 12, 
	@BetTypeID_Begin = 0, 
	@BetTypeID_End = 0, 
	@BettypeIds = '1704,1705',
	@GroupID = 5, 
	@GroupName = 'Gold Deluxe', 
	@Level101 = -100000, 
	@Level102 = -300000, 
	@Level1 = 100000, 
	@Level2 = 300000, 
	@Level3 = 500000 
	


	