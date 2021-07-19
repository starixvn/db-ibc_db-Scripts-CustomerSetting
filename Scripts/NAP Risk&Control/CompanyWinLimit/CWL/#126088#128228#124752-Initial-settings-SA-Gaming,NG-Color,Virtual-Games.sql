/*
	Creator:	20200225@Robert
	Task:	Initial settings for #126088 - CWL - Integrate SA Gaming
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20200225@Robert:	Initial settings for #126088 - CWL - Integrate SA Gaming
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 39
   , @BetTypeID_Begin = 0
   , @BetTypeID_End = 0
   , @BettypeIDs = '3001,3002,3003,3004,3005,3006'
   , @RepresentativeBettype = 3001
   , @GroupID = 25
   , @GroupName = 'SA Gaming'
   , @Level101 = -100000
   , @Level102 = -300000
   , @Level1 = 100000
   , @Level2 = 300000
   , @Level3 = 500000
   , @IsBlockedTransfer_DepositSite_Level3 = 0;
/*------------------------------------------------------------------------------------------------------------*/
/*
	Creator:	20200225@Robert
	Task:	Initial settings for #124752 - CWL - Integrate Virtual Games
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20200225@Robert:	Initial settings for #124752 - CWL - Integrate Virtual Games
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 38
   , @BetTypeID_Begin = 0
   , @BetTypeID_End = 0
   , @BettypeIDs = '4601,4602,4603,4604'
   , @RepresentativeBettype = 4601
   , @GroupID = 24
   , @GroupName = 'Virtual Games'
   , @Level101 = -100000
   , @Level102 = -300000
   , @Level1 = 100000
   , @Level2 = 300000
   , @Level3 = 500000
   , @IsBlockedTransfer_DepositSite_Level3 = 0;
/*------------------------------------------------------------------------------------------------------------*/
/*
	Creator:	20200225@Robert
	Task:	Initial settings for #128228 - CWL - Integrate NG Color Ball
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20200225@Robert:	Initial settings for #128228 - CWL - Integrate NG Color Ball
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 3
   , @BetTypeID_Begin = 0
   , @BetTypeID_End = 0
   , @BettypeIDs = '91'
   , @RepresentativeBettype = 81
   , @GroupID = 1
   , @GroupName = 'Number Game'
   , @Level101 = -100000
   , @Level102 = -300000
   , @Level1 = 100000
   , @Level2 = 300000
   , @Level3 = 500000
   , @IsBlockedTransfer_DepositSite_Level3 = 0;
/*------------------------------------------------------------------------------------------------------------*/


/*
	Creator:	20200225@Robert
	Task:	#122453 - Del 2 bettypes [4313, 4326] settings for Spadegaming 
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20200225@Robert:	#122453 - Del 2 bettypes [4313, 4326] settings for Spadegaming 
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

DELETE w
FROM Winlimit_GameGroupSetting w
WHERE w.ProductID = 36
	 AND w.BetTypeID IN(4313, 4326);