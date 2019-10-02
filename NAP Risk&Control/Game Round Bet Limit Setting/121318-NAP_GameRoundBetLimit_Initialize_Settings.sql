/*
	Creator:	20191001@Robert
	Task:	Risk & Control - Implement Global Game Round Bet Limit Setting for Allbet Bull Bull [#121318]				
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20191001@Robert:	Risk & Control - Implement Global Game Round Bet Limit Setting for Allbet Bull Bull [#121318]				
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

  EXEC NAP_GameRoundBetLimit_Initialize_Settings 
         @ProductID = 21, 
         @SportType = 211, 
         @BettypeIDs = '2407', 
         @BetLimits = '200000'       