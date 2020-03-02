/*
	Creator:	20200225@Robert
	Task:	Initial settings for #124752 - CWL - Integrate Virtual Games
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20200225@Robert:	Change settings for #124752 - CWL - Integrate Virtual Games
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Update_Settings 
	@ProductId = 38
   , @GroupId = 24
   , @Level101 = -20000
   , @Level102 = -50000
   , @Level1 = 20000
   , @Level2 = 50000
   , @Level3 = 100000;