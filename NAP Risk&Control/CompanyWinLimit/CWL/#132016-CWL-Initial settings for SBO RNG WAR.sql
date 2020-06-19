
/*
	Creator:	20200610@Robert
	Task:	Initial settings CWL - Integrate 5 new Spadegaming games [#132016]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20200610@Robert:	Initial settings CWL - #132016 - CWL - Integrate SBO RNG WAR
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 50, 
     @BetTypeID_Begin = 0, 
     @BetTypeID_End = 0, 
     @BettypeIDs = '5500', 
     @GroupID = 32, 
     @GroupName = 'RNG War', 
     @Level101 = -100000, 
     @Level102 = -300000, 
     @Level1 = 100000, 
     @Level2 = 300000, 
     @Level3 = 500000,      
     @RepresentativeBettype = 5500;	 