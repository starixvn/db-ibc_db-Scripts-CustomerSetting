
/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator:	20201125@Robert
	Task:	Initial settings for CWL - Arcadia Gaming Add Bettype Bonus [143662]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20201125@Robert:	Initial settings  - [Redmine: #143662]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

/*#143662 - CWL - Arcadia Gaming Add Bettype Bonus*/
EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 34, 
     @BetTypeID_Begin = 0, 
     @BetTypeID_End = 0, 
     @BettypeIds = '1906', 
     @GroupID = 21, 
     @GroupName = 'Arcadia Gaming', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;



/*#145672 - CWL - Integrate 41 new PG Soft games (6021 to 6061)*/
EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 55, 
     @BetTypeID_Begin = 6021, 
     @BetTypeID_End = 6061, 
     @BettypeIds = '', 
     @GroupID = 34, 
     @GroupName = 'PG Soft', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;


	 