
/*
	Creator:	20200428@Robert
	Task:	Global Game Round Bet Limit - Integrate IBCBet Live Casino [#130686]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20200428@Robert:	Risk & Control - Global Game Round Bet Limit - Integrate IBCBet Live Casino [#130686]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_GameRoundBetLimit_Initialize_Settings 
     @ProductID = 46, 
     @SportType = 242, 
     @BettypeIDs = '3201,3202,3203,3204,3205', 
     @BetLimits = '200000,200000,200000,200000,200000';