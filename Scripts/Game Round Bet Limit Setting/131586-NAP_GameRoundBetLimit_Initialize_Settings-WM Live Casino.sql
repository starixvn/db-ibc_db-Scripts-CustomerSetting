/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator:	20220531@Robert
	Task:	Global Game Round Bet Limit - Virtual Games - Incorporate 6 new games of Mine & Tower scheme [169418]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20220531@Robert:	Global Game Round Bet Limit - Virtual Games - Incorporate 6 new games of Mine & Tower scheme [169418]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

-- Integrate Virtual Games
EXEC NAP_GameRoundBetLimit_Initialize_Settings 
	@ProductID = 38
   , @SportType = 245
   , @BettypeIDs = '4605,4606,4607,4608,4609,4610'
   , @BetLimits = '300000,300000,300000,300000,300000,300000';

-- Integrate WM
EXEC NAP_GameRoundBetLimit_Initialize_Settings 
	@ProductID = 51
   , @SportType = 233
   , @BettypeIDs = '3412,3413'
   , @BetLimits = '100000,100000';

