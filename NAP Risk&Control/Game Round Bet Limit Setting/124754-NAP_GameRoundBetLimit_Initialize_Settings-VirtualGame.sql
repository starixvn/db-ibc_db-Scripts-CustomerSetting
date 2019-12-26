/*
	Creator:	20191226@Robert
	Task:	Risk & Control - Game Round Bet Limit - Integrate Virtual Games [#124754]				
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20191226@Robert:	Risk & Control - Game Round Bet Limit - Integrate Virtual Games [#124754]				
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

  EXEC NAP_GameRoundBetLimit_Initialize_Settings 
         @ProductID = 38, 
         @SportType = 245, 
         @BettypeIDs = '4601,4602,4603,4604', 
         @BetLimits = '300000,300000,300000,300000'       

