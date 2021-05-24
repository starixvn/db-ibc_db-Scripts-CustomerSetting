/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20210524@Robert
	Task:	Change settings for #154955 - CWL - Joker
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20210524@Robert:	Change settings for #154955 - CWL - Joker
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

/*1. #154955 - CWL - Joker*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 56, 
     @BetTypeID_Begin = 6413, 
     @BetTypeID_End = 6415, 
     @BettypeIds = '', 
     @GroupID = 36, 
     @GroupName = 'Joker', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;

/*2. CWL - Spadegaming - Incorporate 10 new games #144175*/	 
EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 36, 
     @BetTypeID_Begin = 0, 
     @BetTypeID_End = 0, 
     @BettypeIds = '4310,4345,4346,4347,4348,4349,4350,4351,4352,4353,4326', 
     @GroupID = 22, 
     @GroupName = 'SG', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;



 

