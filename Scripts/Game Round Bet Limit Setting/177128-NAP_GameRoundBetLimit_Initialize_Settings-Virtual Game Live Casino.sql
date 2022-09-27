/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator:	20220919@Robert
	Task:	Global Game Round Bet Limit - Virtual Games - Incorporate 4 new Live Casino Games 4611-4614 [177128]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20220919@Robert:	Global Game Round Bet Limit - Virtual Games - Incorporate 4 new Live Casino Games 4611-4614 [177128]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

-- Integrate Virtual Games
EXEC NAP_GameRoundBetLimit_Initialize_Settings 
	@ProductID = 38
   , @SportType = 245
   , @BettypeIDs = '4611,4612,4613,4614'
   , @BetLimits = '300000,300000,300000,300000';

   