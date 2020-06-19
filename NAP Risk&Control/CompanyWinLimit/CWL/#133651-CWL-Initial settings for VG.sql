
/*
	Creator:	20200514@Robert
	Task:	CWL - VG - Integrate Xocdia new game [#133651]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20200429@Robert:	Initial settings CWL - VG - Integrate Xocdia new game [#133651]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 38, 
     @BetTypeID_Begin = 0, 
     @BetTypeID_End = 0, 
     @BettypeIDs = '4602', 
     @GroupID = 24, 
     @GroupName = 'Virtual Games', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000,      
     @RepresentativeBettype = 4601;

	 