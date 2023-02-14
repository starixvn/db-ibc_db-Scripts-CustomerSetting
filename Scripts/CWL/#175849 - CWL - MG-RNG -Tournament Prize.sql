
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20220927@Robert
	Task:	CWL - Microgaming RNG - Slot Games Integration [175849]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20220927@Robert:	CWL - Microgaming RNG - Slot Games Integration [175849]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

/*1. CWL - SEAL Entertainment - Incorporate new product [175849]*/
EXEC NAP_CWL_Initialize_Settings 
    @ProductID = 73, 
    @BetTypeID_Begin = 0, 
    @BetTypeID_End = 0, 
    @BettypeIds = '8695', 
    @GroupID = 57, 
    @GroupName = 'MG-RNG Tournament Prize', 
    @Level101 = 0, 
    @Level102 = 0, 
    @Level1 = 0, 
    @Level2 = 1, 
    @Level3 = 0,     
    @RepresentativeBettype = 8400,
    @Currency = ''
    	  
