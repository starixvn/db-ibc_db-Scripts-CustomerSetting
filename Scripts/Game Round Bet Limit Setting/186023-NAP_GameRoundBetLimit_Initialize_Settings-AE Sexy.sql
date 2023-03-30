/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator:	20230330@Robert
	Task:	AE Sexy - Global Game Round Bet Limit - Incorporate Extra Sicbo, Thai Hi lo, Thai Fish Prawn Crab, Extra Andar Bahar [186023]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20230330@Robert:	AE Sexy - Global Game Round Bet Limit - Incorporate Extra Sicbo, Thai Hi lo, Thai Fish Prawn Crab, Extra Andar Bahar [186023]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/


EXEC NAP_GameRoundBetLimit_Initialize_Settings 
	@ProductID = 45
   , @SportType = 243
   , @BettypeIDs = '3106,3107,3108,3109'
   , @BetLimits = '200000,200000,200000,200000';

