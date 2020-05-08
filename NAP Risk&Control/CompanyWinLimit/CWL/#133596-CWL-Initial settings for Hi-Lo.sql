
/*
	Creator:	20200514@Robert
	Task:	CWL - Integrate Midas Hi-Lo Game [#133596]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20200514@Robert:	CWL - Integrate Midas Hi-Lo Game [#133596]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/
/*
1. CWL - Integrate Midas Hi-Lo Game #133596
*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 34, 
     @BetTypeID_Begin = 0, 
     @BetTypeID_End = 0, 
     @BettypeIDs = '1905', 
     @GroupID = 21, 
     @GroupName = 'Card Club', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;

/*
2. CWL - Integrate SBO ION Live Casino #132328
*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 52, 
     @BetTypeID_Begin = 5601, 
     @BetTypeID_End = 5604, 
     @BettypeIDs = '', 
     @GroupID = 31, 
     @GroupName = 'ION', 
     @Level101 = -100000, 
     @Level102 = -300000, 
     @Level1 = 100000, 
     @Level2 = 300000, 
     @Level3 = 500000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 5601;
