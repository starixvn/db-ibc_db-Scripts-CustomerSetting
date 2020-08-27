
/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator:	20200827@Robert
	Task:	CWL - Update setting for Saba.Club [140488]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20200827@Robert:	CWL - Update setting for Saba.Club [140488]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Update_Settings 
     @ProductId = 42, 
     @GroupId = 28, 
     @Level101 = -50000, 
     @Level102 = -100000, 
     @Level1 = 50000, 
     @Level2 = 100000, 
     @Level3 = 200000;