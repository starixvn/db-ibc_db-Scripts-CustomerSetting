/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator:	20201028@Robert
	Task:	Global Game Round Bet Limit - Integrate WM Live Casino [131586]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20201028@Robert:	Global Game Round Bet Limit - Integrate WM Live Casino [131586]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

-- Integrate WM Live Casino
EXEC NAP_GameRoundBetLimit_Initialize_Settings 
	@ProductID = 51
   , @SportType = 233
   , @BettypeIDs = '3401,3402,3403,3404,3405,3406,3407,3408,3409,3410,3411'
   , @BetLimits = '200000,200000,200000,200000,200000,200000,200000,200000,200000,200000,200000';

