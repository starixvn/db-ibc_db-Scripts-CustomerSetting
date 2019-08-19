/*
	Creator:	20190717@Robert
	Task:	CWL - Support to update PP setting
	Database:	DBCUST.CustDB	
	Revisions:
		- 20190717@Robert:	Initial settings  - [Redmine: #117131]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Update_Settings
	@ProductId = 32
   , @GroupId = 16
   , @Level1 = 20000
   , @Level2 = 50000
   , @Level3 = 100000
   , @Level101 = -20000
   , @Level102 = -50000;