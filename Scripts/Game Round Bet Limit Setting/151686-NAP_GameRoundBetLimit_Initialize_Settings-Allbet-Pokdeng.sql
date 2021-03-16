/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator:	20210315@Robert
	Task:	Global Game Round Bet Limit - Integrate Allbet Pokdeng [151686]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20210315@Robert:	Global Game Round Bet Limit - Integrate Allbet Pokdeng [151686]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

-- Integrate WM Live Casino
EXEC NAP_GameRoundBetLimit_Initialize_Settings 
	@ProductID = 21
   , @SportType = 211
   , @BettypeIDs = '2408'
   , @BetLimits = '200000';

