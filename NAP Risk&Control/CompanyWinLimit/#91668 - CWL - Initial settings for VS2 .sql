/*
	Creator:	20180424@Robert
	Task:	Initial settings for CWL - Betradar VS - [Redmine: #91668]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20180424@Robert:	Initial settings  - [Redmine: #91668]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 27, 
	@BetTypeID_Begin = 0, 
	@BetTypeID_End = 0, 
	@BettypeIDs = '2801,2802,2803,2804,2805,2806,2807,2808,2809,2811,2812', 
	@GroupID = 12, 
	@GroupName = 'Virtual Sports 2', 
	@Level1 = 100000, 
	@Level2 = 300000, 
	@Level3 = 500000, 
	@Level101 = -100000, 
	@Level102 = -300000;