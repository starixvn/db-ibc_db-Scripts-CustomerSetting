/*
	Creator:	20191226@Robert
	Task:	Risk & Control - Game Round Bet Limit - Integrate Virtual Games [#124754, 126090]				
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20191226@Robert:	Risk & Control - Game Round Bet Limit - Integrate Virtual Games [#124754, 126090]				
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

-- Virtual Games
EXEC NAP_GameRoundBetLimit_Initialize_Settings 
	@ProductID = 38
   , @SportType = 245
   , @BettypeIDs = '4601,4602,4603,4604'
   , @BetLimits = '300000,300000,300000,300000';

-- SA Gaming
EXEC NAP_GameRoundBetLimit_Initialize_Settings 
	@ProductID = 39
   , @SportType = 244
   , @BettypeIDs = '3001,3002,3003,3004,3005,3006'
   , @BetLimits = '200000,200000,200000,200000,200000,200000';