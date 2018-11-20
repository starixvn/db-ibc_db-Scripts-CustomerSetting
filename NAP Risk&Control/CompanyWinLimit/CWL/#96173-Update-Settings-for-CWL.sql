/*
	Creator:	20180531@Robert
	Task:	Update settings for CWL - [RNG Casino - Normal Games, Microgaming - RNG Casino, Macau Games] [#96173]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20180531@Robert:	Update settings  - [Redmine: #96173]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/
/*-----------BEGIN RNG Casino - Normal Games ---------------*/

EXEC NAP_CWL_Update_Settings
	@ProductId = 6
   , @GroupId = 3
   , @Level1 = 20000
   , @Level2 = 50000
   , @Level3 = 100000
   , @Level101 = -20000
   , @Level102 = -50000;
/*-----------END RNG Casino - Normal Games ---------------*/
/*-----------BEGIN Microgaming - RNG Casino ---------------*/

EXEC NAP_CWL_Update_Settings
	@ProductId = 17
   , @GroupId = 7
   , @Level1 = 20000
   , @Level2 = 50000
   , @Level3 = 100000
   , @Level101 = -20000
   , @Level102 = -50000;
/*-----------END Microgaming - RNG Casino ---------------*/
/*-----------BEGIN Macau Games ---------------*/

EXEC NAP_CWL_Update_Settings
	@ProductId = 22
   , @GroupId = 10
   , @Level1 = 20000
   , @Level2 = 50000
   , @Level3 = 100000
   , @Level101 = -20000
   , @Level102 = -50000;
/*-----------END Macau Games ---------------*/