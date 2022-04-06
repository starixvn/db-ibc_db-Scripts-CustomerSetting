
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20220305@Robert
	Task:	CWL - PG Soft - Add 9 new games
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20220305@Robert:	CWL - PG Soft - Add 9 new games
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

/*169833 - CWL - PG Soft - Add 9 new games - correct setting INH,RMB */

EXEC NAP_CWL_Update_Settings 
	@ProductId = 55, 
	@GroupId = 34, 
	@Level101 = -20000, 
	@Level102 = -50000, 
	@Level1 = 5000, 
	@Level2 = 30000, 
	@Level3 = 75000, 
	@Currency = 'INH,RMB';

